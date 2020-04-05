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
	.olluo(), .olldo(), .oluuo(), .oluo(), .olo(), .oldo(), .olddo(),
	.ouo(ouo_a6), .odo(odo_a6), .oruuo(oruuo_a6), .oruo(oruo_a6), .oro(oro_a6), .ordo(ordo_a6),
	.orddo(orddo_a6), .orruo(orruo_a6), .orrdo(orrdo_a6) );

// A5
wire [8:0] ouo_a5, odo_a5, oruuo_a5, oruo_a5, oro_a5, ordo_a5, orddo_a5, orruo_a5, orrdo_a5;
cellUnit a5 (.clk(clk), .xpos(COLA), .ypos(ROW5),
	.irrdi(PVOID), .irrui(PVOID), .irddi(PVOID), .irdi(PVOID), .iri(PVOID), .irui(PVOID), .iruui(PVOID),
	.idi(odo_a6), .iui(ouo_a4), .ilddi(olddo_b7), .ildi(oldo_b6), .ili(olo_b5), .ilui(oluo_b4),
	.iluui(oluuo_b3), .illdi(olldo_c6), .illui(olluo_c4),
	.olluo(), .olldo(), .oluuo(), .oluo(), .olo(), .oldo(), .olddo(),
	.ouo(ouo_a5), .odo(odo_a5), .oruuo(oruuo_a5), .oruo(oruo_a5), .oro(oro_a5), .ordo(ordo_a5),
	.orddo(orddo_a5), .orruo(orruo_a5), .orrdo(orrdo_a5) );

// A4
wire [8:0] ouo_a4, odo_a4, oruuo_a4, oruo_a4, oro_a4, ordo_a4, orddo_a4, orruo_a4, orrdo_a4;
cellUnit a4 (.clk(clk), .xpos(COLA), .ypos(ROW4),
	.irrdi(PVOID), .irrui(PVOID), .irddi(PVOID), .irdi(PVOID), .iri(PVOID), .irui(PVOID), .iruui(PVOID),
	.idi(odo_a5), .iui(ouo_a3), .ilddi(olddo_b6), .ildi(oldo_b5), .ili(olo_b4), .ilui(oluo_b3),
	.iluui(oluuo_b2), .illdi(olldo_c5), .illui(olluo_c2),
	.olluo(), .olldo(), .oluuo(), .oluo(), .olo(), .oldo(), .olddo(),
	.ouo(ouo_a4), .odo(odo_a4), .oruuo(oruuo_a4), .oruo(oruo_a4), .oro(oro_a4), .ordo(ordo_a4),
	.orddo(orddo_a4), .orruo(orruo_a4), .orrdo(orrdo_a4) );

// A3
wire [8:0] ouo_a3, odo_a3, oruuo_a3, oruo_a3, oro_a3, ordo_a3, orddo_a3, orruo_a3, orrdo_a3;
cellUnit a3 (.clk(clk), .xpos(COLA), .ypos(ROW3),
	.irrdi(PVOID), .irrui(PVOID), .irddi(PVOID), .irdi(PVOID), .iri(PVOID), .irui(PVOID), .iruui(PVOID),
	.idi(odo_a4), .iui(ouo_a2), .ilddi(olddo_b5), .ildi(oldo_b4), .ili(olo_b3), .ilui(oluo_b2),
	.iluui(oluuo_b1), .illdi(olldo_c4), .illui(olluo_c2),
	.olluo(), .olldo(), .oluuo(), .oluo(), .olo(), .oldo(), .olddo(),
	.ouo(ouo_a3), .odo(odo_a3), .oruuo(oruuo_a3), .oruo(oruo_a3), .oro(oro_a3), .ordo(ordo_a3),
	.orddo(orddo_a3), .orruo(orruo_a3), .orrdo(orrdo_a3) );

