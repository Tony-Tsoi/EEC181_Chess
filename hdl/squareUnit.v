module squareUnit (irrdi, irrui, irddi, irdi, iri, irui, iruui, idi, iui, 
ilddi, ildi, ili, ilui, iluui, illdi, illui,
orrdo, orruo, orddo, ordo, oro, oruo, oruuo, odo, ouo, 
olddo, oldo, olo, oluo, oluuo, olldo, olluo,
clk, xpos, ypos, cpiece, newboard, done, fifoOut);
// TODO: add output to column unit FIFO
// TODO: for every time send to move list, assert done_c = 1'b0;

input clk; // clock input
input newboard; // if is new board, put self at the outgoing positions
input [2:0] xpos, ypos; // specifies the position of the unit on the board
input [3:0] cpiece; // current piece occupied at this spot

output reg done; // done signal
output [47:0] fifoOut; // output of FIFO

// inputs and outputs to neighbor cells
input [8:0] irrdi, irrui, irddi, irdi, iri, irui, iruui, idi, iui, 
	ilddi, ildi, ili, ilui, iluui, illdi, illui;
output reg [8:0] orrdo, orruo, orddo, ordo, oro, oruo, oruuo, odo, ouo, 
	olddo, oldo, olo, oluo, oluuo, olldo, olluo;

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
parameter PVOID = 9'h0; // it's just {3'o0, 3'o0, EMPTY} - denotes an empty space at xpos = 0, ypos = 0
parameter ROW3 = 3'o3; // value for ypos to be at row 3 (for pawn advance two blocks forward

// Moves Output
reg [5:0] mvrrd, mvrru, mvrdd, mvruu, mvldd, mvluu, mvlld, mvllu;
reg [5:0] mvrd, mvr, mvru, mvd, mvu, mvld, mvl, mvlu;
reg [47:0] wr1 = {mvrd, mvr, mvru, mvd, mvu, mvld, mvl, mvlu};
reg [47:0] wr2 = {mvrrd, mvrru, mvrdd, mvruu, mvldd, mvluu, mvlld, mvllu};
wire wren1 = |{wr1};
wire wren2 = |{wr2};

// FIFO Module Declaration
MyFifo F1F0 (.clk(clk), .wr1(wr1), .wr2(wr2), .rd1(fifoOut), .wren1(wren1), .wren2(wren2));

// done signal
reg done_c;
always @(posedge clk) begin
	done <= done_c;
end

