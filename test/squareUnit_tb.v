`timescale 1ps / 1ps

module squareUnit_tb (
);

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

parameter ROW1 = 3'o0; parameter ROW2 = 3'o1; parameter ROW3 = 3'o2; parameter ROW4 = 3'o3;
parameter ROW5 = 3'o4; parameter ROW6 = 3'o5; parameter ROW7 = 3'o6; parameter ROW8 = 3'o7;

parameter COLA = 3'o0; parameter COLB = 3'o1; parameter COLC = 3'o2; parameter COLD = 3'o3;
parameter COLE = 3'o4; parameter COLF = 3'o5; parameter COLG = 3'o6; parameter COLH = 3'o7;

//reg/wire
reg clk;
reg reset;
reg hold;
reg rden;
reg [2:0] xpos, ypos;
reg [3:0] cpiece;
reg [8:0] irrdi, irrui, irddi, irdi, iri, irui, iruui, idi, iui, 
	ilddi, ildi, ili, ilui, iluui, illdi, illui;
wire [8:0] orrdo, orruo, orddo, ordo, oro, oruo, oruuo, odo, ouo, 
	olddo, oldo, olo, oluo, oluuo, olldo, olluo;
wire hlu, hl, hld, hu, hd, hru, hr, hrd, done;
wire [159:0] fifoOut;
wire [8:0] PVOID = {xpos, ypos, EMPTY}; // denotes an empty space at self
	
//module
squareUnit DUT(
	.irrdi(irrdi), 
	.irrui(irrui), 
	.irddi(irrddi),
	.irdi(irdi),
	.iri(iri), 
	.irui(irui),
	.iruui(iruui),
	.idi(idi), 
	.iui(iui), 
	.ilddi(ilddi), 
	.ildi(ildi), 
	.ili(ili), 
	.ilui(ilui), 
	.iluui(iluui),
	.illdi(illdi), 
	.illui(illui),
	.orrdo(orrdo), 
	.orruo(orruo), 
	.orddo(orddo), 
	.ordo(ordo), 
	.oro(oro), 
	.oruo(oruo), 
	.oruuo(oruuo), 
	.odo(odo), 
	.ouo(ouo),	
	.olddo(olddo), 
	.oldo(oldo), 
	.olo(olo), 
	.oluo(oluo), 
	.oluuo(oluuo), 
	.olldo(olldo), 
	.olluo(olluo),
	.hlu(hlu), 
	.hl(hl), 
	.hld(hld), 
	.hu(hu), 
	.hd(hd), 
	.hru(hru), 
	.hr(hr), 
	.hrd(hrd),
	.clk(clk), 
	.xpos(xpos), 
	.ypos(ypos), 
	.cpiece(cpiece), 
	.reset(reset), 
	.done(done), 
	.fifoOut(fifoOut), 
	.hold(hold), 
	.rden(rden)
);

initial begin
	clk = 1'b0;
	reset = 1'b0;
	hold = 1'b0;
	rden = 1'b0;
	xpos = COLE;
	ypos = ROW5;
	cpiece = {WHITE,EMPTY}; //set the piece
	
	irrdi = PVOID; //set the inputs for the test case
	irrui = PVOID;
	irddi = PVOID;
	irdi = PVOID;
	iri = PVOID;
	irui = PVOID;
	iruui = PVOID;
	idi = PVOID;
	iui = 9'b100101001; 
	ilddi = PVOID;
	ildi = PVOID;
	ili = PVOID;
	ilui = PVOID;
	iluui = PVOID;
	illdi = PVOID;
	illui = PVOID;
	
	#200;
	reset = 1'b1;
	
	#200;
	reset = 1'b0;
	
	#1000;
	rden = 1'b1; //read moves from the square fifo
	#200;
end

always begin
	#100;
	clk = ~clk;
end

endmodule
