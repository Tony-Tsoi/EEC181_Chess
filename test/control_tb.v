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

wire lmgdone;
wire [255:0] boardState;
wire [151:0] lmgFifoOut;
wire lmgReset;

control_TestOnly control_inst1(
	// signals to connect to an Avalon clock source interface
	.clk (clk),
	.reset (reset),

	// signals to connect to an Avalon-MM slave interface
	.slave_address (slave_address),
	.slave_read (slave_read),
	.slave_write (slave_write),
	.slave_readdata (slave_readdata),
	.slave_writedata (slave_writedata),
	.slave_byteenable (slave_byteenable),
	.lmgdone(lmgdone),
	.boardState(boardState),
	.lmgReset(lmgReset),
	.lmgFifoOut(lmgFifoOut)
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
	
	//====================== WRITING BOARD STATE =====================
	slave_address = 15'd2;
	slave_read = 1'b1;
	slave_write = 1'b1;
	slave_writedata = 32'h2346_5432; 
	
	repeat(4) begin
		clk = 1'b1;
		#100;
		clk = 1'b0;
		#100;
	end
	
	slave_address = 15'd3;
	slave_read = 1'b1;
	slave_write = 1'b1;
	slave_writedata = 32'h0000_0000; 
	
	repeat(4) begin
		clk = 1'b1;
		#100;
		clk = 1'b0;
		#100;
	end
	
	slave_address = 15'd4;
	slave_read = 1'b1;
	slave_write = 1'b1;
	slave_writedata = 32'h0000_0000; 
	
	repeat(4) begin
		clk = 1'b1;
		#100;
		clk = 1'b0;
		#100;
	end
	
	slave_address = 15'd5;
	slave_read = 1'b1;
	slave_write = 1'b1;
	slave_writedata = 32'h0000_0000; 
	
	repeat(4) begin
		clk = 1'b1;
		#100;
		clk = 1'b0;
		#100;
	end
	
	slave_address = 15'd6;
	slave_read = 1'b1;
	slave_write = 1'b1;
	slave_writedata = 32'h0000_0000; 
	
	repeat(4) begin
		clk = 1'b1;
		#100;
		clk = 1'b0;
		#100;
	end
	
	slave_address = 15'd7;
	slave_read = 1'b1;
	slave_write = 1'b1;
	slave_writedata = 32'h0000_0000; 
	
	repeat(4) begin
		clk = 1'b1;
		#100;
		clk = 1'b0;
		#100;
	end
	
	slave_address = 15'd8;
	slave_read = 1'b1;
	slave_write = 1'b1;
	slave_writedata = 32'h0000_0000; 
	
	repeat(4) begin
		clk = 1'b1;
		#100;
		clk = 1'b0;
		#100;
	end
	
	slave_address = 15'd9;
	slave_read = 1'b1;
	slave_write = 1'b1;
	slave_writedata = 32'h0000_0000; 
	
	repeat(4) begin
		clk = 1'b1;
		#100;
		clk = 1'b0;
		#100;
	end
	//====================== END WRITING BOARD STATE =====================
	
	slave_address = 15'd0;
	slave_read = 1'b1;
	slave_write = 1'b1;
	slave_writedata = 32'h0000_0000; 
	
	repeat(4) begin
		clk = 1'b1;
		#100;
		clk = 1'b0;
		#100;
	end
	
	slave_address = 15'd0;
	slave_read = 1'b1;
	slave_write = 1'b1;
	slave_writedata = 32'h0000_0001; 
	
	repeat(4) begin
		clk = 1'b1;
		#100;
		clk = 1'b0;
		#100;
	end
	
	repeat(10000) begin
		slave_address = 15'd0; // These 4 are just place holder values, edit these to read/write something useful.
		slave_read = 1'b1;
		slave_write = 1'b0;
		slave_writedata = 32'h0000_0000; // Edit this

	
		clk = 1'b1;
		#100;
		clk = 1'b0;
		#100;
	end
	
	
	


end

endmodule