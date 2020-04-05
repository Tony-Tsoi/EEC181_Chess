module LMG (clk, newboard
);

input clk, newboard;

// parameter declarations
parameter PVOID = 9'h0; // it's just {3'o0, 3'o0, EMPTY} - denotes an empty space at xpos = 0, ypos = 0
parameter PVOID8 = 72'h0;
parameter PVOID7 = 63'h0;
parameter PVOID6 = 54'h0;

parameter COLA = 3'o0; parameter COLB = 3'o1; parameter COLC = 3'o2; parameter COLD = 3'o3;
parameter COLE = 3'o4; parameter COLF = 3'o5; parameter COLG = 3'o6; parameter COLH = 3'o7;

// Column A
wire [53:0] cilddi_a, coruuo_a;
wire [62:0] cidi_a, cildi_a, cilldi_a, couo_a, coruo_a, corruo_a;
wire [71:0] cili_a, coro_a;
wire [71:9] ciui_a, cilui_a, cillui_a, codo_a, cordo_a, corrdo_a;
wire [71:18] ciluui_a, corddo_a;

columnUnit cola (.clk(clk), .xpos(COLA),
	.cirrdi(PVOID7), .cirrui(PVOID7), .cirddi(PVOID6), .cirdi(PVOID7), .ciri(PVOID8),
	.cirui(PVOID7), .ciruui(PVOID6),
	.cidi(cidi_a), .ciui(ciui_a), .cilddi(cilddi_a), .cildi(cildi_a), .cili(cili_a), 
	.cilui(cilui_a), .ciluui(ciluui_a), .cilldi(cilldi_a), .cillui(cillui_a),
	.colluo(), .colldo(), .coluuo(), .coluo(), .colo(), .coldo(), .colddo(),
	.couo(couo_a), .codo(codo_a), .coruuo(coruuo_a), .coruo(coruo_a), .coro(coro_a),
	.cordo(cordo_a), .corddo(corddo_a), .corruo(corruo_a), .corrdo(corrdo_a) );

// Column B
wire [53:0] cirddi_b, cilddi_b;
wire [62:0] cirdi_b, cidi_b, cildi_b, cilldi_b;
wire [71:0] ciri_b, cili_b;
wire [71:9] cirui_b, ciui_b, cilui_b, cillui_b;
wire [71:18] ciruui_b, ciluui_b;

wire [53:0] coluuo_b, coruuo_b;
wire [62:0] coluo_b, couo_b, coruo_b, corruo_b;
wire [71:0] colo_b, coro_b;
wire [71:9] coldo_b, codo_b, cordo_b, corrdo_b;
wire [71:18] colddo_b, corddo_b;

columnUnit colb (.clk(clk), .xpos(COLB),
	.cirrdi(PVOID7), .cirrui(PVOID7), 
	.cirddi(cirddi_b), .cirdi(cirdi_b), .ciri(ciri_b), .cirui(cirui_b), .ciruui(ciruui_b),
	.cidi(cidi_b), .ciui(ciui_b), .cilddi(cilddi_b), .cildi(cildi_b), .cili(cili_b), 
	cilui(cilui_b), .ciluui(ciluui_b), .cilldi(cilldi_b), .cillui(cillui_b),
	.colluo(), .colldo(),
	.coluuo(coluuo_b), .coluo(coluo_b), .colo(colo_b), .coldo(coldo_b), .colddo(colddo_b),
	.couo(couo_b), .codo(codo_b), .coruuo(coruuo_b), .coruo(coruo_b), .coro(coro_b),
	.cordo(cordo_b), .corddo(corddo_b), .corruo(corruo_b), .corrdo(corrdo_b) );

// Column C
wire [53:0] cirddi_c, cilddi_c;
wire [62:0] cirrdi_c, cirdi_c, cidi_c, cildi_c, cilldi_c;
wire [71:0] ciri_c, cili_c;
wire [71:9] cirrui_c, cirui_c, ciui_c, cilui_c, cillui_c;
wire [71:18] ciruui_c, ciluui_c;

wire [53:0] coluuo_c, coruuo_c;
wire [62:0] colluo_c, coluo_c, couo_c, coruo_c, corruo_c;
wire [71:0] colo_c, coro_c;
wire [71:9] colldo_c, coldo_c, codo_c, cordo_c, corrdo_c;
wire [71:18] colddo_c, corddo_c;

