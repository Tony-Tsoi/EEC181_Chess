module squareUnit (irrdi, irrui, irddi, irdi, iri, irui, iruui, idi, iui, 
ilddi, ildi, ili, ilui, iluui, illdi, illui,
orrdo, orruo, orddo, ordo, oro, oruo, oruuo, odo, ouo, 
olddo, oldo, olo, oluo, oluuo, olldo, olluo,
hlu, hl, hld, hu, hd, hru, hr, hrd,
clk, xpos, ypos, cpiece, reset, done, fifoOut, fifoEmpty, hold, rden);

// 19 bit output per move from fifoOut has the following format:
// [7b flag][6b from][6b to]
// seven bit flag bits as follows:
// [invalid][promote][pawn move][pawn 2 sq][en passant][castle][capture]

// inputs and outputs to neighbor cells
// 9 bits of the format of [6 bits origin pos][3 bits of piece info]
// 1 bit of color is omitted since only white pieces can propagate

// === Parameter declarations ===
parameter WHITE = 1'b0;
parameter BLACK = 1'b1;
parameter EMPTY = 3'o0;
parameter PAWN = 3'o1;
parameter KNIGHT = 3'o2;
parameter BISHOP = 3'o3;
parameter ROOK = 3'o4;
parameter QUEEN = 3'o5;
parameter KING = 3'o6;
parameter NOTUSED = 3'o7;
parameter ROW2 = 3'o1;
parameter ROW3 = 3'o2; // value for ypos to be at row 3 (for pawn advance two blocks forward
parameter ROW4 = 3'o3;
parameter ROW8 = 3'o7;

parameter IMOV = {1'b1, 6'b000000, 6'o00, 6'o00}; // invalid move

// state bits
parameter RSET = 3'b000; // reset 
parameter GENC = 3'b001; // generate
parameter PROC = 3'b011; // propagate
parameter GKNI = 3'b111; // get knight moves
parameter DONE = 3'b110; // done

reg [2:0] state, state_c;

// === Input declarations ===
input clk, reset, hold, rden;
input [2:0] xpos, ypos; // specifies the position of the unit on the board
input [3:0] cpiece; // current piece occupied at this spot
input [8:0] irrdi, irrui, irddi, irdi, iri, irui, iruui, idi, iui, 
	ilddi, ildi, ili, ilui, iluui, illdi, illui;

// === Output declarations ===
output fifoEmpty;
output [159:0] fifoOut; // output of FIFO
output reg done;
output reg hlu, hl, hld, hu, hd, hru, hr, hrd; // output hold signal
output reg [8:0] orrdo, orruo, orddo, ordo, oro, oruo, oruuo, odo, ouo, 
	olddo, oldo, olo, oluo, oluuo, olldo, olluo;

// === Reg declarations ===
// outgoing output variables combinational
reg [8:0] orrdo_c, orruo_c, orddo_c, ordo_c, oro_c, oruo_c, oruuo_c, odo_c, 
	ouo_c, olddo_c, oldo_c, olo_c, oluo_c, oluuo_c, olldo_c, olluo_c;

// Moves Output
reg [18:0] mvrrd, mvrru, mvrdd, mvruu, mvldd, mvluu, mvlld, mvllu;
reg [18:0] mvrd, mvr, mvru, mvd, mvu, mvld, mvl, mvlu;

reg done_c;