// A2
wire [8:0] ouo_a2, odo_a2, oruuo_a2, oruo_a2, oro_a2, ordo_a2, orruo_a2, orrdo_a2;
cellUnit a2 (.clk(clk), .xpos(COLA), .ypos(ROW2),
	.irrdi(PVOID), .irrui(PVOID), .irddi(PVOID), .irdi(PVOID), .iri(PVOID), .irui(PVOID), .iruui(PVOID),
	.idi(odo_a3), .iui(ouo_a1), .ilddi(olddo_b4), .ildi(oldo_b3), .ili(olo_b2), .ilui(oluo_b1),
	.illdi(olldo_c3), .illui(olluo_c1),
	.olluo(), .olldo(), .oluuo(), .oluo(), .olo(), .oldo(), .olddo(),
	.ouo(ouo_a2), .odo(odo_a2), .oruuo(oruuo_a2), .oruo(oruo_a2), .oro(oro_a2), .ordo(ordo_a2),
	.orruo(orruo_a2), .orrdo(orrdo_a2) );

// A1
wire [8:0] ouo_a1, oruuo_a1, oruo_a1, oro_a1, orruo_a1;
cellUnit a1 (.clk(clk), .xpos(COLA), .ypos(ROW1),
	.irrdi(PVOID), .irrui(PVOID), .irddi(PVOID), .irdi(PVOID), .iri(PVOID), .irui(PVOID), .iruui(PVOID),
	.idi(odo_a2), .ilddi(olddo_b3), .ildi(oldo_b2), .ili(olo_b1), .illdi(olldo_c2),
	.olluo(), .olldo(), .oluuo(), .oluo(), .olo(), .oldo(), .olddo(),
	.ouo(ouo_a1), .oruuo(oruuo_a1), .oruo(oruo_a1), .oro(oro_a1), .orruo(orruo_a1) );

// Column B
columnUnit colb (.clk(clk), 
	);

// B8
wire [8:0] olo_b8, oldo_b8, olddo_b8, odo_b8, oro_b8, ordo_b8, orddo_b8, orrdo_b8;
cellUnit b8 (.clk(clk), .xpos(COLB), .ypos(ROW8),
	.irrdi(PVOID), .irrui(PVOID), .irddi(PVOID), .irdi(PVOID), .idi(PVOID), .ilddi(PVOID),
	.ildi(PVOID), .illdi(PVOID),
	.iri(oro_a8), .irui(oruo_a7), .iruui(oruuo_a6), .iui(ouo_b7), .ili(olo_c8), .ilui(oluo_c7),
	.iluui(oluuo_c6), .illui(olluo_d7),
	.olluo(), .olldo(), .oluuo(), .oluo(), .ouo(), .oruuo(), .oruo(), .orruo(),
	.olo(olo_b8), .oldo(oldo_b8), .olddo(olddo_b8), .odo(odo_b8), .oro(oro_b8), .ordo(ordo_b8),
	.orddo(orddo_b8), .orrdo(orrdo_b8) );

// B7
wire [8:0] oluo_b7, olo_b7, oldo_b7, olddo_b7, ouo_b7, odo_b7, oruo_b7, oro_b7, ordo_b7, orddo_b7,
	orruo_b7, orrdo_b7;
cellUnit b7 (.clk(clk), .xpos(COLB), .ypos(ROW7),
	.irrdi(PVOID), .irrui(PVOID), .irddi(PVOID), .ilddi(PVOID),
	.irdi(ordo_a8), .iri(oro_a7), .irui(oruo_a6), .iruui(oruuo_a5), .idi(odo_b8), .iui(ouo_b6),
	.ildi(oldo_c8), .ili(olo_c7), .ilui(oluo_c6), .iluui(oluuo_c5), .illdi(olldo_d8), .illui(olluo_d6),
	.olluo(), .olldo(), .oluuo(), .oruuo(),
	.oluo(oluo_b7), .olo(olo_b7), .oldo(oldo_b7), .olddo(olddo_b7), .ouo(ouo_b7), .odo(odo_b7),
	.oruo(oruo_b7), .oro(oro_b7), .ordo(ordo_b7), .orddo(orddo_b7), .orruo(orruo_b7), .orrdo(orrdo_b7) );

