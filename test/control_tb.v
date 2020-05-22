`timescale 1 ps / 1 ps

module control_tb;

// Parameters
parameter DATA_WIDTH = 32; // Using localparam generates errors in qsys, just use parameter
parameter ADDR_WIDTH = 15; // There are no "unused" addresses. Each slave address has a spot in RAM.

// clock interface
reg clk;
reg reset; // Not used

// slave interface
reg [ADDR_WIDTH-1:0] slave_address;
reg slave_read;
reg slave_write;
wire [DATA_WIDTH-1:0] slave_readdata;
reg [DATA_WIDTH-1:0] slave_writedata;
reg [(DATA_WIDTH/8)-1:0] slave_byteenable; //Not currently used

reg readdata;

control control_inst1(
	// signals to connect to an Avalon clock source interface
	.clk (clk),
	.reset (reset),

	// signals to connect to an Avalon-MM slave interface
	.slave_address (slave_address),
	.slave_read (slave_read),
	.slave_write (slave_write),
	.slave_readdata (slave_readdata),
	.slave_writedata (slave_writedata),
	.slave_byteenable (slave_byteenable)
);

initial begin
	clk = 1'b0;
	reset = 1'b0;
	slave_address = 15'h0000;
	slave_read = 1'b0;
	slave_write = 1'b0;
	slave_writedata = 32'h0000_0000;
	slave_byteenable = 4'hF;
	
	clk = 1'b1;
	#100;
	clk = 1'b0;
	#100;

	// To make things easy, assign all 4 values whenever you want to read/write something.
	// Normally, slave_read should only be high for 3 cycles, and slave_write should be high for 1 cycle,
	// For simulation purposes, just do 4 cycles minimum between read/writes.
	slave_address = 15'd0;
	slave_read = 1'b0;
	slave_write = 1'b1;
	slave_writedata = 32'h0000_0001; // Edit this
	
	repeat(4) begin
		clk = 1'b1;
		#100;
		clk = 1'b0;
		#100;
	end

	slave_address = 15'd0; // These 4 are just place holder values, edit these to read/write something useful.
	slave_read = 1'b1;
	slave_write = 1'b0;
	slave_writedata = 32'h0000_0000; // Edit this

	
	repeat(1000) begin
		clk = 1'b1;
		#100;
		clk = 1'b0;
		#100;
	end
	


end

endmodule