columnUnit colc (.clk(clk), .xpos(COLC),
	.cirrdi(cirrdi_c), .cirrui(cirrui_c), 
	.cirddi(cirddi_c), .cirdi(cirdi_c), .ciri(ciri_c), .cirui(cirui_c), .ciruui(ciruui_c),
	.cidi(cidi_c), .ciui(ciui_c), .cilddi(cilddi_c), .cildi(cildi_c), .cili(cili_c), 
	cilui(cilui_c), .ciluui(ciluui_c), .cilldi(cilldi_c), .cillui(cillui_c),
	.colluo(colluo_c), .colldo(colldo_c),
	.coluuo(coluuo_c), .coluo(coluo_c), .colo(colo_c), .coldo(coldo_c), .colddo(colddo_c),
	.couo(couo_c), .codo(codo_c), .coruuo(coruuo_c), .coruo(coruo_c), .coro(coro_c),
	.cordo(cordo_c), .corddo(corddo_c), .corruo(corruo_c), .corrdo(corrdo_c) );

// Column D
wire [53:0] cirddi_d, cilddi_d;
wire [62:0] cirrdi_d, cirdi_d, cidi_d, cildi_d, cilldi_d;
wire [71:0] ciri_d, cili_d;
wire [71:9] cirrui_d, cirui_d, ciui_d, cilui_d, cillui_d;
wire [71:18] ciruui_d, ciluui_d;

wire [53:0] coluuo_d, coruuo_d;
wire [62:0] colluo_d, coluo_d, couo_d, coruo_d, corruo_d;
wire [71:0] colo_d, coro_d;
wire [71:9] colldo_d, coldo_d, codo_d, cordo_d, corrdo_d;
wire [71:18] colddo_d, corddo_d;

columnUnit cold (.clk(clk), .xpos(COLD),
	.cirrdi(cirrdi_d), .cirrui(cirrui_d), 
	.cirddi(cirddi_d), .cirdi(cirdi_d), .ciri(ciri_d), .cirui(cirui_d), .ciruui(ciruui_d),
	.cidi(cidi_d), .ciui(ciui_d), .cilddi(cilddi_d), .cildi(cildi_d), .cili(cili_d), 
	cilui(cilui_d), .ciluui(ciluui_d), .cilldi(cilldi_d), .cillui(cillui_d),
	.colluo(colluo_d), .colldo(colldo_d),
	.coluuo(coluuo_d), .coluo(coluo_d), .colo(colo_d), .coldo(coldo_d), .colddo(colddo_d),
	.couo(couo_d), .codo(codo_d), .coruuo(coruuo_d), .coruo(coruo_d), .coro(coro_d),
	.cordo(cordo_d), .corddo(corddo_d), .corruo(corruo_d), .corrdo(corrdo_d) );

// Column E
wire [53:0] cirddi_e, cilddi_e;
wire [62:0] cirrdi_e, cirdi_e, cidi_e, cildi_e, cilldi_e;
wire [71:0] ciri_e, cili_e;
wire [71:9] cirrui_e, cirui_e, ciui_e, cilui_e, cillui_e;
wire [71:18] ciruui_e, ciluui_e;

wire [53:0] coluuo_e, coruuo_e;
wire [62:0] colluo_e, coluo_e, couo_e, coruo_e, corruo_e;
wire [71:0] colo_e, coro_e;
wire [71:9] colldo_e, coldo_e, codo_e, cordo_e, corrdo_e;
wire [71:18] colddo_e, corddo_e;

columnUnit cole (.clk(clk), .xpos(COLE),
	.cirrdi(cirrdi_e), .cirrui(cirrui_e), 
	.cirddi(cirddi_e), .cirdi(cirdi_e), .ciri(ciri_e), .cirui(cirui_e), .ciruui(ciruui_e),
	.cidi(cidi_e), .ciui(ciui_e), .cilddi(cilddi_e), .cildi(cildi_e), .cili(cili_e), 
	cilui(cilui_e), .ciluui(ciluui_e), .cilldi(cilldi_e), .cillui(cillui_e),
	.colluo(colluo_e), .colldo(colldo_e),
	.coluuo(coluuo_e), .coluo(coluo_e), .colo(colo_e), .coldo(coldo_e), .colddo(colddo_e),
	.couo(couo_e), .codo(codo_e), .coruuo(coruuo_e), .coruo(coruo_e), .coro(coro_e),
	.cordo(cordo_e), .corddo(corddo_e), .corruo(corruo_e), .corrdo(corrdo_e) );

// Column F
wire [53:0] cirddi_f, cilddi_f;
wire [62:0] cirrdi_f, cirdi_f, cidi_f, cildi_f, cilldi_f;
wire [71:0] ciri_f, cili_f;
wire [71:9] cirrui_f, cirui_f, ciui_f, cilui_f, cillui_f;
wire [71:18] ciruui_f, ciluui_f;