// B6
wire [8:0] oluuo_b6, oluo_b6, olo_b6, oldo_b6, olddo_b6, ouo_b6, odo_b6, oruuo_b6, oruo_b6, oro_b6, 
	ordo_b6, orddo_b6, orruo_b6, orrdo_b6;
cellUnit b6 (.clk(clk), .xpos(COLB), .ypos(ROW6),
	.irrdi(PVOID), .irrui(PVOID),
	.irddi(orddo_a8), .irdi(ordo_a7), .iri(oro_a6), .irui(oruo_a5), .iruui(oruuo_a4), .idi(odo_b7), 
	.iui(ouo_b5), .ilddi(olddo_c8), .ildi(oldo_c7), .ili(olo_c6), .ilui(oluo_c5), .iluui(oluuo_c4), 
	.illdi(olldo_d7), .illui(olluo_d5),
	.olluo(), .olldo(),
	.oluuo(oluuo_b6), .oluo(oluo_b6), .olo(olo_b6), .oldo(oldo_b6), .olddo(olddo_b6), .ouo(ouo_b6), 
	.odo(odo_b6), .oruuo(oruuo_b6), .oruo(oruo_b6), .oro(oro_b6), .ordo(ordo_b6), .orddo(orddo_b6), 
	.orruo(orruo_b6), .orrdo(orrdo_b6) );

// B5
wire [8:0] oluuo_b5, oluo_b5, olo_b5, oldo_b5, olddo_b5, ouo_b5, odo_b5, oruuo_b5, oruo_b5, oro_b5, 
	ordo_b5, orddo_b5, orruo_b5, orrdo_b5;
cellUnit b5 (.clk(clk), .xpos(COLB), .ypos(ROW5),
	.irrdi(PVOID), .irrui(PVOID),
	.irddi(orddo_a7), .irdi(ordo_a6), .iri(oro_a5), .irui(oruo_a4), .iruui(oruuo_a3), .idi(odo_b6), 
	.iui(ouo_b4), .ilddi(olddo_c7), .ildi(oldo_c6), .ili(olo_c5), .ilui(oluo_c4), .iluui(oluuo_c3), 
	.illdi(olldo_d6), .illui(olluo_d4),
	.olluo(), .olldo(),
	.oluuo(oluuo_b5), .oluo(oluo_b5), .olo(olo_b5), .oldo(oldo_b5), .olddo(olddo_b5), .ouo(ouo_b5), 
	.odo(odo_b5), .oruuo(oruuo_b5), .oruo(oruo_b5), .oro(oro_b5), .ordo(ordo_b5), .orddo(orddo_b5), 
	.orruo(orruo_b5), .orrdo(orrdo_b5) );

// B4
wire [8:0] oluuo_b4, oluo_b4, olo_b4, oldo_b4, olddo_b4, ouo_b4, odo_b4, oruuo_b4, oruo_b4, oro_b4, 
	ordo_b4, orddo_b4, orruo_b4, orrdo_b4;
cellUnit b4 (.clk(clk), .xpos(COLB), .ypos(ROW4),
	.irrdi(PVOID), .irrui(PVOID),
	.irddi(orddo_a6), .irdi(ordo_a5), .iri(oro_a4), .irui(oruo_a3), .iruui(oruuo_a2), .idi(odo_b5), 
	.iui(ouo_b3), .ilddi(olddo_c6), .ildi(oldo_c5), .ili(olo_c4), .ilui(oluo_c3), .iluui(oluuo_c2), 
	.illdi(olldo_d5), .illui(olluo_d3),
	.olluo(), .olldo(),
	.oluuo(oluuo_b4), .oluo(oluo_b4), .olo(olo_b4), .oldo(oldo_b4), .olddo(olddo_b4), .ouo(ouo_b4), 
	.odo(odo_b4), .oruuo(oruuo_b4), .oruo(oruo_b4), .oro(oro_b4), .ordo(ordo_b4), .orddo(orddo_b4), 
	.orruo(orruo_b4), .orrdo(orrdo_b4) );