// === Wire declarations ===
wire [8:0] PVOID = {xpos, ypos, EMPTY}; // denotes an empty space at self
wire [151:0] wr1 = {mvrd, mvr, mvru, mvd, mvu, mvld, mvl, mvlu};
wire [151:0] wr2 = {mvrrd, mvrru, mvrdd, mvruu, mvldd, mvluu, mvlld, mvllu};
wire [151:0] wrdata = (state == GKNI) ? wr2 : wr1;
wire wren = ~&{wrdata[151], wrdata[132], wrdata[113], wrdata[94], wrdata[75], wrdata[56], wrdata[37], wrdata[18]};
wire [159:152] fillwr = 8'd0; // white space to accomodate width of fifo
wire hlu_c = (oluo_c != PVOID);
wire hl_c = (olo_c != PVOID);
wire hld_c = (oldo_c != PVOID);
wire hu_c = (ouo_c != PVOID);
wire hd_c = (odo_c != PVOID);
wire hru_c = (oruo_c != PVOID);
wire hr_c = (oro_c != PVOID);
wire hrd_c = (ordo_c != PVOID);
wire capb = ((cpiece[3] == BLACK) && (cpiece[2:0] != EMPTY)); // propagated piece can capture current square piece
wire pwpm = ((iui[2:0] == PAWN) && (ypos == ROW8)); // pawn promo bit
wire pwm2 = ((iui[2:0] == PAWN)&&(ypos == ROW4)); // pawn mov2 bit

// FIFO Module Declaration
Square_FIFO F1F0 (.clock(clk), .data({fillwr,wrdata}), .q(fifoOut), .wrreq(wren), .rdreq(rden), .empty(fifoEmpty), 
	.sclr((state == RSET)), .usedw(), .full());

