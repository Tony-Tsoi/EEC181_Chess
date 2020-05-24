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

wire lmgDone;
wire [255:0] boardState;
wire [151:0] lmgFifoOut;
wire lmgReset;

reg [10:0] i;

wire fifoEmpty;
wire [7:0] writeCount;


control_TestOnly control_TestOnly_inst1(
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
	.lmgDone(lmgDone),
	.boardState(boardState),
	.lmgReset(lmgReset),
	.lmgFifoOut(lmgFifoOut),
	.fifoEmpty(fifoEmpty),
	.writeCount(writeCount)
);


/*
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
*/



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
	slave_writedata = 32'h0000_0001;  // Start = 1
	
	repeat(4) begin
		clk = 1'b1;
		#100;
		clk = 1'b0;
		#100;
	end
	
	repeat(2000) begin
		slave_address = 15'd0; 
		slave_read = 1'b1;
		slave_write = 1'b0;
		slave_writedata = 32'h0000_0000; // Edit this

	
		clk = 1'b1;
		#100;
		clk = 1'b0;
		#100;
	end
	
	//================ CHECK MEMORY VALUES ================
    for (i = 0; i < 50; i = i + 1) begin
      	slave_address = 15'd16 + i;
		slave_read = 1'b1;
		slave_write = 1'b0;
		slave_writedata = 32'h0000_0000; 
		
		repeat(4) begin
			clk = 1'b1;
			#100;
			clk = 1'b0;
			#100;
		end
    end
	
	for (i = 0; i < 50; i = i + 1) begin
      	slave_address = 15'd16 + i;
		slave_read = 1'b1;
		slave_write = 1'b0;
		slave_writedata = 32'h0000_0000; 
		
		repeat(4) begin
			clk = 1'b1;
			#100;
			clk = 1'b0;
			#100;
		end
    end
	
	
	//================ CHECKING CONTROL =========================
	slave_address = 15'd0;
	slave_read = 1'b1;
	slave_write = 1'b0;
	slave_writedata = 32'h0000_0000; 

	repeat(10) begin
	clk = 1'b1;
	#100;
	clk = 1'b0;
	#100;
	end
	


end

endmodule