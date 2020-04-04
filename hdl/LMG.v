module LMG (clk, 
);

input clk;

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

parameter COLA = 3'o0; parameter COLB = 3'o1; parameter COLC = 3'o2; parameter COLD = 3'o3;
parameter COLE = 3'o4; parameter COLF = 3'o5; parameter COLG = 3'o6; parameter COLH = 3'o7;

parameter ROW1 = 3'o0; parameter ROW2 = 3'o1; parameter ROW3 = 3'o2; parameter ROW4 = 3'o3;
parameter ROW5 = 3'o4; parameter ROW6 = 3'o5; parameter ROW7 = 3'o6; parameter ROW8 = 3'o7;


reg newboard, newboard_c; //

// Column A
columnUnit cola (.clk(clk), 
	);

// A8
wire [8:0] oro_a8, odo_a8, ordo_a8, orddo_a8, orrdo_a8;
cellUnit a8 (.clk(clk), .xpos(COLA), .ypos(ROW8), 
	.irrdi(PVOID), .irrui(PVOID), .irddi(PVOID), .irdi(PVOID), .iri(PVOID), .irui(PVOID), .iruui(PVOID),
	.idi(PVOID), .ilddi(PVOID), .ildi(PVOID), .ildi(PVOID), .illdi(PVOID),
	.iui(ouo_a7), .ili(olo_b8), .ilui(oluo_b7), .iluui(oluuo_b6), .illui(olluo_c7),
	.olluo(), .olldo(), .oluuo(), .oluo(), .olo(), .oldo(), .olddo(), .ouo(), .oruuo(), .oruo(), .orruo(), 
	.odo(odo_a8), .oro(oro_a8), .ordo(ordo_a8), .orddo(orddo_a8), .orrdo(orrdo_a8));

// A7
wire [8:0] ouo_a7, odo_a7, oruo_a7, oro_a7, ordo_a7, orddo_a7, orruo_a7, orrdo_a7;
cellUnit a7 (.clk(clk), xpos(COLA), .ypos(ROW7), 
	.irrdi(PVOID), .irrui(PVOID), .irddi(PVOID), .irdi(PVOID), .iri(PVOID), .irui(PVOID), 
	.iruui(PVOID), .ilddi(PVOID),
	.idi(odo_a8), .iui(ouo_a6), .ildi(oldo_b8), .ili(olo_b7), .ilui(oluo_b6), .iluui(oluuo_b5),
	.illdi(olldo_c8), .illui(olluo_c6),
	.olluo(), .olldo(), .oluuo(), .oluo(), .olo(), .oldo(), .olddo(), .oruuo(), 
	.ouo(ouo_a7), .odo(odo_a7), .oruo(oruo_a7), .oro(oro_a7), .ordo(ordo_a7), .orddo(orddo_a7), 
	.orruo(orddo_a7), .orrdo(orrdo_a7) );

// A6
wire [8:0] ouo_a6, odo_a6, oruuo_a6, oruo_a6, oro_a6, ordo_a6, orddo_a6, orruo_a6, orrdo_a6;
cellUnit a6 (.clk(clk), .xpos(COLA), .ypos(ROW6),
	.irrdi(PVOID), .irrui(PVOID), .irddi(PVOID), .irdi(PVOID), .iri(PVOID), .irui(PVOID), .iruui(PVOID),
	.idi(odo_a7), .iui(ouo_a5), .ilddi(olddo_b8), .ildi(oldo_b7), .ili(olo_b6), .ilui(oluo_b5),
	.iluui(oluuo_b4), .illdi(olldo_c7), .illui(olluo_c5),
	.olluo(), .olldo(), .oluuo(), .luo(), .olo(), .oldo(), .olddo(),
	.ouo(ouo_a6), .odo(odo_a6), .oruuo(oruuo_a6), .oruo(oruo_a6), .oro(oro_a6), .ordo(ordo_a6),
	.orddo(orddo_a6), .orruo(orruo_a6), .orrdo(orrdo_a6) );

// A5
wire [8:0] ouo_a5, odo_a5, oruuo_a5, oruo_a5, oro_a5, ordo_a5, orddo_a5, orruo_a5, orrdo_a5;
cellUnit a5 (.clk(clk), .xpos(COLA), .ypos(ROW5),
	.irrdi(PVOID), .irrui(PVOID), .irddi(PVOID), .irdi(PVOID), .iri(PVOID), .irui(PVOID), .iruui(PVOID),
	.idi(odo_a6), .iui(ouo_a4), .ilddi(olddo_b7), .ildi(oldo_b6), .ili(olo_b5), .ilui(oluo_b4),
	.iluui(oluuo_b3), .illdi(olldo_c6), .illui(olluo_c4),
	.olluo(), .olldo(), .oluuo(), .luo(), .olo(), .oldo(), .olddo(),
	.ouo(ouo_a5), .odo(odo_a5), .oruuo(oruuo_a5), .oruo(oruo_a5), .oro(oro_a5), .ordo(ordo_a5),
	.orddo(orddo_a5), .orruo(orruo_a5), .orrdo(orrdo_a5) );