// outgoing output variables combinational
reg [3:0] orrdo_c, orruo_c, orddo_c, ordo_c, oro_c, oruo_c, oruuo_c, odo_c, 
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
always @(*) begin
	// default done
	done_c = 1'b1;

	// default empty
	olluo_c = PVOID; olldo_c = PVOID;
	oluuo_c = PVOID; oluo_c = PVOID; olo_c = PVOID; oldo_c = PVOID; olddo_c = PVOID;
	ouo_c = PVOID; odo_c = PVOID;
	oruuo_c = PVOID; oruo_c = PVOID; oro_c = PVOID; ordo_c = PVOID; orddo_c = PVOID;
	orruo_c = PVOID; orrdo_c = PVOID;
	
	if (newboard == 1'b1) begin
		// of course not done
		done_c = 1'b0;
		
		// propogate current piece if it's ours (white)
		// since known only propogate white pieces, not sending white prefix
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
	else begin
		// PAWN case
		if (cpiece[2:0] == EMPTY) begin
			// if current place is empty, pawn can move up
			if (iui[2:0] != EMPTY) begin
				mvu = iui[8:3];
				
				if (iui[5:3] == ROW2) begin
					// if started from ROW2
					// pawn can move one more step forward
					ouo_c = iui;
				end
			end 
		end else begin
			if (cpiece[3] == BLACK) begin
				// if current place isn't empty and is of opposite, pawn can take sideway
				if (irui[2:0] == PAWN) begin
					mvru = irui[8:3];
				end
				if (ilui]2:0] == PAWN) begin
					mvlu = ilui[8:3];
				end
			end
		end
		
		// KNIGHT case
		if ((cpiece[2:0] == EMPTY) || (cpiece[3] == BLACK)) begin
			if (irrdi[2:0] != EMPTY)
				mvrrd = irrdi[8:3];
			if (irrui[2:0] != EMPTY)
				mvrru = irrui[8:3];
			if (irddi[2:0] != EMPTY)
				mvrdd = irddi[8:3];
			if (iruui[2:0] != EMPTY)
				mvruu = iruui[8:3];
			if (ilddi[2:0] != EMPTY)
				mvldd = ilddi[8:3];
			if (iluui[2:0] != EMPTY)
				mvluu = iluui[8:3];
			if (illdi[2:0] != EMPTY)
				mvlld = illdi[8:3];
			if (illui[2:0] != EMPTY)
				mvllu = illui[8:3];
		end
		
		// RU and LU is available for pawn, if can take current piece
		if (irui[2:0] != EMPTY) begin
			if ((cpiece[2:0] == EMPTY) && (irui[2:0] != PAWN)) begin
				mvru = irui[8:3];
				
				if ((irui[2:0] == BISHOP) && (irui[2:0] == QUEEN))
					// if bishop or queen, propogate diag
					oruo_c = irui;
			end
			if (cpiece[3] == BLACK) begin
				mvru = irui[8:3];
			end
		end
		
		if (ilui[2:0] != EMPTY) begin
			if ((cpiece[2:0] == EMPTY) && (ilui[2:0] != PAWN)) begin
				mvlu = ilui[8:3];
				
				if ((ilui[2:0] == BISHOP) && (ilui[2:0] == QUEEN))
					// if bishop or queen, propogate diag
					oruo_c = ilui;
			end
			if (cpiece[3] == BLACK) begin
				mvlu = ilui[8:3];
			end
		end
		
		// U is available for pawn if empty
		if (iui[2:0] != EMPTY) begin
			if (cpiece[2:0] == EMPTY) begin
				mvu = iui[8:3];
				
				if ((iui[2:0] == BISHOP) && (iui[2:0] == QUEEN))
					// if bishop or queen, propogate diag
					oruo_c = irui;
			end
			if ((cpiece[3] == BLACK) && (iui[2:0] != PAWN)) begin
				mvu = iui[8:3];
			end
		end
		
		// 5 remaining neighboring positions
		if (irdi[2:0] != EMPTY) begin
			if (cpiece[2:0] == EMPTY) begin
				mvrd = irdi[8:3];
				
				if ((irdi[2:0] == BISHOP) && (irdi[2:0] == QUEEN))
					// if bishop or queen, propogate diag
					ordo_c = irdi;
			end
			if (cpiece[3] == BLACK) begin
				mvrd = irdi[8:3];
			end
		end
		
		if (ildi[2:0] != EMPTY) begin
			if (cpiece[2:0] == EMPTY) begin
				mvld = ildi[8:3];
				
				if ((ildi[2:0] == BISHOP) && (ildi[2:0] == QUEEN))
					// if bishop or queen, propogate diag
					oldo_c = ildi;
			end
			if (cpiece[3] == BLACK) begin
				mvld = ildi[8:3];
			end
		end
		
		if (idi[2:0] != EMPTY) begin
			if (cpiece[2:0] == EMPTY) begin
				mvd = idi[8:3];
				
				if ((idi[2:0] == BISHOP) && (idi[2:0] == QUEEN))
					// if bishop or queen, propogate diag
					odo_c = idi;
			end
			if (cpiece[3] == BLACK) begin
				mvd = idi[8:3];
			end
		end
		
		if (iri[2:0] != EMPTY) begin
			if (cpiece[2:0] == EMPTY) begin
				mvr = iri[8:3];

				if ((iri[2:0] == BISHOP) && (iri[2:0] == QUEEN))
					// if bishop or queen, propogate diag
					oro_c = iri;
			end
			if (cpiece[3] == BLACK) begin
				mvr = iri[8:3];
			end
		end
		
		if (ili[2:0] != EMPTY) begin
			if (cpiece[2:0] == EMPTY) begin
				mvl = ili[8:3];
				
				if ((ili[2:0] == BISHOP) && (ili[2:0] == QUEEN))
					// if bishop or queen, propogate diag
					olo_c = ili;
			end
			if (cpiece[3] == BLACK) begin
				mvl = ili[8:3];
			end
		end
	end
	
	// if position is actually a wall, simply not wire the output
	// no extra logic should be used to clear that out
end
endmodule