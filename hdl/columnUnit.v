module columnUnit (clk, colstate, xpos, reset, done, chdiri,
cirrdi, cirrui, cirddi, cirdi, ciri, cirui, ciruui, cidi, ciui, cilddi, cildi, 
cili, cilui, ciluui, cilldi, cillui,
colluo, colldo, coluuo, coluo, colo, coldo, colddo, couo, codo, coruuo, coruo, 
coro, cordo, corddo, corruo, corrdo,
chluo, chruo, chlo, chro, chldo, chrdo,
fifoOut, fifoEmpty, rden
);
// 19 bit output per move from fifoOut has the following format:
// [7b flag][6b from][6b to]
// seven bit flag bits as follows:
// [invalid][promote][pawn move][pawn 2 sq][en passant][castle][capture]

// parameter declarations
parameter PVOID = 9'h0; // it's just {3'o0, 3'o0, EMPTY} - denotes an empty space at xpos = 0, ypos = 0

parameter ROW1 = 3'o0; parameter ROW2 = 3'o1; parameter ROW3 = 3'o2; parameter ROW4 = 3'o3;
parameter ROW5 = 3'o4; parameter ROW6 = 3'o5; parameter ROW7 = 3'o6; parameter ROW8 = 3'o7;

// parameter for states
parameter WAIT = 2'b01;
parameter GETM = 2'b11;
parameter DONE = 2'b10;

// state bit
reg [1:0] state, state_c;


input clk, reset;
input [2:0] xpos;
input [31:0] colstate; // column piece states

// input signals from neightboring columns
input [53:0] cirddi, cilddi;
input [62:0] cirrdi, cirdi, cidi, cildi, cilldi;
input [71:0] ciri, cili;
input [71:9] cirrui, cirui, ciui, cilui, cillui;
input [71:18] ciruui, ciluui;

// output signals to neightboring columns
output [53:0] coluuo, coruuo;
output [62:0] colluo, coluo, couo, coruo, corruo;
output [71:0] colo, coro;
output [71:9] colldo, coldo, codo, cordo, corrdo;
output [71:18] colddo, corddo;

// input signals to hold the done flags
input [8:1] chdiri;

// output signals to hold from done flags
output [7:1] chluo, chruo;
output [8:1] chlo, chro;
output [8:2] chldo, chrdo;

// done signal
output done; // done signal
assign done = (state == DONE);

// output from fifo
output [151:0] fifoOut;

// column fifo empty flag
output fifoEmpty;

// column fifo read enable
input rden;



// cpieces of each square
wire cpiece_8 = colstate[31:28];
wire cpiece_7 = colstate[27:24];
wire cpiece_6 = colstate[23:20];
wire cpiece_5 = colstate[19:16];
wire cpiece_4 = colstate[15:12];
wire cpiece_3 = colstate[11:8];
wire cpiece_2 = colstate[7:4];
wire cpiece_1 = colstate[3:0];

// done signals from each squareUnit
wire [8:1] done_sqs;

// hold up down signals from square outputs inside this column
wire [7:1] chuo;
wire [8:2] chdo;

// hold signal logic for squares
wire [8:1] holds;
assign holds[8] = |{chuo[7:1],            chdiri[8]};
assign holds[7] = |{chuo[6:1], chdo[8  ], chdiri[7]};
assign holds[6] = |{chuo[5:1], chdo[8:7], chdiri[6]};
assign holds[5] = |{chuo[4:1], chdo[8:6], chdiri[5]};
assign holds[4] = |{chuo[3:1], chdo[8:5], chdiri[4]};
assign holds[3] = |{chuo[2:1], chdo[8:4], chdiri[3]};
assign holds[2] = |{chuo[  1], chdo[8:3], chdiri[2]};
assign holds[1] = |{           chdo[8:2], chdiri[1]};


// moves transferred to local fifo flag
reg [8:1] sq_moved_flags, sq_moved_flags_c;

// pointer for GETM state
reg [2:0] sq_move_ptr, sq_move_ptr_c;

// read enable for square fifo
reg [8:1] sq_rden, sq_rden_c;

// fifo empty for square fifo
wire [7:0] sqEmpty;

// pointed square fifo empty flag
wire c_sq_empty = sqEmpty[sq_move_ptr];

