`timescale 1ps / 1ps

module lmg_tb();

parameter NCIO = 650; // number of cycles from input to output

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
	
	// board state = empty
	bstate = 256'd0;
	
	// wait for one cycle and set reset to 0
	@(posedge clk) #10;
	reset = 1'b0;
	
	// wait for output
	repeat (NCIO) @(posedge clk); #10 
	
	// stream output
	rden = 1'b1; #10
	while (!fifoEmpty) begin
		@(posedge clk) #10;
	end
	
	// end simulation
	$stop; // For ModelSim
end

endmodule