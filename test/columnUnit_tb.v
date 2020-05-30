`timescale 1ps / 1ps

module columnUnit_tb;

parameter NCIO = 60; // number of cycles from input to output

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

parameter PVOID = 9'h0;

parameter ROW1 = 3'o0; parameter ROW2 = 3'o1; parameter ROW3 = 3'o2; parameter ROW4 = 3'o3;
parameter ROW5 = 3'o4; parameter ROW6 = 3'o5; parameter ROW7 = 3'o6; parameter ROW8 = 3'o7;

parameter COLA = 3'o0; parameter COLB = 3'o1; parameter COLC = 3'o2; parameter COLD = 3'o3;
parameter COLE = 3'o4; parameter COLF = 3'o5; parameter COLG = 3'o6; parameter COLH = 3'o7;

reg clk, reset, rden;
reg [2:0] xpos;
reg [31:0] colstate; // column piece states

// input signals from neightboring columns
reg [53:0] cirddi, cilddi;
reg [62:0] cirrdi, cirdi, cidi, cildi, cilldi;
reg [71:0] ciri, cili;
reg [71:9] cirrui, cirui, ciui, cilui, cillui;
reg [71:18] ciruui, ciluui;
reg [8:1] chdiri;

// output signals to neightboring columns
wire [53:0] coluuo, coruuo;
wire [62:0] colluo, coluo, couo, coruo, corruo;
wire [71:0] colo, coro;
wire [71:9] colldo, coldo, codo, cordo, corrdo;
wire [71:18] colddo, corddo;

// output signals to hold from done flags
wire [7:1] chluo, chruo;
wire [8:1] chlo, chro;
wire [8:2] chldo, chrdo;

// done signal
wire done; // done signal

// output from fifo
wire [159:0] fifoOut;

// column fifo empty flag
wire fifoEmpty;

columnUnit DUT (.clk(clk), .colstate(colstate), .xpos(xpos), .reset(reset), .done(done), .chdiri(chdiri),
	.cirrdi(cirrdi), .cirrui(cirrui), .cirddi(cirddi), .cirdi(cirdi), .ciri(ciri), .cirui(cirui), .ciruui(ciruui), 
	.cilddi(cilddi), .cildi(cildi), .cili(cili), .cilui(cilui), .ciluui(ciluui), .cilldi(cilldi), 
	.cillui(cillui), .colluo(colluo), .colldo(colldo), .coluuo(coluuo), .coluo(coluo), .colo(colo), .coldo(coldo), 
	.colddo(colddo), .coruuo(coruuo), .coruo(coruo), .coro(coro), .cordo(cordo), .corddo(corddo), 
	.corruo(corruo), .corrdo(corrdo), .chluo(chluo), .chruo(chruo), .chlo(chlo), .chro(chro), .chldo(chldo), .chrdo(chrdo),
	.fifoOut(fifoOut), .fifoEmpty(fifoEmpty), .rden(rden) );

// clock period: #100
reg clk_rst;
always begin
   if (clk_rst == 1'b1)
      clk = #1 1'b0;
   else
      #50 clk = ~clk;
end

initial begin
	// initialize clock
	$display("Initializing");
	clk_rst = 1'b1;
	#200; // wait for two cycles
	clk_rst = 1'b0;
	
	// initialize input regs
	reset = 1'b1;
	xpos = COLD;
	rden = 1'b0;
	
	// column state
	colstate = {
		BLACK, QUEEN,
		BLACK, PAWN,
		WHITE, EMPTY,
		WHITE, EMPTY,
		WHITE, EMPTY,
		WHITE, EMPTY,
		WHITE, PAWN,
		WHITE, BISHOP };
	
	// no neighbor inputs
	cirddi = {6{PVOID}}; 
	cilddi = {6{PVOID}};
	cirrdi= {7{PVOID}}; 
	cirdi= {7{PVOID}}; 
	cildi= {7{PVOID}}; 
	cilldi= {7{PVOID}};
	ciri= {8{PVOID}}; 
	cili= {8{PVOID}};
	cirrui= {7{PVOID}}; 
	cirui= {7{PVOID}}; 
	cilui= {7{PVOID}}; 
	cillui= {7{PVOID}};
	ciruui= {6{PVOID}}; 
	ciluui= {6{PVOID}};
	
	// no hold
	chdiri = 8'd0;
	
	// wait for one cycle and set reset to 0
	@(posedge clk) #10;
	reset = 1'b0;
	
	// wait for output
	repeat (NCIO) @(posedge clk); #10 
	
	// stream output
	rden = 1'b1;
	while (!fifoEmpty) begin
		@(posedge clk) #10;
	end
	
	// end simulation
	$stop; // For ModelSim
end

endmodule