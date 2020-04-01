module cellUnit (irrdi, irrui, irddi, irdi, iri, irui, iruui, idi, iui, 
ilddi, ildi, ili, ilui, iluui, illdi, illui,
orrdo, orruo, orddo, ordo, oro, oruo, oruuo, odo, ouo, 
olddo, oldo, olo, oluo, oluuo, olldo, olluo,
clk, xpos, ypos, cpiece, newboard);
// TODO: add output to column unit FIFO

input clk; // clock input
input newboard; // if is new board, put self at the outgoing positions
input [2:0] xpos, ypos; // specifies the position of the unit on the board
input [3:0] cpiece; // current piece occupied at this spot

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
parameter ROW2 = 3'o2; // value for ypos to be at row 2 (for pawn advance two blocks forward

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
	// default empty
	olluo_c = PVOID; olldo_c = PVOID;
	oluuo_c = PVOID; oluo_c = PVOID; olo_c = PVOID; oldo_c = PVOID; olddo_c = PVOID;
	ouo_c = PVOID; odo_c = PVOID;
	oruuo_c = PVOID; oruo_c = PVOID; oro_c = PVOID; ordo_c = PVOID; orddo_c = PVOID;
	orruo_c = PVOID; orrdo_c = PVOID;
	
	if (newboard == 1'b1) begin
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
				// PSEUDOCODE: send to move list (StML)
				
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
					// PSEUDOCODE: send to move list (StML)
				end
				if (ilui]2:0] == PAWN) begin
					// PSEUDOCODE: send to move list (StML)
				end
			end
		end
		
		// KNIGHT case
		if ((cpiece[2:0] == EMPTY) || (cpiece[3] == BLACK)) begin
			if (irrdi[2:0] != EMPTY)
				// PSEUDOCODE: send to move list (StML)
			end
			if (irrui[2:0] != EMPTY)
				// PSEUDOCODE: send to move list (StML)
			end
			if (irddi[2:0] != EMPTY)
				// PSEUDOCODE: send to move list (StML)
			end
			if (iruui[2:0] != EMPTY)
				// PSEUDOCODE: send to move list (StML)
			end
			if (ilddi[2:0] != EMPTY)
				// PSEUDOCODE: send to move list (StML)
			end
			if (iluui[2:0] != EMPTY)
				// PSEUDOCODE: send to move list (StML)
			end
			if (illdi[2:0] != EMPTY)
				// PSEUDOCODE: send to move list (StML)
			end
			if (illui[2:0] != EMPTY)
				// PSEUDOCODE: send to move list (StML)
			end
		end
		
		// 8 neighboring positions, remaining cases
		if (cpiece[2:0] == EMPTY) begin
			// continues to propogate (except KING)
		end
		if (cpiece[3] == BLACK) begin
			// takes the current piece, stops propogate
			// integrate this into upper clause?
		end
		
		
		
		// NOTE: PAWN, KNIGHT, KING, EMPTY, NOTUSED case does not propagate the piece
	end
	
	// if position is actually a wall, simply not wire the output
	// no extra logic should be used to clear that out
end
endmodule