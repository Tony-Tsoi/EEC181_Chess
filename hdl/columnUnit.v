module columnUnit (clk, bstate, xpos, reset, done, chdiri
cirrdi, cirrui, cirddi, cirdi, ciri, cirui, ciruui, cidi, ciui, cilddi, cildi, 
cili, cilui, ciluui, cilldi, cillui,
colluo, colldo, coluuo, coluo, colo, coldo, colddo, couo, codo, coruuo, coruo, 
coro, cordo, corddo, corruo, corrdo,
chluo, chruo, chlo, chro, chldo, chrdo
);
// TODO: Add breakdown board state
// TODO: Add FIFO to collect from sq output, add output
// TODO: Add output to control and sort by MVVLVA

input clk, reset;
input [2:0] xpos;
input [255:0] bstate; // board state

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
output [8:2] chluo, chruo;
output [8:1] chlo, chro;
output [7:1] chldo, chrdo;

// done signal
// TODO: change this logic for getting moves from each square: should be flagged by state machine
output done = &{done_sqs};

// parameter declarations
parameter PVOID = 9'h0; // it's just {3'o0, 3'o0, EMPTY} - denotes an empty space at xpos = 0, ypos = 0

parameter ROW1 = 3'o0; parameter ROW2 = 3'o1; parameter ROW3 = 3'o2; parameter ROW4 = 3'o3;
parameter ROW5 = 3'o4; parameter ROW6 = 3'o5; parameter ROW7 = 3'o6; parameter ROW8 = 3'o7;

// done signals from each squareUnit
wire [8:1] done_sqs;

// hold up down signals from square outputs inside this column
wire [7:1] chuo;
wire [8:2] chdo;

// hold signal logic for squares
wire [8:1] holds;
assign hold[8] = |{chuo[7:1]           , chdiri[8]}};
assign hold[7] = |{chuo[6:1], chdo[7  ], chdiri[7]};
assign hold[6] = |{chuo[5:1], chdo[7:6], chdiri[6]}};
assign hold[5] = |{chuo[4:1], chdo[7:5], chdiri[5]}};
assign hold[4] = |{chuo[3:1], chdo[7:4], chdiri[4]}};
assign hold[3] = |{chuo[2:1], chdo[7:3], chdiri[3]}};
assign hold[2] = |{chuo[  1], chdo[7:2], chdiri[2]}};
assign hold[1] = |{           chdo[7:1], chdiri[1]}};

