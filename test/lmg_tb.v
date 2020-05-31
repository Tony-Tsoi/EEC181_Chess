`timescale 1ps / 1ps

module lmg_tb();

// IO of module
reg clk, reset, rden, lcas_flag, rcas_flag;
reg [255:0] bstate; // board state
reg [1:8] enp_flags; // en passant flags, high when opponent pawn just moved two squares front

wire done, fifoEmpty; // done signal
wire [159:0] fifoOut;

// for clarity
wire [18:0] fifoMv1 = fifoOut[151:133];
wire [18:0] fifoMv2 = fifoOut[132:114];
wire [18:0] fifoMv3 = fifoOut[113:95];
wire [18:0] fifoMv4 = fifoOut[94:76];
wire [18:0] fifoMv5 = fifoOut[75:57];
wire [18:0] fifoMv6 = fifoOut[56:38];
wire [18:0] fifoMv7 = fifoOut[37:19];
wire [18:0] fifoMv8 = fifoOut[18:0];

LMG DUT (.clk(clk), .reset(reset), .bstate(bstate), .done(done), .fifoOut(fifoOut), 
	.rden(rden), .fifoEmpty(fifoEmpty), .lcas_flag(lcas_flag), .rcas_flag(rcas_flag), 
	.enp_flags(enp_flags) );

// to read from file
integer inFile;

// count number of moves
integer tMoves;
	
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
	rden = 1'b0;
	
	// disable flags
	lcas_flag = 1'b0;
	rcas_flag = 1'b0;
	enp_flags = 8'd0;
	
	// read board state from file
	inFile = $fopen("./bstate.txt", "r");
	$fscanf(inFile, "%b", bstate);
	$fclose(inFile);
	
	// set number of moves to zero
	tMoves = 0;
	
	// wait for one cycle and set reset to 0
	@(posedge clk) #10;
	reset = 1'b0;
	
	// wait for output
	while (!done) begin
		@(posedge clk) #10;
	end
	
	// stream output
	rden = 1'b1; #10
	while (!fifoEmpty) begin
		@(posedge clk) #10;
		
		// display valid moves to console
		if (~fifoMv1[18]) begin
			$write("From %o to %o\n", fifoMv1[11:6], fifoMv1[5:0]);
			tMoves = tMoves + 1;
		end
		if (~fifoMv2[18]) begin
			$write("From %o to %o\n", fifoMv2[11:6], fifoMv2[5:0]);
			tMoves = tMoves + 1;
		end
		if (~fifoMv3[18]) begin
			$write("From %o to %o\n", fifoMv3[11:6], fifoMv3[5:0]);
			tMoves = tMoves + 1;
		end
		if (~fifoMv4[18]) begin
			$write("From %o to %o\n", fifoMv4[11:6], fifoMv4[5:0]);
			tMoves = tMoves + 1;
		end
		if (~fifoMv5[18]) begin
			$write("From %o to %o\n", fifoMv5[11:6], fifoMv5[5:0]);
			tMoves = tMoves + 1;
		end
		if (~fifoMv6[18]) begin
			$write("From %o to %o\n", fifoMv6[11:6], fifoMv6[5:0]);
			tMoves = tMoves + 1;
		end
		if (~fifoMv7[18]) begin
			$write("From %o to %o\n", fifoMv7[11:6], fifoMv7[5:0]);
			tMoves = tMoves + 1;
		end
		if (~fifoMv8[18]) begin
			$write("From %o to %o\n", fifoMv8[11:6], fifoMv8[5:0]);
			tMoves = tMoves + 1;
		end
	end
	
	// end simulation
	$write("Total number of moves = %d\n", tMoves);
	$stop; // For ModelSim
end

endmodule