module Test_Module (
// signals to connect to an Avalon clock source interface
clk,
reset,

// signals to connect to an Avalon-MM slave interface
slave_address,
slave_read,
slave_write,
slave_readdata,
slave_writedata,
slave_byteenable
);

// Parameters
parameter DATA_WIDTH = 32; // Using localparam generates errors in qsys, just use parameter
parameter ADDR_WIDTH = 15; // There are no "unused" addresses. Each slave address has a spot in RAM.

// clock interface
input clk;
input reset;

// slave interface
input [ADDR_WIDTH-1:0] slave_address;
input slave_read;
input slave_write;
output reg [DATA_WIDTH-1:0] slave_readdata;
input [DATA_WIDTH-1:0] slave_writedata;
input [(DATA_WIDTH/8)-1:0] slave_byteenable;


//==================================
//			WIRES / REGS
//==================================
wire [DATA_WIDTH-1:0] ram_out;

reg ram_wren;
reg ram_wren_p1; // currently not used

reg [ADDR_WIDTH-2:0] rd_addr;
reg [ADDR_WIDTH-2:0] wr_addr;

reg [ADDR_WIDTH-2:0] rd_addr_p1;
reg [ADDR_WIDTH-2:0] wr_addr_p1;

// Entry 0 = 0x0 in RAM, 1 = 0x1, etc.
// 1024 bits for control/interface data.
// I always update control or interface_data[0] at the same time so they are consistent.
// control bits at 0x0: {other[28:0], reset, done, start}
reg [31:0] interface_data [0:31];
reg [31:0] interface_data_p1 [0:31];
reg [31:0] control; // control = interface_data[0]
reg [31:0] control_p1;
	
reg [4:0] counter; // For incrementing through test data
reg [4:0] counter_p1;

//===================================
//		Module Instantiations
//==================================

// 32 bits wide, 32768 entries
// Entry 0 is 0x0 for slave address, 1 is 0x1,  etc.
// 0x0 - 0x1 are the control bits (only 0x0 is used currently)
// 0x2 - 0x9 are for SW to HW data
// 0x10  HW to SW data
One_Mib_RAM	RAM_A(
   .clock		(clk),
   .data		(slave_writedata),
   .rdaddress	(rd_addr),
   .wraddress	(wr_addr),
   .wren		(ram_wren),
   .q			(ram_out)
);

//===================================
//				Main
//===================================

always @(*) // @(slave_address or matrixA_dout or matrixB_dout or matrixResult_dout)
begin
//================ DEFAULTS =======================
	interface_data[0] = interface_data_p1[0]; 
	interface_data[1] = interface_data_p1[1]; 
	interface_data[2] = interface_data_p1[2]; 
	interface_data[3] = interface_data_p1[3]; 
	interface_data[4] = interface_data_p1[4]; 
	interface_data[5] = interface_data_p1[5]; 
	interface_data[6] = interface_data_p1[6]; 
	interface_data[7] = interface_data_p1[7]; 
	interface_data[8] = interface_data_p1[8]; 
	interface_data[9] = interface_data_p1[9]; 
	interface_data[10] = interface_data_p1[10]; 
	interface_data[11] = interface_data_p1[11]; 
	interface_data[12] = interface_data_p1[12]; 
	interface_data[13] = interface_data_p1[13]; 
	interface_data[14] = interface_data_p1[14]; 
	interface_data[15] = interface_data_p1[15]; 
	interface_data[16] = interface_data_p1[16]; 
	interface_data[17] = interface_data_p1[17]; 
	interface_data[18] = interface_data_p1[18]; 
	interface_data[19] = interface_data_p1[19]; 
	interface_data[20] = interface_data_p1[20]; 
	interface_data[21] = interface_data_p1[21]; 
	interface_data[22] = interface_data_p1[22]; 
	interface_data[23] = interface_data_p1[23]; 
	interface_data[24] = interface_data_p1[24]; 
	interface_data[25] = interface_data_p1[25]; 
	interface_data[26] = interface_data_p1[26]; 
	interface_data[27] = interface_data_p1[27]; 
	interface_data[28] = interface_data_p1[28]; 
	interface_data[29] = interface_data_p1[29]; 
	interface_data[30] = interface_data_p1[30]; 
	interface_data[31] = interface_data_p1[31];
	
	control = interface_data[0];
	rd_addr = rd_addr_p1;
	wr_addr = wr_addr_p1;
	ram_wren = 1'b0;
	counter = counter_p1;
	slave_readdata = 0;