// B3
wire [8:0] oluuo_b3, oluo_b3, olo_b3, oldo_b3, olddo_b3, ouo_b3, odo_b3, oruuo_b3, oruo_b3, oro_b3, 
	ordo_b3, orddo_b3, orruo_b3, orrdo_b3;
cellUnit b3 (.clk(clk), .xpos(COLB), .ypos(ROW3),
	.irrdi(PVOID), .irrui(PVOID),
	.irddi(orddo_a5), .irdi(ordo_a4), .iri(oro_a3), .irui(oruo_a2), .iruui(oruuo_a1), .idi(odo_b4), 
	.iui(ouo_b2), .ilddi(olddo_c5), .ildi(oldo_c4), .ili(olo_c3), .ilui(oluo_c2), .iluui(oluuo_c1), 
	.illdi(olldo_d4), .illui(olluo_d2),
	.olluo(), .olldo(),
	.oluuo(oluuo_b3), .oluo(oluo_b3), .olo(olo_b3), .oldo(oldo_b3), .olddo(olddo_b3), .ouo(ouo_b3), 
	.odo(odo_b3), .oruuo(oruuo_b3), .oruo(oruo_b3), .oro(oro_b3), .ordo(ordo_b3), .orddo(orddo_b3), 
	.orruo(orruo_b3), .orrdo(orrdo_b3) );

// B2
wire [8:0] oluuo_b2, oluo_b2, olo_b2, oldo_b2, ouo_b2, odo_b2, oruuo_b2, oruo_b2, oro_b2, ordo_b2, 
	orruo_b2, orrdo_b2;
cellUnit b2 (.clk(clk), .xpos(COLB), .ypos(ROW2),
	.irrdi(PVOID), .irrui(PVOID), .iruui(PVOID), .iluui(PVOID),
	.irddi(orddo_a4), .irdi(ordo_a3), .iri(oro_a2), .irui(oruo_a1), .idi(odo_b3), .iui(ouo_b1), 
	.ilddi(olddo_c4), .ildi(oldo_c3), .ili(olo_c2), .ilui(oluo_c1), .illdi(olldo_d3), .illui(olluo_d1),
	.olluo(), .olldo(), .olddo(), .orddo(),
	.oluuo(oluuo_b2), .oluo(oluo_b2), .olo(olo_b2), .oldo(oldo_b2), .ouo(ouo_b2), .odo(odo_b2), 
	.oruuo(oruuo_b2), .oruo(oruo_b2), .oro(oro_b2), .ordo(ordo_b2), .orruo(orruo_b2), .orrdo(orrdo_b2) );

// B1
wire [8:0] oluuo_b1, oluo_b1, olo_b1, ouo_b1, oruuo_b1, oruo_b1, oro_b1, orruo_b1;
cellUnit b1 (.clk(clk), .xpos(COLB), .ypos(ROW1),
	.irrdi(PVOID), .irrui(PVOID), .irui(PVOID), .iruui(PVOID), .iui(PVOID), .ilui(PVOID), .iluui(PVOID),
	.illui(PVOID),
	.irddi(orddo_a3), .irdi(ordo_a2), .iri(oro_a1), .idi(odo_b2), .ilddi(olddo_c3), .ildi(oldo_c2), 
	.ili(olo_c1), .illdi(olldo_d2),
	.olluo(), .olldo(), .oldo(), .olddo(), .odo(), .ordo(), .orddo(), .orrdo(),
	.oluuo(oluuo_b1), .oluo(oluo_b1), .olo(olo_b1), .ouo(ouo_b1), 
	.oruuo(oruuo_b1), .oruo(oruo_b1), .oro(oro_b1), .orruo(orruo_b1) );









endmodule