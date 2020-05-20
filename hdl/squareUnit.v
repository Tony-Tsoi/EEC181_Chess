module squareUnit (irrdi, irrui, irddi, irdi, iri, irui, iruui, idi, iui, 
ilddi, ildi, ili, ilui, iluui, illdi, illui,
orrdo, orruo, orddo, ordo, oro, oruo, oruuo, odo, ouo, 
olddo, oldo, olo, oluo, oluuo, olldo, olluo,
hlu, hl, hld, hu, hd, hru, hr, hrd,
clk, xpos, ypos, cpiece, reset, done, fifoOut, hold, rden);

// 19 bit output per move from fifoOut has the following format:
// [7b flag][6b from][6b to]
// seven bit flag bits as follows:
// [invalid][promote][pawn move][pawn 2 sq][en passant][castle][capture]

input clk; // clock input
input reset; // if is new board, put self at the outgoing positions
input [2:0] xpos, ypos; // specifies the position of the unit on the board
input [3:0] cpiece; // current piece occupied at this spot
input hold; // to hold the done signal from being flagged mistakenly

output reg done; // done signal
output [151:0] fifoOut; // output of FIFO

// inputs and outputs to neighbor cells
// 9 bits of the format of [6 bits origin pos][3 bits of piece info]
// 1 bit of color is omitted since only white pieces can propagate
input [8:0] irrdi, irrui, irddi, irdi, iri, irui, iruui, idi, iui, 
	ilddi, ildi, ili, ilui, iluui, illdi, illui;
output reg [8:0] orrdo, orruo, orddo, ordo, oro, oruo, oruuo, odo, ouo, 
	olddo, oldo, olo, oluo, oluuo, olldo, olluo;
	
// output hold signal
output reg hlu, hl, hld, hu, hd, hru, hr, hrd;

// parameter declarations
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
parameter PVOID = {xpos, ypos, EMPTY}; // denotes an empty space at self
parameter ROW2 = 3'o1;
parameter ROW3 = 3'o2; // value for ypos to be at row 3 (for pawn advance two blocks forward
parameter ROW4 = 3'o3;
parameter ENDMOV = {8{1'b1, 6'o00, xpos, ypos, xpos, ypos}}; // end squence for move list
	// indicates a move from self to self, an illegal move

// Moves Output
reg [18:0] mvrrd, mvrru, mvrdd, mvruu, mvldd, mvluu, mvlld, mvllu;
reg [18:0] mvrd, mvr, mvru, mvd, mvu, mvld, mvl, mvlu;
wire [151:0] wr1 = {mvrd, mvr, mvru, mvd, mvu, mvld, mvl, mvlu};
wire [151:0] wr2 = {mvrrd, mvrru, mvrdd, mvruu, mvldd, mvluu, mvlld, mvllu};
wire wren1 = ~&{wr1[151], wr1[132], wr1[113], wr1[94], wr1[75], wr1[56], wr1[37], wr1[18]};
wire wren2 = ~&{wr2[151], wr2[132], wr2[113], wr2[94], wr2[75], wr2[56], wr2[37], wr2[18]};

// fifo read enable input
input rden;

// FIFO Module Declaration
MyFifo F1F0 (.clk(clk), .wr1(wr1), .wr2(wr2), .rd1(fifoOut), .wren1(wren1), .wren2(wren2), .rden(rden));

// done signal
reg done_c;
always @(posedge clk) begin
	done <= done_c;
end

// delayed reset signal
reg reset_d;
always @(posedge clk) begin
	reset_d <= reset;
end

// hold signal combinational
wire hlu_c = (oluo_c != PVOID);
wire hl_c = (olo_c != PVOID);
wire hld_c = (oldo_c != PVOID);
wire hu_c = (ouo_c != PVOID);
wire hd_c = (odo_c != PVOID);
wire hru_c = (oruo_c != PVOID);
wire hr_c = (oro_c != PVOID);
wire hrd_c = (ordo_c != PVOID);
always @(posedge clk) begin
	hlu <= hlu_c;
	hl <= hl_c;
	hld <= hld_c;
	hu <= hu_c;
	hd <= hd_c;
	hru <= hru_c;
	hr <= hr_c;
	hrd <= hrd_c;
end

// outgoing output variables combinational
reg [8:0] orrdo_c, orruo_c, orddo_c, ordo_c, oro_c, oruo_c, oruuo_c, odo_c, 
	ouo_c, olddo_c, oldo_c, olo_c, oluo_c, oluuo_c, olldo_c, olluo_c;