//========================== READ/WRITE ==========================================	
	// NOTE: There are 1024 wasted bits in the RAM because these addresses are being used
	// for control/interface regs. This method saves address space. Our RAM needs 15 bits 
	// to address every entry. It's hard to create a small number of "unused" slave_addresses 
	// like we've seen before so this is the best way to do it. 
	// If we want to we can change it so when we write to the interface_data we also write
	// to its respective spot in RAM. Just get rid of the wren = 0 line below.
	if (slave_write == 1'b1) 
	begin
		wr_addr = slave_address[ADDR_WIDTH-1:0];
		ram_wren = 1'b1;
		
		// If writing to control/interface data.
		// The 5 LSBs gives us 1024 bits that are readily available after the write.
		if (slave_address[ADDR_WIDTH-1:5] == 0) 
		begin
			ram_wren = 1'b0;
			interface_data[slave_address[4:0]] = slave_writedata;
			control = interface_data[0];
		end
	end
	
	if (slave_read == 1'b1) 
	begin
		rd_addr = slave_address[ADDR_WIDTH-1:0];
		slave_readdata = ram_out;
		
		if (slave_address[ADDR_WIDTH-1:5] == 0) 
		begin
			slave_readdata = interface_data[slave_address[4:0]];
		end
	end
	
//=================== MAIN =======================
	if (control[0] == 1'b0) // if start == 0		
	begin 
		control[1] = 1'b0; // Done = 0
		interface_data[0] = control;
	end
	
	if (control[0] == 1'b1) // if start == 1
	begin 
		// Hardcoded test data.
		// interface_data[10] contains HW to SW data.
		case(counter) 
			0: interface_data[10] = {{3'd1,3'd0}, {3'd2, 3'd0}}; // Move pawns forward 1
			1: interface_data[10] = {{3'd1,3'd1}, {3'd2, 3'd1}}; 
			2: interface_data[10] = {{3'd1,3'd2}, {3'd2, 3'd2}}; 
			3: interface_data[10] = {{3'd1,3'd3}, {3'd2, 3'd3}};
			4: interface_data[10] = {{3'd1,3'd4}, {3'd2, 3'd4}};
			5: interface_data[10] = {{3'd1,3'd5}, {3'd2, 3'd5}};
			6: interface_data[10] = {{3'd1,3'd6}, {3'd2, 3'd6}};
			7: interface_data[10] = {{3'd1,3'd7}, {3'd2, 3'd7}};
			
			8: interface_data[10] = {{3'd0,3'd0}, {3'd1, 3'd0}}; // Move rooks forward 1
			9: interface_data[10] = {{3'd0,3'd7}, {3'd1, 3'd7}};
			default: interface_data[10] = 0;
		endcase 
		control[1] = 1'b1; // Done = 1
		interface_data[0] = control;
	end
	
	if ((!control[0]) && control_p1[0]) // If start changed from 1 to 0
	begin
		counter = counter_p1 + 1; // This is for incrementing through the test data 
		if (counter > 9) counter = 0;
	end 
	
//======================== RESET ======================================
	if (control[2] == 1) // if reset == 1 (when reset is high the other control bits should be low)
	begin
		// Note: I only reset the necessary regs needed for functionality
		// No reason to reset RAM or interface_data really. Just be careful to read the correct data.
		counter = 0;
	end
end


always @ (posedge clk) begin
	rd_addr_p1 <= rd_addr;
	wr_addr_p1 <= wr_addr;
	counter_p1 <= counter;
	ram_wren_p1 <= ram_wren; // currently not used
	control_p1 <= interface_data[0];
	
	interface_data_p1[0] <= interface_data[0]; 
	interface_data_p1[1] <= interface_data[1]; 
	interface_data_p1[2] <= interface_data[2]; 
	interface_data_p1[3] <= interface_data[3]; 
	interface_data_p1[4] <= interface_data[4]; 
	interface_data_p1[5] <= interface_data[5]; 
	interface_data_p1[6] <= interface_data[6]; 
	interface_data_p1[7] <= interface_data[7]; 
	interface_data_p1[8] <= interface_data[8]; 
	interface_data_p1[9] <= interface_data[9]; 
	interface_data_p1[10] <= interface_data[10]; 
	interface_data_p1[11] <= interface_data[11]; 
	interface_data_p1[12] <= interface_data[12]; 
	interface_data_p1[13] <= interface_data[13]; 
	interface_data_p1[14] <= interface_data[14]; 
	interface_data_p1[15] <= interface_data[15]; 
	interface_data_p1[16] <= interface_data[16]; 
	interface_data_p1[17] <= interface_data[17]; 
	interface_data_p1[18] <= interface_data[18]; 
	interface_data_p1[19] <= interface_data[19]; 
	interface_data_p1[20] <= interface_data[20]; 
	interface_data_p1[21] <= interface_data[21]; 
	interface_data_p1[22] <= interface_data[22]; 
	interface_data_p1[23] <= interface_data[23]; 
	interface_data_p1[24] <= interface_data[24]; 
	interface_data_p1[25] <= interface_data[25]; 
	interface_data_p1[26] <= interface_data[26]; 
	interface_data_p1[27] <= interface_data[27]; 
	interface_data_p1[28] <= interface_data[28]; 
	interface_data_p1[29] <= interface_data[29]; 
	interface_data_p1[30] <= interface_data[30]; 
	interface_data_p1[31] <= interface_data[31]; 
	
end // always @ (posedge clk)
   
endmodule 




   
	      
	     
	     
   
   
   
		       

   