// Row fifo outs
wire [47:0] fifoOut_sq8, fifoOut_sq7, fifoOut_sq6, fifoOut_sq5, fifoOut_sq4, fifoOut_sq3, fifoOut_sq2, fifoOut_sq1;

// FIFO Module Declaration
reg wren1, wren1_c;
wire [151:0] wr1 = (sq_move_ptr == 3'd7)? fifoOut_sq8 :
	(sq_move_ptr == 3'd6)? fifoOut_sq7 :
	(sq_move_ptr == 3'd5)? fifoOut_sq6 :
	(sq_move_ptr == 3'd4)? fifoOut_sq5 :
	(sq_move_ptr == 3'd3)? fifoOut_sq4 :
	(sq_move_ptr == 3'd2)? fifoOut_sq3 :
	(sq_move_ptr == 3'd1)? fifoOut_sq2 : fifoOut_sq1;
wire [159:152] fillwr = 8'd0; // white space to accomodate width of fifo
My_FIFO F1F0 (.clock(clk), .data({fillwr,wr1}), .q(fifoOut), .wrreq(wren1), .rdreq(rden), .empty(fifoEmpty),
	.usedw(), .full());

// next state logic
always @(*) begin
	state_c = state;
	sq_rden_c = 8'h00;
	sq_moved_flags_c = sq_moved_flags;
	
	case (state)
		WAIT: begin
			// if a done signal is up and is not grabbed to FIFO
			if (done_sqs[8])
				if (~sq_moved_flags[8]) begin
					state_c = GETM;
					sq_move_ptr_c = 3'd7;
					sq_rden_c = 8'h80;
					wren1_c = 1'b1;
				end
			
			if (done_sqs[7])
				if (~sq_moved_flags[7]) begin
					state_c = GETM;
					sq_move_ptr_c = 3'd6;
					sq_rden_c = 8'h40;
					wren1_c = 1'b1;
				end
			
			if (done_sqs[6])
				if (~sq_moved_flags[6]) begin
					state_c = GETM;
					sq_move_ptr_c = 3'd5;
					sq_rden_c = 8'h20;
					wren1_c = 1'b1;
				end
			
			if (done_sqs[5])
				if (~sq_moved_flags[5]) begin
					state_c = GETM;
					sq_move_ptr_c = 3'd4;
					sq_rden_c = 8'h10;
					wren1_c = 1'b1;
				end
			
			if (done_sqs[4])
				if (~sq_moved_flags[4]) begin
					state_c = GETM;
					sq_move_ptr_c = 3'd3;
					sq_rden_c = 8'h08;
					wren1_c = 1'b1;
				end
			
			if (done_sqs[3])
				if (~sq_moved_flags[3]) begin
					state_c = GETM;
					sq_move_ptr_c = 3'd2;
					sq_rden_c = 8'h04;
					wren1_c = 1'b1;
				end
			
			if (done_sqs[2])
				if (~sq_moved_flags[2]) begin
					state_c = GETM;
					sq_move_ptr_c = 3'd1;
					sq_rden_c = 8'h02;
					wren1_c = 1'b1;
				end
			
			if (done_sqs[1])
				if (~sq_moved_flags[1]) begin
					state_c = GETM;
					sq_move_ptr_c = 3'd0;
					sq_rden_c = 8'h01;
					wren1_c = 1'b1;
				end
			
			if (&{sq_moved_flags}) // if all squares grabbed move
				state_c = DONE;
		end
		GETM: begin
			// get move from specified square until exhausted
			sq_rden_c = sq_rden;
			wren1_c = 1'b1;
			
			// if all moves from square fifo gone
			if (c_sq_empty) begin
				state_c = WAIT;
				sq_moved_flags_c[sq_move_ptr] = 1'b1;
				wren1_c = 1'b0;
			end
		end
	endcase
	
	if (reset == 1'b1)
		sq_moved_flags_c = 8'h00;
end

// FF for next state
always @(posedge clk) begin
	state <= reset? WAIT : state_c;
	sq_rden <= sq_rden_c;
	sq_move_ptr <= sq_move_ptr_c;
	sq_moved_flags <= sq_moved_flags_c;
	wren1 <= wren1_c;
end





// Row 8
squareUnit sq8 (.clk(clk), .xpos(xpos), .ypos(ROW8), .reset(reset), .done(done_sqs[8]), .hold(holds[8]), .rden(sq_rden[8]),
	.rd1(fifoOut_sq8), .cpiece(cpiece_8), .fifoEmpty(sqEmpty[7]), 
	.irrdi(PVOID), .irddi(PVOID), .irdi(PVOID), .idi(PVOID), .ilddi(PVOID), .ildi(PVOID), .illdi(PVOID),
	.irrui(cirrui[71:63]), .iri(ciri[71:63]), .irui(cirui[71:63]), .iruui(ciruui[71:63]), .iui(ciui[71:63]), 
	.ili(cili[71:63]), .ilui(cilui[71:63]), .iluui(ciluui[71:63]), .illui(cillui[71:63]),
	.olluo(), .oluuo(), .oluo(), .ouo(), .oruuo(), .oruo(), .orruo(),
	.olldo(colldo[71:63]), .olo(colo[71:63]), .oldo(coldo[71:63]), .olddo(colddo[71:63]), .odo(codo[71:63]),
	.oro(coro[71:63]), .ordo(cordo[71:63]), .orddo(corddo[71:63]), .orrdo(corrdo[71:63]),
	.hlu(), .hru(), .hu(), .hd(chdo[8]),
	.hl(chlo[8]), .hr(chro[8]), .hld(chldo[8]), .hrd(chrdo[8]) );

// Row 7
squareUnit sq7 (.clk(clk), .xpos(xpos), .ypos(ROW7), .reset(reset), .done(done_sqs[7]), .hold(holds[7]), .rden(sq_rden[7]),
	.rd1(fifoOut_sq7),  .cpiece(cpiece_7), .fifoEmpty(sqEmpty[6]),
	.irddi(PVOID), .ilddi(PVOID), 
	.irrdi(cirrdi[62:54]), .irrui(cirrui[62:54]), .irdi(cirdi[62:54]), .iri(ciri[62:54]), .irui(cirui[62:54]), 
	.iruui(ciruui[62:54]), .idi(cidi[62:54]), .iui(ciui[62:54]), .ildi(cildi[62:54]), .ili(cili[62:54]), 
	.ilui(cilui[62:54]), .iluui(ciluui[62:54]), .illdi(cilldi[62:54]), .illui(cillui[62:54]),
	.oluuo(), .oruuo(),
	.olluo(colluo[62:54]), .olldo(colldo[62:54]), .oluo(coluo[62:54]), .olo(colo[62:54]), .oldo(coldo[62:54]), 
	.olddo(colddo[62:54]), .ouo(couo[62:54]), .odo(codo[62:54]), .oruo(coruo[62:54]), .oro(coro[62:54]), 
	.ordo(cordo[62:54]), .orddo(corddo[62:54]), .orruo(corruo[62:54]), .orrdo(corrdo[62:54]),
	.hlu(chluo[7]), .hru(chruo[7]), .hu(chuo[7]), .hd(chdo[7]),
	.hl(chlo[7]), .hr(chro[7]), .hld(chldo[7]), .hrd(chrdo[7]) );

// Row 6
squareUnit sq6 (.clk(clk), .xpos(xpos), .ypos(ROW6), .reset(reset), .done(done_sqs[6]), .hold(holds[6]), .rden(sq_rden[6]),
	.rd1(fifoOut_sq6),  .cpiece(cpiece_6), .fifoEmpty(sqEmpty[5]),
	.irrdi(cirrdi[53:45]), .irrui(cirrui[53:45]), .irddi(cirddi[53:45]), .irdi(cirdi[53:45]), .iri(ciri[53:45]), 
	.irui(cirui[53:45]), .iruui(ciruui[53:45]), .idi(cidi[53:45]), .iui(ciui[53:45]), .ilddi(cilddi[53:45]), 
	.ildi(cildi[53:45]), .ili(cili[53:45]), .ilui(cilui[53:45]), .iluui(ciluui[53:45]), .illdi(cilldi[53:45]), 
	.illui(cillui[53:45]),
	.olluo(colluo[53:45]), .olldo(colldo[53:45]), .oluuo(coluuo[53:45]), .oluo(coluo[53:45]), .olo(colo[53:45]), 
	.oldo(coldo[53:45]), .olddo(colddo[53:45]), .ouo(couo[53:45]), .odo(codo[53:45]), .oruuo(coruuo[53:45]),
	.oruo(coruo[53:45]), .oro(coro[53:45]), .ordo(cordo[53:45]), .orddo(corddo[53:45]), .orruo(corruo[53:45]), 
	.orrdo(corrdo[53:45]),
	.hlu(chluo[6]), .hru(chruo[6]), .hu(chuo[6]), .hd(chdo[6]),
	.hl(chlo[6]), .hr(chro[6]), .hld(chldo[6]), .hrd(chrdo[6]) );

// Row 5
squareUnit sq5 (.clk(clk), .xpos(xpos), .ypos(ROW5), .reset(reset), .done(done_sqs[5]), .hold(holds[5]), .rden(sq_rden[5]),
	.rd1(fifoOut_sq5), .cpiece(cpiece_5), .fifoEmpty(sqEmpty[4]),
	.irrdi(cirrdi[44:36]), .irrui(cirrui[44:36]), .irddi(cirddi[44:36]), .irdi(cirdi[44:36]), .iri(ciri[44:36]), 
	.irui(cirui[44:36]), .iruui(ciruui[44:36]), .idi(cidi[44:36]), .iui(ciui[44:36]), .ilddi(cilddi[44:36]), 
	.ildi(cildi[44:36]), .ili(cili[44:36]), .ilui(cilui[44:36]), .iluui(ciluui[44:36]), .illdi(cilldi[44:36]), 
	.illui(cillui[44:36]),
	.olluo(colluo[44:36]), .olldo(colldo[44:36]), .oluuo(coluuo[44:36]), .oluo(coluo[44:36]), .olo(colo[44:36]), 
	.oldo(coldo[44:36]), .olddo(colddo[44:36]), .ouo(couo[44:36]), .odo(codo[44:36]), .oruuo(coruuo[44:36]),
	.oruo(coruo[44:36]), .oro(coro[44:36]), .ordo(cordo[44:36]), .orddo(corddo[44:36]), .orruo(corruo[44:36]), 
	.orrdo(corrdo[44:36]),
	.hlu(chluo[5]), .hru(chruo[5]), .hu(chuo[5]), .hd(chdo[5]),
	.hl(chlo[5]), .hr(chro[5]), .hld(chldo[5]), .hrd(chrdo[5]) );

// Row 4
squareUnit sq4 (.clk(clk), .xpos(xpos), .ypos(ROW4), .reset(reset), .done(done_sqs[4]), .hold(holds[4]), .rden(sq_rden[4]),
	.rd1(fifoOut_sq4), .cpiece(cpiece_4), .fifoEmpty(sqEmpty[3]),
	.irrdi(cirrdi[35:27]), .irrui(cirrui[35:27]), .irddi(cirddi[35:27]), .irdi(cirdi[35:27]), .iri(ciri[35:27]), 
	.irui(cirui[35:27]), .iruui(ciruui[35:27]), .idi(cidi[35:27]), .iui(ciui[35:27]), .ilddi(cilddi[35:27]), 
	.ildi(cildi[35:27]), .ili(cili[35:27]), .ilui(cilui[35:27]), .iluui(ciluui[35:27]), .illdi(cilldi[35:27]), 
	.illui(cillui[35:27]),
	.olluo(colluo[35:27]), .olldo(colldo[35:27]), .oluuo(coluuo[35:27]), .oluo(coluo[35:27]), .olo(colo[35:27]), 
	.oldo(coldo[35:27]), .olddo(colddo[35:27]), .ouo(couo[35:27]), .odo(codo[35:27]), .oruuo(coruuo[35:27]),
	.oruo(coruo[35:27]), .oro(coro[35:27]), .ordo(cordo[35:27]), .orddo(corddo[35:27]), .orruo(corruo[35:27]), 
	.orrdo(corrdo[35:27]),
	.hlu(chluo[4]), .hru(chruo[4]), .hu(chuo[4]), .hd(chdo[4]),
	.hl(chlo[4]), .hr(chro[4]), .hld(chldo[4]), .hrd(chrdo[4]) );

// Row 3
squareUnit sq3 (.clk(clk), .xpos(xpos), .ypos(ROW3), .reset(reset), .done(done_sqs[3]), .hold(holds[3]), .rden(sq_rden[3]),
	.rd1(fifoOut_sq3), .cpiece(cpiece_3), .fifoEmpty(sqEmpty[2]),
	.irrdi(cirrdi[26:18]), .irrui(cirrui[26:18]), .irddi(cirddi[26:18]), .irdi(cirdi[26:18]), .iri(ciri[26:18]), 
	.irui(cirui[26:18]), .iruui(ciruui[26:18]), .idi(cidi[26:18]), .iui(ciui[26:18]), .ilddi(cilddi[26:18]), 
	.ildi(cildi[26:18]), .ili(cili[26:18]), .ilui(cilui[26:18]), .iluui(ciluui[26:18]), .illdi(cilldi[26:18]), 
	.illui(cillui[26:18]),
	.olluo(colluo[26:18]), .olldo(colldo[26:18]), .oluuo(coluuo[26:18]), .oluo(coluo[26:18]), .olo(colo[26:18]), 
	.oldo(coldo[26:18]), .olddo(colddo[26:18]), .ouo(couo[26:18]), .odo(codo[26:18]), .oruuo(coruuo[26:18]),
	.oruo(coruo[26:18]), .oro(coro[26:18]), .ordo(cordo[26:18]), .orddo(corddo[26:18]), .orruo(corruo[26:18]), 
	.orrdo(corrdo[26:18]),
	.hlu(chluo[3]), .hru(chruo[3]), .hu(chuo[3]), .hd(chdo[3]),
	.hl(chlo[3]), .hr(chro[3]), .hld(chldo[3]), .hrd(chrdo[3]) );

// Row 2
squareUnit sq2 (.clk(clk), .xpos(xpos), .ypos(ROW2), .reset(reset), .done(done_sqs[2]), .hold(holds[2]), .rden(sq_rden[2]),
	.rd1(fifoOut_sq2), .cpiece(cpiece_2), .fifoEmpty(sqEmpty[1]),
	.iruui(PVOID), .iluui(PVOID), 
	.irrdi(cirrdi[17:9]), .irrui(cirrui[17:9]), .irddi(cirddi[17:9]), .irdi(cirdi[17:9]), .iri(ciri[17:9]), 
	.irui(cirui[17:9]), .idi(cidi[17:9]), .iui(ciui[17:9]), .ilddi(cilddi[17:9]), 
	.ildi(cildi[17:9]), .ili(cili[17:9]), .ilui(cilui[17:9]), .illdi(cilldi[17:9]), .illui(cillui[17:9]),
	.olddo(), .orddo(), 
	.olluo(colluo[17:9]), .olldo(colldo[17:9]), .oluuo(coluuo[17:9]), .oluo(coluo[17:9]), .olo(colo[17:9]), 
	.oldo(coldo[17:9]), .ouo(couo[17:9]), .odo(codo[17:9]), .oruuo(coruuo[17:9]),
	.oruo(coruo[17:9]), .oro(coro[17:9]), .ordo(cordo[17:9]), .orruo(corruo[17:9]), .orrdo(corrdo[17:9]),
	.hlu(chluo[2]), .hru(chruo[2]), .hu(chuo[2]), .hd(chdo[2]),
	.hl(chlo[2]), .hr(chro[2]), .hld(chldo[2]), .hrd(chrdo[2]) );

// Row 1
squareUnit sq1 (.clk(clk), .xpos(xpos), .ypos(ROW1), .reset(reset), .done(done_sqs[1]), .hold(holds[1]), .rden(sq_rden[1]),
	.rd1(fifoOut_sq1), .cpiece(cpiece_1), .fifoEmpty(sqEmpty[0]),
	.irrui(PVOID), .irui(PVOID), .iruui(PVOID), .iui(PVOID), .ilui(PVOID), .iluui(PVOID), .illui(PVOID),
	.irrdi(cirrdi[8:0]), .irddi(cirddi[8:0]), .irdi(cirdi[8:0]), .iri(ciri[8:0]), .idi(cidi[8:0]), 
	.ilddi(cilddi[8:0]), .ildi(cildi[8:0]), .ili(cili[8:0]), .illdi(cilldi[8:0]), 
	.olldo(), .oldo(), .olddo(), .odo(), .ordo(), .orddo(), .orrdo(), 
	.olluo(colluo[8:0]), .oluuo(coluuo[8:0]), .oluo(coluo[8:0]), .olo(colo[8:0]), .ouo(couo[8:0]), 
	.oruuo(coruuo[8:0]), .oruo(coruo[8:0]), .oro(coro[8:0]), .orruo(corruo[8:0]),
	.hld(), .hrd(), .hu(chuo[1]), .hd(),
	.hl(chlo[1]), .hr(chro[1]), .hlu(chluo[1]), .hru(chruo[1]) );

endmodule