always @(posedge clk) begin
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
end

// output logic
wire capb = (cpiece[3] == BLACK); // capture bit

always @(*) begin
	// default not change done
	done_c = done;

	// default empty
	olluo_c = PVOID; olldo_c = PVOID;
	oluuo_c = PVOID; oluo_c = PVOID; olo_c = PVOID; oldo_c = PVOID; olddo_c = PVOID;
	ouo_c = PVOID; odo_c = PVOID;
	oruuo_c = PVOID; oruo_c = PVOID; oro_c = PVOID; ordo_c = PVOID; orddo_c = PVOID;
	orruo_c = PVOID; orrdo_c = PVOID;
	
	if (reset_d == 1'b1) begin // generate case
		// of course not done
		done_c = 1'b0;
		
		// propagate current piece if it's ours (white)
		// since known only propagate white pieces, not sending white prefix
		// pad origin position before piece type
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
				oluo_c = {xpos, ypos, QUEEN};
				olo_c = {xpos, ypos, QUEEN};
				oldo_c = {xpos, ypos, QUEEN};
				ouo_c = {xpos, ypos, QUEEN};
				odo_c = {xpos, ypos, QUEEN};
				oruo_c = {xpos, ypos, QUEEN};
				oro_c = {xpos, ypos, QUEEN};
				ordo_c = {xpos, ypos, QUEEN};
			end
			default: begin end // EMPTY, NOTUSED case
			endcase
		end
	end // end generate case	
	else begin // propagate case
		// PAWN case
		if (cpiece[2:0] == EMPTY) begin
			// if current place is empty, pawn can move up
			if (iui[2:0] != EMPTY) begin
				mvu = {7'b0010000, iui[8:3], xpos, ypos};
				done_c = 1'b0;
				
				if (ypos == ROW4)
					mvu = {7'b0011000, iui[8:3], xpos, ypos};
				
				if ((iui[5:3] == ROW2) && (ypos == ROW3)) begin
					// if started from ROW2
					// pawn can move one more step forward
					ouo_c = iui;
				end
			end 
		end else begin
			if (cpiece[3] == BLACK) begin
				// if current place isn't empty and is of opposite, pawn en passant capture
				if (irui[2:0] == PAWN) begin
					mvru = {7'b0010101, irui[8:3], xpos, ypos};
					done_c = 1'b0;
				end
				if (ilui[2:0] == PAWN) begin
					mvlu = {7'b0010101, ilui[8:3], xpos, ypos};
					done_c = 1'b0;
				end
			end
		end
		
		// KNIGHT case
		if ((cpiece[2:0] == EMPTY) || (capb)) begin
			if (irrdi[2:0] != EMPTY) begin
				mvrrd = {6'o00, capb, irrdi[8:3], xpos, ypos};
				done_c = 1'b0;
			end
			if (irrui[2:0] != EMPTY) begin
				mvrru = {6'o00, capb, irrui[8:3], xpos, ypos};
				done_c = 1'b0;
			end
			if (irddi[2:0] != EMPTY) begin
				mvrdd = {6'o00, capb, irddi[8:3], xpos, ypos};
				done_c = 1'b0;
			end
			if (iruui[2:0] != EMPTY) begin
				mvruu = {6'o00, capb, iruui[8:3], xpos, ypos};
				done_c = 1'b0;
			end
			if (ilddi[2:0] != EMPTY) begin
				mvldd = {6'o00, capb, ilddi[8:3], xpos, ypos};
				done_c = 1'b0;
			end
			if (iluui[2:0] != EMPTY) begin
				mvluu = {6'o00, capb, iluui[8:3], xpos, ypos};
				done_c = 1'b0;
			end
			if (illdi[2:0] != EMPTY) begin
				mvlld = {6'o00, capb, illdi[8:3], xpos, ypos};
				done_c = 1'b0;
			end
			if (illui[2:0] != EMPTY) begin
				mvllu = {6'o00, capb, illui[8:3], xpos, ypos};
				done_c = 1'b0;
			end
		end
		
		// RU and LU is available for pawn, if can take current piece
		if (irui[2:0] != EMPTY) begin
			if ((cpiece[2:0] == EMPTY) && (irui[2:0] != PAWN)) begin
				mvru = {6'o00, capb, irui[8:3], xpos, ypos};
				done_c = 1'b0;
				
				if ((irui[2:0] == BISHOP) && (irui[2:0] == QUEEN))
					// if bishop or queen, propagate diag
					oruo_c = irui;
			end
			if (capb) begin
				mvru = {6'o00, capb, irui[8:3], xpos, ypos};
				done_c = 1'b0;
			end
		end
		
		if (ilui[2:0] != EMPTY) begin
			if ((cpiece[2:0] == EMPTY) && (ilui[2:0] != PAWN)) begin
				mvlu = {6'o00, capb, ilui[8:3], xpos, ypos};
				done_c = 1'b0;
				
				if ((ilui[2:0] == BISHOP) && (ilui[2:0] == QUEEN))
					// if bishop or queen, propagate diag
					oruo_c = ilui;
			end
			if (capb) begin
				mvlu = {6'o00, capb, ilui[8:3], xpos, ypos};
				done_c = 1'b0;
			end
		end
		
		// U is available for pawn if empty
		if (iui[2:0] != EMPTY) begin
			if (cpiece[2:0] == EMPTY) begin
				mvu = {2'b00, (iui[2:0] == PAWN), 3'o0, capb, iui[8:3], xpos, ypos};
				done_c = 1'b0;
				
				if ((iui[2:0] == BISHOP) && (iui[2:0] == QUEEN))
					// if bishop or queen, propagate diag
					oruo_c = irui;
			end
			if ((capb) && (iui[2:0] != PAWN)) begin
				mvu = {6'o00, capb, iui[8:3], xpos, ypos};
				done_c = 1'b0;
			end
		end
		
		// 5 remaining neighboring positions
		if (irdi[2:0] != EMPTY) begin
			if (cpiece[2:0] == EMPTY) begin
				mvrd = {6'o00, capb, irdi[8:3], xpos, ypos};
				done_c = 1'b0;
				
				if ((irdi[2:0] == BISHOP) && (irdi[2:0] == QUEEN))
					// if bishop or queen, propagate diag
					ordo_c = irdi;
			end
			if (capb) begin
				mvrd = {6'o00, capb, irdi[8:3], xpos, ypos};
				done_c = 1'b0;
			end
		end
		
		if (ildi[2:0] != EMPTY) begin
			if (cpiece[2:0] == EMPTY) begin
				mvld = {6'o00, capb, ildi[8:3], xpos, ypos};
				done_c = 1'b0;
				
				if ((ildi[2:0] == BISHOP) && (ildi[2:0] == QUEEN))
					// if bishop or queen, propagate diag
					oldo_c = ildi;
			end
			if (capb) begin
				mvld = {6'o00, capb, ildi[8:3], xpos, ypos};
				done_c = 1'b0;
			end
		end
		
		if (idi[2:0] != EMPTY) begin
			if (cpiece[2:0] == EMPTY) begin
				mvd = {6'o00, capb, idi[8:3], xpos, ypos};
				done_c = 1'b0;
				
				if ((idi[2:0] == BISHOP) && (idi[2:0] == QUEEN))
					// if bishop or queen, propagate diag
					odo_c = idi;
			end
			if (capb) begin
				mvd = {6'o00, capb, idi[8:3], xpos, ypos};
				done_c = 1'b0;
			end
		end
		
		if (iri[2:0] != EMPTY) begin
			if (cpiece[2:0] == EMPTY) begin
				mvr = {6'o00, capb, iri[8:3], xpos, ypos};
				done_c = 1'b0;

				if ((iri[2:0] == BISHOP) && (iri[2:0] == QUEEN))
					// if bishop or queen, propagate diag
					oro_c = iri;
			end
			if (capb) begin
				mvr = {6'o00, capb, iri[8:3], xpos, ypos};
				done_c = 1'b0;
			end
		end
		
		if (ili[2:0] != EMPTY) begin
			if (cpiece[2:0] == EMPTY) begin
				mvl = {6'o00, capb, ili[8:3], xpos, ypos};
				done_c = 1'b0;
				
				if ((ili[2:0] == BISHOP) && (ili[2:0] == QUEEN))
					// if bishop or queen, propagate diag
					olo_c = ili;
			end
			if (capb) begin
				mvl = {6'o00, capb, ili[8:3], xpos, ypos};
				done_c = 1'b0;
			end
		end
	end // end propagate case
	
	// finally set done signal if hold or is just got new board
	if (hold == 1'b1)
		done_c = 1'b0;
	
	if (reset_d == 1'b1)
		done_c = 1'b0;
	
	// if output direction does not exist, simply not wire the output
	// no extra logic should be used to clear that out
end

endmodule