// Row 8
squareUnit sq8 (.clk(clk), .xpos(xpos), .ypos(ROW8), .reset(reset), .done(done_sqs[8]), .hold(holds[8]),
	.irrdi(PVOID), .irddi(PVOID), .irdi(PVOID), .idi(PVOID), .ilddi(PVOID), .ildi(PVOID), .illdi(PVOID),
	.irrui(cirrui[71:63]), .iri(ciri[71:63]), .irui(cirui[71:63]), .iruui(ciruui[71:63]), .iui(ciui[71:63]), 
	.ili(cili[71:63]), .ilui(cilui[71:63]), .iluui(ciluui[71:63]), .illui(cillui[71:63]),
	.olluo(), .oluuo(), .oluo(), .ouo(), .oruuo(), .oruo(), .orruo(),
	.olldo(colldo[71:63]), .olo(colo[[71:63]), .oldo(coldo[71:63]), .olddo(colddo[71:63]), .odo(codo[71:63]),
	.oro(coro[71:63]), .ordo(cordo[71:63]), .orddo(corddo[71:63]), .orrdo(corrdo[71:63]),
	.hlu(), .hru(), .hu(), .hd(chdo[8]),
	.hl(chlo[8]), .hr(chro[8]), .hld(chldo[8]), .hrd(chrdo[8]) );

// Row 7
squareUnit sq7 (.clk(clk), .xpos(xpos), .ypos(ROW7), .reset(reset), .done(done_sqs[7]), .hold(holds[7]),
	.irddi(PVOID), .ilddi(PVOID), 
	.irrdi(cirrdi[62:54]), .irrui(cirrui[62:54]), .irdi(cirdi[62:54]), .iri(ciri[62:54]), .irui(cirui[62:54]), 
	.iruui(ciruui[62:54]), .idi(cidi[62:54]), .iui(ciui[62:54]), .ildi(cildi[62:54]), .ili(cili[62:54]), 
	.ilui(cilui[62:54]), .iluui(ciluui[62:54]), .illdi(cilldi[62:54]), .illui(cillui[62:54]),
	.oluuo(), .oruuo(),
	.olluo(colluo[62:54]), .olldo(colldo[62:54]), .oluo(coluo[62:54]), .olo(colo[[62:54]), .oldo(coldo[62:54]), 
	.olddo(colddo[62:54]), .ouo(couo[62:54]), .odo(codo[62:54]), .oruo(coruo[62:54]), .oro(coro[62:54]), 
	.ordo(cordo[62:54]), .orddo(corddo[62:54]), .orruo(corruo[62:54]), .orrdo(corrdo[62:54]),
	.hlu(chluo[7]), .hru(chruo[7]), .hu(chuo[7]), .hd(chdo[7]),
	.hl(chlo[7]), .hr(chro[7]), .hld(chldo[7]), .hrd(chrdo[7]) );

// Row 6
squareUnit sq6 (.clk(clk), .xpos(xpos), .ypos(ROW6), .reset(reset), .done(done_sqs[6]), .hold(holds[6]),
	.irrdi(cirrdi[53:45]), .irrui(cirrui[53:45]), .irddi(cirddi[53:45]), .irdi(cirdi[53:45]), .iri(ciri[53:45]), 
	.irui(cirui[53:45]), .iruui(ciruui[53:45]), .idi(cidi[53:45]), .iui(ciui[53:45]), .ilddi(cilddi[53:45]), 
	.ildi(cildi[53:45]), .ili(cili[53:45]), .ilui(cilui[53:45]), .iluui(ciluui[53:45]), .illdi(cilldi[53:45]), 
	.illui(cillui[53:45]),
	.olluo(colluo[53:45]), .olldo(colldo[53:45]), .oluuo(coluuo[53:45]), .oluo(coluo[53:45]), .olo(colo[[53:45]), 
	.oldo(coldo[53:45]), .olddo(colddo[53:45]), .ouo(couo[53:45]), .odo(codo[53:45]), .oruuo(coruuo[53:45]),
	.oruo(coruo[53:45]), .oro(coro[53:45]), .ordo(cordo[53:45]), .orddo(corddo[53:45]), .orruo(corruo[53:45]), 
	.orrdo(corrdo[53:45]),
	.hlu(chluo[6]), .hru(chruo[6]), .hu(chuo[6]), .hd(chdo[6]),
	.hl(chlo[6]), .hr(chro[6]), .hld(chldo[6]), .hrd(chrdo[6]) );

// Row 5
squareUnit sq5 (.clk(clk), .xpos(xpos), .ypos(ROW5), .reset(reset), .done(done_sqs[5]), .hold(holds[5]),
	.irrdi(cirrdi[44:36]), .irrui(cirrui[44:36]), .irddi(cirddi[44:36]), .irdi(cirdi[44:36]), .iri(ciri[44:36]), 
	.irui(cirui[44:36]), .iruui(ciruui[44:36]), .idi(cidi[44:36]), .iui(ciui[44:36]), .ilddi(cilddi[44:36]), 
	.ildi(cildi[44:36]), .ili(cili[44:36]), .ilui(cilui[44:36]), .iluui(ciluui[44:36]), .illdi(cilldi[44:36]), 
	.illui(cillui[44:36]),
	.olluo(colluo[44:36]), .olldo(colldo[44:36]), .oluuo(coluuo[44:36]), .oluo(coluo[44:36]), .olo(colo[[44:36]), 
	.oldo(coldo[44:36]), .olddo(colddo[44:36]), .ouo(couo[44:36]), .odo(codo[44:36]), .oruuo(coruuo[44:36]),
	.oruo(coruo[44:36]), .oro(coro[44:36]), .ordo(cordo[44:36]), .orddo(corddo[44:36]), .orruo(corruo[44:36]), 
	.orrdo(corrdo[44:36]),
	.hlu(chluo[5]), .hru(chruo[5]), .hu(chuo[5]), .hd(chdo[5]),
	.hl(chlo[5]), .hr(chro[5]), .hld(chldo[5]), .hrd(chrdo[5]) );

// Row 4
squareUnit sq4 (.clk(clk), .xpos(xpos), .ypos(ROW4), .reset(reset), .done(done_sqs[4]), .hold(holds[4]),
	.irrdi(cirrdi[35:27]), .irrui(cirrui[35:27]), .irddi(cirddi[35:27]), .irdi(cirdi[35:27]), .iri(ciri[35:27]), 
	.irui(cirui[35:27]), .iruui(ciruui[35:27]), .idi(cidi[35:27]), .iui(ciui[35:27]), .ilddi(cilddi[35:27]), 
	.ildi(cildi[35:27]), .ili(cili[35:27]), .ilui(cilui[35:27]), .iluui(ciluui[35:27]), .illdi(cilldi[35:27]), 
	.illui(cillui[35:27]),
	.olluo(colluo[35:27]), .olldo(colldo[35:27]), .oluuo(coluuo[35:27]), .oluo(coluo[35:27]), .olo(colo[[35:27]), 
	.oldo(coldo[35:27]), .olddo(colddo[35:27]), .ouo(couo[35:27]), .odo(codo[35:27]), .oruuo(coruuo[35:27]),
	.oruo(coruo[35:27]), .oro(coro[35:27]), .ordo(cordo[35:27]), .orddo(corddo[35:27]), .orruo(corruo[35:27]), 
	.orrdo(corrdo[35:27]),
	.hlu(chluo[4]), .hru(chruo[4]), .hu(chuo[4]), .hd(chdo[4]),
	.hl(chlo[4]), .hr(chro[4]), .hld(chldo[4]), .hrd(chrdo[4]) );

// Row 3
squareUnit sq3 (.clk(clk), .xpos(xpos), .ypos(ROW3), .reset(reset), .done(done_sqs[3]), .hold(holds[3]),
	.irrdi(cirrdi[26:18]), .irrui(cirrui[26:18]), .irddi(cirddi[26:18]), .irdi(cirdi[26:18]), .iri(ciri[26:18]), 
	.irui(cirui[26:18]), .iruui(ciruui[26:18]), .idi(cidi[26:18]), .iui(ciui[26:18]), .ilddi(cilddi[26:18]), 
	.ildi(cildi[26:18]), .ili(cili[26:18]), .ilui(cilui[26:18]), .iluui(ciluui[26:18]), .illdi(cilldi[26:18]), 
	.illui(cillui[26:18]),
	.olluo(colluo[26:18]), .olldo(colldo[26:18]), .oluuo(coluuo[26:18]), .oluo(coluo[26:18]), .olo(colo[[26:18]), 
	.oldo(coldo[26:18]), .olddo(colddo[26:18]), .ouo(couo[26:18]), .odo(codo[26:18]), .oruuo(coruuo[26:18]),
	.oruo(coruo[26:18]), .oro(coro[26:18]), .ordo(cordo[26:18]), .orddo(corddo[26:18]), .orruo(corruo[26:18]), 
	.orrdo(corrdo[26:18]),
	.hlu(chluo[3]), .hru(chruo[3]), .hu(chuo[3]), .hd(chdo[3]),
	.hl(chlo[3]), .hr(chro[3]), .hld(chldo[3]), .hrd(chrdo[3]) );

// Row 2
squareUnit sq2 (.clk(clk), .xpos(xpos), .ypos(ROW2), .reset(reset), .done(done_sqs[2]), .hold(holds[2]),
	.iruui(PVOID), .iluui(PVOID), 
	.irrdi(cirrdi[17:9]), .irrui(cirrui[17:9]), .irddi(cirddi[17:9]), .irdi(cirdi[17:9]), .iri(ciri[17:9]), 
	.irui(cirui[17:9]), .idi(cidi[17:9]), .iui(ciui[17:9]), .ilddi(cilddi[17:9]), 
	.ildi(cildi[17:9]), .ili(cili[17:9]), .ilui(cilui[17:9]), .illdi(cilldi[17:9]), .illui(cillui[17:9]),
	.olddo(), .orddo(), 
	.olluo(colluo[17:9]), .olldo(colldo[17:9]), .oluuo(coluuo[17:9]), .oluo(coluo[17:9]), .olo(colo[[17:9]), 
	.oldo(coldo[17:9]), .ouo(couo[17:9]), .odo(codo[17:9]), .oruuo(coruuo[17:9]),
	.oruo(coruo[17:9]), .oro(coro[17:9]), .ordo(cordo[17:9]), .orruo(corruo[17:9]), .orrdo(corrdo[17:9]),
	.hlu(chluo[2]), .hru(chruo[2]), .hu(chuo[2]), .hd(chdo[2]),
	.hl(chlo[2]), .hr(chro[2]), .hld(chldo[2]), .hrd(chrdo[2]) );

// Row 1
squareUnit sq1 (.clk(clk), .xpos(xpos), .ypos(ROW1), .reset(reset), .done(done_sqs[1]), .hold(holds[1]),
	.irrui(PVOID), .irui(PVOID), .iruui(PVOID), .iui(PVOID), .ilui(PVOID), .iluui(PVOID), .illui(PVOID),
	.irrdi(cirrdi[8:0]), .irddi(cirddi[8:0]), .irdi(cirdi[8:0]), .iri(ciri[8:0]), .idi(cidi[8:0]), 
	.ilddi(cilddi[8:0]), .ildi(cildi[8:0]), .ili(cili[8:0]), .illdi(cilldi[8:0]), 
	.olldo(), .oldo(), .olddo(), .odo(), .ordo(), .orddo(), .orrdo(), 
	.olluo(colluo[8:0]), .oluuo(coluuo[8:0]), .oluo(coluo[8:0]), .olo(colo[[8:0]), .ouo(couo[8:0]), 
	.oruuo(coruuo[8:0]), .oruo(coruo[8:0]), .oro(coro[8:0]), .orruo(corruo[8:0]),
	.hld(), .hrd(), .hu(chuo[1]), .hd(),
	.hl(chlo[1]), .hr(chro[1]), .hlu(chluo[1]), .hru(chruo[1]) );

endmodule