// A4
wire [8:0] ouo_a4, odo_a4, oruuo_a4, oruo_a4, oro_a4, ordo_a4, orddo_a4, orruo_a4, orrdo_a4;
cellUnit a4 (.clk(clk), .xpos(COLA), .ypos(ROW4),
	.irrdi(PVOID), .irrui(PVOID), .irddi(PVOID), .irdi(PVOID), .iri(PVOID), .irui(PVOID), .iruui(PVOID),
	.idi(odo_a5), .iui(ouo_a3), .ilddi(olddo_b6), .ildi(oldo_b5), .ili(olo_b4), .ilui(oluo_b3),
	.iluui(oluuo_b2), .illdi(olldo_c5), .illui(olluo_c2),
	.olluo(), .olldo(), .oluuo(), .luo(), .olo(), .oldo(), .olddo(),
	.ouo(ouo_a4), .odo(odo_a4), .oruuo(oruuo_a4), .oruo(oruo_a4), .oro(oro_a4), .ordo(ordo_a4),
	.orddo(orddo_a4), .orruo(orruo_a4), .orrdo(orrdo_a4) );

// A3
wire [8:0] ouo_a3, odo_a3, oruuo_a3, oruo_a3, oro_a3, ordo_a3, orddo_a3, orruo_a3, orrdo_a3;
cellUnit a3 (.clk(clk), .xpos(COLA), .ypos(ROW3),
	.irrdi(PVOID), .irrui(PVOID), .irddi(PVOID), .irdi(PVOID), .iri(PVOID), .irui(PVOID), .iruui(PVOID),
	.idi(odo_a4), .iui(ouo_a2), .ilddi(olddo_b5), .ildi(oldo_b4), .ili(olo_b3), .ilui(oluo_b2),
	.iluui(oluuo_b1), .illdi(olldo_c4), .illui(olluo_c2),
	.olluo(), .olldo(), .oluuo(), .luo(), .olo(), .oldo(), .olddo(),
	.ouo(ouo_a3), .odo(odo_a3), .oruuo(oruuo_a3), .oruo(oruo_a3), .oro(oro_a3), .ordo(ordo_a3),
	.orddo(orddo_a3), .orruo(orruo_a3), .orrdo(orrdo_a3) );

// A2
wire [8:0] ouo_a2, odo_a2, oruuo_a2, oruo_a2, oro_a2, ordo_a2, orruo_a2, orrdo_a2;
cellUnit a2 (.clk(clk), .xpos(COLA), .ypos(ROW2),
	.irrdi(PVOID), .irrui(PVOID), .irddi(PVOID), .irdi(PVOID), .iri(PVOID), .irui(PVOID), .iruui(PVOID),
	.idi(odo_a3), .iui(ouo_a1), .ilddi(olddo_b4), .ildi(oldo_b3), .ili(olo_b2), .ilui(oluo_b1),
	.illdi(olldo_c3), .illui(olluo_c1),
	.olluo(), .olldo(), .oluuo(), .luo(), .olo(), .oldo(), .olddo(),
	.ouo(ouo_a2), .odo(odo_a2), .oruuo(oruuo_a2), .oruo(oruo_a2), .oro(oro_a2), .ordo(ordo_a2),
	.orruo(orruo_a2), .orrdo(orrdo_a2) );

// A1
wire [8:0] ouo_a1, oruuo_a1, oruo_a1, oro_a1, orruo_a1;
cellUnit a1 (.clk(clk), .xpos(COLA), .ypos(ROW1),
	.irrdi(PVOID), .irrui(PVOID), .irddi(PVOID), .irdi(PVOID), .iri(PVOID), .irui(PVOID), .iruui(PVOID),
	.idi(odo_a2), .ilddi(olddo_b3), .ildi(oldo_b2), .ili(olo_b1), .illdi(olldo_c2),
	.olluo(), .olldo(), .oluuo(), .luo(), .olo(), .oldo(), .olddo(),
	.ouo(ouo_a1), .oruuo(oruuo_a1), .oruo(oruo_a1), .oro(oro_a1), .orruo(orruo_a1) );

// Column B


endmodule