// output logic
always @(*) begin
	// default state unchanged
	state_c = state;

	// default empty
	oluo_c = PVOID; olo_c = PVOID; oldo_c = PVOID; 
	ouo_c = PVOID; odo_c = PVOID;
	oruo_c = PVOID; oro_c = PVOID; ordo_c = PVOID;
	
	// default hold the knight signals
	olluo_c = olluo; olldo_c = olldo;
	oluuo_c = oluuo; olddo_c = olddo;
	oruuo_c = oruuo; orddo_c = orddo;
	orruo_c = orruo; orrdo_c = orrdo;
	
	// default invalid moves
	mvrrd = IMOV;	mvrru = IMOV; 	mvrdd = IMOV; 	mvruu = IMOV; 
	mvldd = IMOV; 	mvluu = IMOV; 	mvlld = IMOV; 	mvllu = IMOV;
	mvrd = IMOV; 	mvr = IMOV; 	mvru = IMOV; 	mvd = IMOV;
	mvu = IMOV;		mvld = IMOV; 	mvl = IMOV; 	mvlu = IMOV;
	
	// done signal
	done_c = done;
	
	case (state)
		RSET: begin
			state_c = GENC;
			
			olluo_c = PVOID; olldo_c = PVOID;
			oluuo_c = PVOID; olddo_c = PVOID;
			oruuo_c = PVOID; orddo_c = PVOID;
			orruo_c = PVOID; orrdo_c = PVOID;
			
			done_c = 1'b0;
		end
		GENC: begin
			// generate output current piece if it's ours (white)
			// since known only propagate white pieces, not sending white prefix
			// pad origin position before piece type
			state_c = PROC;
			
			if (cpiece[3] == WHITE) begin
				case (cpiece[2:0])
				PAWN: begin
					oluo_c = {xpos, ypos, PAWN};
					ouo_c = {xpos, ypos, PAWN};
					oruo_c = {xpos, ypos, PAWN};
				end
				KNIGHT: begin
					olluo_c = {xpos, ypos, KNIGHT};
					olldo_c = {xpos, ypos, KNIGHT};
					oluuo_c = {xpos, ypos, KNIGHT};
					olddo_c = {xpos, ypos, KNIGHT};
					oruuo_c = {xpos, ypos, KNIGHT};
					orddo_c = {xpos, ypos, KNIGHT};
					orruo_c = {xpos, ypos, KNIGHT};
					orrdo_c = {xpos, ypos, KNIGHT};
				end
				BISHOP: begin
					oluo_c = {xpos, ypos, BISHOP};
					oldo_c = {xpos, ypos, BISHOP};
					oruo_c = {xpos, ypos, BISHOP};
					ordo_c = {xpos, ypos, BISHOP};
				end
				ROOK: begin
					olo_c = {xpos, ypos, ROOK};
					ouo_c = {xpos, ypos, ROOK};
					odo_c = {xpos, ypos, ROOK};
					oro_c = {xpos, ypos, ROOK};
				end
				QUEEN, KING: begin
					oluo_c = {xpos, ypos, cpiece[2:0]};
					olo_c = {xpos, ypos, cpiece[2:0]};
					oldo_c = {xpos, ypos, cpiece[2:0]};
					ouo_c = {xpos, ypos, cpiece[2:0]};
					odo_c = {xpos, ypos, cpiece[2:0]};
					oruo_c = {xpos, ypos, cpiece[2:0]};
					oro_c = {xpos, ypos, cpiece[2:0]};
					ordo_c = {xpos, ypos, cpiece[2:0]};
				end
				default: begin end // EMPTY, NOTUSED case
				endcase
			end
		end
		PROC: begin // propagate + get moves
			// if no more hold, and finished propagate, move on to get knight case
			if ((hold == 1'b0) && (wren == 1'b0))
				state_c = GKNI;
			
			// RU and LU is available for non pawn to move in
			if (irui[2:0] != EMPTY) begin
				if ((cpiece[2:0] == EMPTY) && (irui[2:0] != PAWN)) begin
					mvru = {6'o00, capb, irui[8:3], xpos, ypos};
					
					if ((irui[2:0] == BISHOP) || (irui[2:0] == QUEEN))
						// if bishop or queen, propagate diag
						oruo_c = irui;
				end
				if ((capb) && (cpiece[2:0] != EMPTY) && (irui[2:0] != PAWN)) begin
					mvru = {6'o00, capb, irui[8:3], xpos, ypos};
				end
			end
			
			if (ilui[2:0] != EMPTY) begin
				if ((cpiece[2:0] == EMPTY) && (ilui[2:0] != PAWN)) begin
					mvlu = {6'o00, capb, ilui[8:3], xpos, ypos};
					
					if ((ilui[2:0] == BISHOP) || (ilui[2:0] == QUEEN))
						// if bishop or queen, propagate diag
						oluo_c = ilui;
				end
				if ((capb) && (cpiece[2:0] != EMPTY) && (ilui[2:0] != PAWN)) begin
					mvlu = {6'o00, capb, ilui[8:3], xpos, ypos};
				end
			end
			
			// U is available for pawn if empty
			if (iui[2:0] != EMPTY) begin
				if (cpiece[2:0] == EMPTY) begin
					mvu = {1'b0, pwpm, (iui[2:0] == PAWN), pwm2, 2'b00, capb, iui[8:3], xpos, ypos};
					
					if ((iui[2:0] == BISHOP) || (iui[2:0] == QUEEN) || (iui[2:0] == ROOK))
						// if bishop, queen or rook, propagate left right
						ouo_c = iui;
					
					if ((iui[5:3] == ROW2) && (ypos == ROW3)) begin
						// if started from ROW2
						// pawn can move one more step forward
						ouo_c = iui;
					end
				end
				if ((capb) && (cpiece[2:0] != EMPTY) && (iui[2:0] != PAWN)) begin
					mvu = {6'o00, capb, iui[8:3], xpos, ypos};
				end
			end
			
			// 5 remaining neighboring positions
			if (irdi[2:0] != EMPTY) begin
				if (cpiece[2:0] == EMPTY) begin
					mvrd = {6'o00, capb, irdi[8:3], xpos, ypos};
					
					if ((irdi[2:0] == BISHOP) || (irdi[2:0] == QUEEN))
						// if bishop or queen, propagate diag
						ordo_c = irdi;
				end
				if (capb) begin
					mvrd = {6'o00, capb, irdi[8:3], xpos, ypos};
				end
			end
			
			if (ildi[2:0] != EMPTY) begin
				if (cpiece[2:0] == EMPTY) begin
					mvld = {6'o00, capb, ildi[8:3], xpos, ypos};
					
					if ((ildi[2:0] == BISHOP) || (ildi[2:0] == QUEEN))
						// if bishop or queen, propagate diag
						oldo_c = ildi;
				end
				if (capb) begin
					mvld = {6'o00, capb, ildi[8:3], xpos, ypos};
				end
			end
			
			if (idi[2:0] != EMPTY) begin
				if (cpiece[2:0] == EMPTY) begin
					mvd = {6'o00, capb, idi[8:3], xpos, ypos};
					
					if ((idi[2:0] == BISHOP) || (idi[2:0] == QUEEN) || (idi[2:0] == ROOK))
						// if bishop, queen or rook, propagate up down
						odo_c = idi;
				end
				if (capb) begin
					mvd = {6'o00, capb, idi[8:3], xpos, ypos};
				end
			end
			
			if (iri[2:0] != EMPTY) begin
				if (cpiece[2:0] == EMPTY) begin
					mvr = {6'o00, capb, iri[8:3], xpos, ypos};

					if ((iri[2:0] == BISHOP) || (iri[2:0] == QUEEN) || (iri[2:0] == ROOK))
						// if bishop, queen or rook, propagate left right
						oro_c = iri;
				end
				if (capb) begin
					mvr = {6'o00, capb, iri[8:3], xpos, ypos};
				end
			end
			
			if (ili[2:0] != EMPTY) begin
				if (cpiece[2:0] == EMPTY) begin
					mvl = {6'o00, capb, ili[8:3], xpos, ypos};
					
					if ((ili[2:0] == BISHOP) || (ili[2:0] == QUEEN) || (ili[2:0] == ROOK))
						// if bishop, queen or rook, propagate left right
						olo_c = ili;
				end
				if (capb) begin
					mvl = {6'o00, capb, ili[8:3], xpos, ypos};
				end
			end
		end
		GKNI: begin // store knight moves
			state_c = DONE;
			done_c = 1'b1;
			
			// KNIGHT case
			if ((cpiece[2:0] == EMPTY) || (capb)) begin
				if (irrdi[2:0] != EMPTY) begin
					mvrrd = {6'o00, capb, irrdi[8:3], xpos, ypos};
				end
				if (irrui[2:0] != EMPTY) begin
					mvrru = {6'o00, capb, irrui[8:3], xpos, ypos};
				end
				if (irddi[2:0] != EMPTY) begin
					mvrdd = {6'o00, capb, irddi[8:3], xpos, ypos};
				end
				if (iruui[2:0] != EMPTY) begin
					mvruu = {6'o00, capb, iruui[8:3], xpos, ypos};
				end
				if (ilddi[2:0] != EMPTY) begin
					mvldd = {6'o00, capb, ilddi[8:3], xpos, ypos};
				end
				if (iluui[2:0] != EMPTY) begin
					mvluu = {6'o00, capb, iluui[8:3], xpos, ypos};
				end
				if (illdi[2:0] != EMPTY) begin
					mvlld = {6'o00, capb, illdi[8:3], xpos, ypos};
				end
				if (illui[2:0] != EMPTY) begin
					mvllu = {6'o00, capb, illui[8:3], xpos, ypos};
				end
			end
		end
		DONE: begin
		end
	endcase
	
	// if output direction does not exist, simply not wire the output
	// no extra logic should be used to clear that out
end

// FF
always @(posedge clk) begin
	state <= (reset == 1'b1) ? RSET : state_c;
	hlu <= hlu_c;
	hl <= hl_c;
	hld <= hld_c;
	hu <= hu_c;
	hd <= hd_c;
	hru <= hru_c;
	hr <= hr_c;
	hrd <= hrd_c;
	orrdo <= orrdo_c;
	orruo <= orruo_c;
	orddo <= orddo_c;
	ordo <= ordo_c;
	oro <= oro_c;
	oruo <= oruo_c;
	oruuo <= orddo_c;
	odo <= odo_c;
	ouo <= ouo_c;
	olddo <= olddo_c;
	oldo <= oldo_c;
	olo <= olo_c;
	oluo <= oluo_c;
	oluuo <= oluuo_c;
	olldo <= olldo_c;
	olluo <= olluo_c;
	done <= done_c;
end

endmodule