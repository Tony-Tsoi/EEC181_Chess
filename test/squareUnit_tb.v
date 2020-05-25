`timescale 1ps / 1ps

module squareUnit_tb (
);

//reg/wire
reg clk;
reg reset;
reg hold;
reg [2:0] xpos, ypos;
reg [3:0] cpiece;
reg [8:0] irrdi, irrui, irddi, irdi, iri, irui, iruui, idi, iui, 
	ilddi, ildi, ili, ilui, iluui, illdi, illui;
wire [8:0] orrdo, orruo, orddo, ordo, oro, oruo, oruuo, odo, ouo, 
	olddo, oldo, olo, oluo, oluuo, olldo, olluo;
wire hlu, hl, hld, hu, hd, hru, hr, hrd, done;
	
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
	xpos = 3'b100;
	ypos = 3'b100;
	cpiece = 4'b0100; //set the piece
	
	irrdi = 9'd0;
	irrui = 9'd0;
	irddi = 9'd0;
	irdi = 9'd0;
	iri = 9'd0;
	irui = 9'd0;
	iruui = 9'd0;
	idi = 9'd0;
	iui = 9'd0; 
	ilddi = 9'd0;
	ildi = 9'd0;
	ili = 9'd0;
	ilui = 9'd0;
	iluui = 9'd0;
	illdi = 9'd0;
	illui = 9'd0;
	
	#20;
	reset = 1'b1;
	
	#20;
	reset = 1'b0;
	
	#60;
end

always begin
	#10;
	clk = ~clk;
end

endmodule