wire [53:0] coluuo_f, coruuo_f;
wire [62:0] colluo_f, coluo_f, couo_f, coruo_f, corruo_f;
wire [71:0] colo_f, coro_f;
wire [71:9] colldo_f, coldo_f, codo_f, cordo_f, corrdo_f;
wire [71:18] colddo_f, corddo_f;

columnUnit colf (.clk(clk), .xpos(COLF),
	.cirrdi(cirrdi_f), .cirrui(cirrui_f), 
	.cirddi(cirddi_f), .cirdi(cirdi_f), .ciri(ciri_f), .cirui(cirui_f), .ciruui(ciruui_f),
	.cidi(cidi_f), .ciui(ciui_f), .cilddi(cilddi_f), .cildi(cildi_f), .cili(cili_f), 
	cilui(cilui_f), .ciluui(ciluui_f), .cilldi(cilldi_f), .cillui(cillui_f),
	.colluo(colluo_f), .colldo(colldo_f),
	.coluuo(coluuo_f), .coluo(coluo_f), .colo(colo_f), .coldo(coldo_f), .colddo(colddo_f),
	.couo(couo_f), .codo(codo_f), .coruuo(coruuo_f), .coruo(coruo_f), .coro(coro_f),
	.cordo(cordo_f), .corddo(corddo_f), .corruo(corruo_f), .corrdo(corrdo_f) );

// Column G
wire [53:0] cirddi_g, cilddi_g;
wire [62:0] cirrdi_g, cirdi_g, cidi_g, cildi_g;
wire [71:0] ciri_g, cili_g;
wire [71:9] cirrui_g, cirui_g, ciui_g, cilui_g;
wire [71:18] ciruui_g, ciluui_g;

wire [53:0] coluuo_g, coruuo_g;
wire [62:0] colluo_g, coluo_g, couo_g, coruo_g;
wire [71:0] colo_g, coro_g;
wire [71:9] colldo_g, coldo_g, codo_g, cordo_g;
wire [71:18] colddo_g, corddo_g;

columnUnit colg (.clk(clk), .xpos(COLG),
	.cirrdi(cirrdi_g), .cirrui(cirrui_g), 
	.cirddi(cirddi_g), .cirdi(cirdi_g), .ciri(ciri_g), .cirui(cirui_g), .ciruui(ciruui_g),
	.cidi(cidi_g), .ciui(ciui_g), .cilddi(cilddi_g), .cildi(cildi_g), .cili(cili_g), 
	cilui(cilui_g), .ciluui(ciluui_g), .cilldi(PVOID7), .cillui(PVOID7),
	.colluo(colluo_g), .colldo(colldo_g),
	.coluuo(coluuo_g), .coluo(coluo_g), .colo(colo_g), .coldo(coldo_g), .colddo(colddo_g),
	.couo(couo_g), .codo(codo_g), .coruuo(coruuo_g), .coruo(coruo_g), .coro(coro_g),
	.cordo(cordo_g), .corddo(corddo_g), .corruo(), .corrdo() );

// Column H
wire [53:0] cirddi_h;
wire [62:0] cirrdi_h, cirdi_h, cidi_h;
wire [71:0] ciri_h;
wire [71:9] cirrui_h, cirui_h, ciui_h;
wire [71:18] ciruui_h;

wire [53:0] coluuo_h;
wire [62:0] colluo_h, coluo_h, couo_h;
wire [71:0] colo_h;
wire [71:9] colldo_h, coldo_h, codo_h;
wire [71:18] colddo_h;

columnUnit colh (.clk(clk), .xpos(COLH),
	.cirrdi(cirrdi_h), .cirrui(cirrui_h), 
	.cirddi(cirddi_h), .cirdi(cirdi_h), .ciri(ciri_h), .cirui(cirui_h), .ciruui(ciruui_h),
	.cidi(cidi_h), .ciui(ciui_h), .cilddi(PVOID6), .cildi(PVOID7), .cili(PVOID8), 
	cilui(PVOID7), .ciluui(PVOID6), .cilldi(PVOID7), .cillui(PVOID7),
	.colluo(colluo_h), .colldo(colldo_h),
	.coluuo(coluuo_h), .coluo(coluo_h), .colo(colo_h), .coldo(coldo_h), .colddo(colddo_h),
	.couo(couo_h), .codo(codo_h), .coruuo(), .coruo(), .coro(),
	.cordo(), .corddo(), .corruo(), .corrdo() );


endmodule