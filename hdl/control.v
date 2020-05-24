module control (
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

// should contain a block RAM for the move list/tree
// 1. wait for Avalon bus to feed in current board state
// 2. feeds move(s) into LMG, waits, get moves from LMG fifo and write into block RAM
// 3. for multiple depth: repeat step 2 and write into do/undo stack, until certain depth reached
// 4. wait for SW to retrieve move list/tree from block RAM

// TODO: make hardware that creates a boardstate that makes the move 
	// (in consideration of castling, which is 2 moves in 1)
// TODO: look into burst read from master
// TODO: for multiple depth: 
	// 1. modify state machine to feed the move list back
	// 2. add do/undo stack
	// 3. add tags (ptr, start, end) into block RAM (if applicable)
	
// Proposed king in-check checking methods
	// 1. Utilizing LMG to check - would loop the list back into LMG and let LMG return a valid bit attached to the tag
		// and prune by software
	// 2. Search for an extra depth and let software prune it (since our eval HW doesn't check that)

// Parameters
parameter DATA_WIDTH = 32; // Using localparam generates errors in qsys, just use parameter
parameter ADDR_WIDTH = 15; // There are no "unused" addresses. Each slave address has a spot in RAM.

// clock interface
input clk;
input reset; // Not currently used

// slave interface
input [ADDR_WIDTH-1:0] slave_address;
input slave_read;
input slave_write;
output reg [DATA_WIDTH-1:0] slave_readdata;
input [DATA_WIDTH-1:0] slave_writedata;
input [(DATA_WIDTH/8)-1:0] slave_byteenable; //Not currently used

//==================================
//          WIRES / REGS
//==================================
wire [DATA_WIDTH-1:0] ram_out;
reg [DATA_WIDTH-1:0] ram_in;

reg ram_wren;
reg ram_wren_p1; // currently not used

reg [ADDR_WIDTH-1:0] rd_addr;
reg [ADDR_WIDTH-1:0] wr_addr;

reg [ADDR_WIDTH-1:0] rd_addr_p1;
reg [ADDR_WIDTH-1:0] wr_addr_p1;

// Entry 0 = 0x0 in RAM, 1 = 0x1, etc.
// 512 bits for control/interface data.
// I always update control or interface_data[0] at the same time so they are consistent.
// control bits at 0x0: {other[28:0], reset, done, start}
reg [31:0] interface_data [0:15];
reg [31:0] interface_data_p1 [0:15];
reg [31:0] control; // control = interface_data[0]
reg [31:0] control_p1;
	
//reg [4:0] counter; // For incrementing through test data
//reg [4:0] counter_p1;

//lmg interface
reg [255:0] boardState;
reg lmgReset;
reg lmgReadEnable;
reg lmgReadEnable_c;
wire [151:0] lmgFifoOut;
wire lmgDone;
reg lmgDone_p1;
reg lmgResetState, lmgResetState_c;

reg preRead, preRead_c;
reg readWord1;
reg readWord2;
reg readWord3;
reg readWord4;
reg readWord5;
reg readWord6;
reg readWord7;
reg readWord8;
reg readWord1_c;
reg readWord2_c;
reg readWord3_c;
reg readWord4_c;
reg readWord5_c;
reg readWord6_c;
reg readWord7_c;
reg readWord8_c;

reg writeFromLmgDone;
reg writeFromLmgDone_c;

reg [7:0] writeCount; //8 bit size is completely arbitrary
reg [7:0] writeCount_c;

reg allMovesDone;
reg allMovesDone_c;
reg preDone;
reg preDone_c;

wire fifoEmpty;


//===================================
//		Module Instantiations
//==================================

// 32 bits wide, 32768 entries
// Entry 0 is 0x0 for slave address, 1 is 0x1,  etc.
// 0x0 - 0x1 are the control bits (only 0x0 is used currently)
// 0x2 - 0x9 are for SW to HW data
// 0x10 - 0x15 are unused
// 0x16 - 0x32767 are HW to SW data
One_Mib_RAM	RAM_A(
   .clock		(clk),
   .data		(ram_in),
   .rdaddress	(rd_addr),
   .wraddress	(wr_addr),
   .wren		(ram_wren),
   .q			(ram_out)
);


lmg_dummy LMG(
	.clk(clk),
	.reset(lmgReset),
	.bstate(boardState),
	.done(lmgDone),
	.fifoOut(lmgFifoOut),
	.rden(lmgReadEnable),
	.fifoEmpty(fifoEmpty),
	.lcas_flag(1'b0), // change these flags to generate in HW
	.rcas_flag(1'b0),
	.enp_flags(8'd0)
);

//===================================
//				Main
//===================================

always @(*) 
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
	
	control = interface_data[0];
	rd_addr = rd_addr_p1;
	wr_addr = wr_addr_p1;
	ram_wren = ram_wren_p1;
	//counter = counter_p1;
	slave_readdata = 0;
	//ram_in = slave_writedata; I don't think we need this default, but maybe we do
	lmgReset = 1'b0;
	lmgReadEnable_c = 1'b0;
	writeFromLmgDone_c = 1'b0;
	allMovesDone_c = 1'b0;

	boardState[255:224] = interface_data_p1[9]; //The order of bits here could be off
	boardState[223:192] = interface_data_p1[8];
	boardState[191:160] = interface_data_p1[7];
	boardState[159:128] = interface_data_p1[6];
	boardState[127:96] = interface_data_p1[5];
	boardState[95:64] = interface_data_p1[4];
	boardState[63:32] = interface_data_p1[3];
	boardState[31:0] = interface_data_p1[2];


//========================== READ/WRITE ==========================================	
	// NOTE: There are 512 wasted bits in the RAM because these addresses are being used
	// for control/interface regs. This method saves address space. Our RAM needs 15 bits 
	// to address every entry. It's hard to create a small number of "unused" slave_addresses 
	// like we've seen before so this is the best way to do it. 
	// If we want to, we can change it so when we write to the interface_data we also write
	// to its respective spot in RAM. Just get rid of the wren = 0 line below.
	if (slave_write == 1'b1) 
	begin
		ram_in = slave_writedata;
		wr_addr = slave_address;
		ram_wren = 1'b1;
		
		// If writing to control/interface data.
		// The 4 LSBs gives us 512 bits that are readily available after the write.
		if (slave_address[ADDR_WIDTH-1:4] == 0) 
		begin
			ram_wren = 1'b0;
			interface_data[slave_address[3:0]] = slave_writedata;
			control = interface_data[0];
		end
	end
	
	if (slave_read == 1'b1) 
	begin
		rd_addr = slave_address;
		slave_readdata = ram_out;
		
		if (slave_address[ADDR_WIDTH-1:4] == 0) 
		begin
			slave_readdata = interface_data[slave_address[3:0]];
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
		//Give LMG board state and start(reset?) signal
		if (control_p1[0] == 1'b0) begin
			lmgReset = 1'b1; //toggle reset if start was just turned on
			readWord1_c = 1'b0;
			readWord2_c = 1'b0;
			readWord3_c = 1'b0;
			readWord4_c = 1'b0;
			readWord5_c = 1'b0;
			readWord6_c = 1'b0;
			readWord7_c = 1'b0;
			readWord8_c = 1'b0;
			writeCount_c = 8'd0;
			preDone_c = 1'b0;
			writeFromLmgDone_c = 1'b0;
			allMovesDone_c = 1'b0;
			lmgReadEnable_c = 1'b0;
			lmgResetState_c = 1'b1;
		end
		
		if (lmgResetState == 1'b1) begin
			lmgReset = 1'b1;
			lmgResetState_c = 1'b0;
		end
		
		//Wait for lmg done signal, then read from lmg fifo and write into block ram
		if (lmgDone == 1'b1) begin
			
			if (lmgDone_p1 == 1'b0 || writeFromLmgDone == 1'b1) begin //start when lmgDone first gets turned on or when the last word is done being processed
				 //trying to toggle the lmg read on/off here because i'm guessing the lmg gives me a new set of moves everytime I press read
				lmgReadEnable_c = 1'b1;
				preRead_c = 1'b1;
			end
			
			if (preRead == 1'b1) begin
				readWord1_c = 1'b1;
				lmgReadEnable_c = 1'b0;
				preRead_c = 1'b0;
				ram_wren = 1'b1;
			end
			
			if (readWord1 == 1'b1) begin
				if (lmgFifoOut[18] == 1'b0) begin //write the first word if valid, otherwise look at the second word
					ram_in = lmgFifoOut[17:0]; //This isn't exact yet
					ram_wren = 1'b1;
					wr_addr = 15'd17 + writeCount;
					writeCount_c = writeCount + 1;
					readWord1_c = 1'b0;
					readWord2_c = 1'b1;
				end else begin
						ram_wren = 1'b0;
						writeCount_c = writeCount;
						readWord1_c = 1'b0;
						readWord2_c = 1'b1; //This might need to be pipelined but I think it saves a ton of time if it works
					end
			end
			
			if (readWord2 == 1'b1) begin
				if (lmgFifoOut[37] == 1'b0) begin  //write the second word if valid, otherwise look at the third word
					ram_in = lmgFifoOut[36:19]; //This isn't exact yet
					ram_wren = 1'b1;
					wr_addr = 15'd17 + writeCount;
					writeCount_c = writeCount + 1;
					readWord2_c = 1'b0;
					readWord3_c = 1'b1;
				end else begin
						ram_wren = 1'b0;
						writeCount_c = writeCount;
						readWord2_c = 1'b0;
						readWord3_c = 1'b1; //This might need to be pipelined
					end
			end
			
			if (readWord3 == 1'b1) begin
				if (lmgFifoOut[56] == 1'b0) begin  //write the third word if valid, otherwise look at the fourth word
					ram_in = lmgFifoOut[55:38]; //This isn't exact yet
					ram_wren = 1'b1;
					wr_addr = 15'd17 + writeCount;
					writeCount_c = writeCount + 1;
					readWord3_c = 1'b0;
					readWord4_c = 1'b1;
				end else begin
						ram_wren = 1'b0;
						writeCount_c = writeCount;
						readWord3_c = 1'b0;
						readWord4_c = 1'b1; //This might need to be pipelined
					end
			end
			
			if (readWord4 == 1'b1) begin
				if (lmgFifoOut[75] == 1'b0) begin  //write the fourth word if valid, otherwise look at the fifth word
					ram_in = lmgFifoOut[74:57]; //This isn't exact yet
					ram_wren = 1'b1;
					wr_addr = 15'd17 + writeCount;
					writeCount_c = writeCount + 1;
					readWord4_c = 1'b0;
					readWord5_c = 1'b1;
				end else begin
						ram_wren = 1'b0;
						writeCount_c = writeCount;
						readWord4_c = 1'b0;
						readWord5_c = 1'b1; //This might need to be pipelined
					end
			end
			
			if (readWord5 == 1'b1) begin
				if (lmgFifoOut[94] == 1'b0) begin  //write the fifth word if valid, otherwise look at the sixth word
					ram_in = lmgFifoOut[93:76]; //This isn't exact yet
					ram_wren = 1'b1;
					wr_addr = 15'd17 + writeCount;
					writeCount_c = writeCount + 1;
					readWord5_c = 1'b0;
					readWord6_c = 1'b1;
				end else begin
						ram_wren = 1'b0;
						writeCount_c = writeCount;
						readWord5_c = 1'b0;
						readWord6_c = 1'b1; //This might need to be pipelined
					end
			end
			
			if (readWord6 == 1'b1) begin
				if (lmgFifoOut[113] == 1'b0) begin  //write the sixth word if valid, otherwise look at the seventh word
					ram_in = lmgFifoOut[112:95]; //This isn't exact yet
					ram_wren = 1'b1;
					wr_addr = 15'd17 + writeCount;
					writeCount_c = writeCount + 1;
					readWord6_c = 1'b0;
					readWord7_c = 1'b1;
				end else begin
						ram_wren = 1'b0;
						writeCount_c = writeCount;
						readWord6_c = 1'b0;
						readWord7_c = 1'b1; //This might need to be pipelined
					end
			end
			
			if (readWord7 == 1'b1) begin
				if (lmgFifoOut[132] == 1'b0) begin  //write the seventh word if valid, otherwise look at the last word
					ram_in = lmgFifoOut[131:114]; //This isn't exact yet
					ram_wren = 1'b1;
					wr_addr = 15'd17 + writeCount;
					writeCount_c = writeCount + 1;
					readWord7_c = 1'b0;
					readWord8_c = 1'b1;
				end else begin
						ram_wren = 1'b0;
						writeCount_c = writeCount;
						readWord7_c = 1'b0;
						readWord8_c = 1'b1; //This might need to be pipelined
					end
			end
			
			if (readWord8 == 1'b1) begin
				readWord8_c = 1'b0;
				if (lmgFifoOut[151] == 1'b0) begin  //write the last word if valid, otherwise 
					ram_in = lmgFifoOut[150:133]; //This isn't exact yet
					ram_wren = 1'b1;
					wr_addr = 15'd17 + writeCount;
					writeCount_c = writeCount + 1;
					writeFromLmgDone_c = 1'b1;
				end else begin 
						ram_wren = 1'b0;
						writeCount_c = writeCount;
						writeFromLmgDone_c = 1'b1;

					end
					
				//if the entire word consists of invalid moves, end the process
				if(fifoEmpty == 1'b1) begin
					writeFromLmgDone_c = 1'b0;
					allMovesDone_c = 1'b1;
				end 
			end
			
			//Write information to 0x16 for software and set done = 1
			if(allMovesDone == 1'b1) begin
				ram_in = writeCount; //might need to format this
				ram_wren = 1'b1;
				wr_addr = 15'd16;
				preDone_c = 1'b1; //the name is dumb I just needed another step
			end	
			
			if(preDone == 1'b1) begin
				preDone_c = 1'b0;
				wr_addr = 15'd16 + writeCount + 1;
				ram_in = 32'd0;
				ram_wren = 1'b1;
				control[1] = 1'b1; //set done = 1;
				interface_data[0] = control;
			end
			
		end //end lmgDone=1


		

		/*
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
		*/
	end //end start = 1
	
	/*
	if ((!control[0]) && control_p1[0]) // If start changed from 1 to 0
	begin
		counter = counter_p1 + 1; // This is for incrementing through the test data 
		if (counter > 9) counter = 0;
	end 
	*/
	
//======================== RESET ======================================
	
	/*
	if (control[2] == 1) // if reset == 1 (when reset is high the other control bits should be low)
	begin
		// Note: I only reset the necessary regs needed for functionality
		// No reason to reset RAM or interface_data really. Just be careful to read the correct data.
		counter = 0;
	end
	*/

end

always @ (posedge clk) begin
	rd_addr_p1 <= rd_addr;
	wr_addr_p1 <= wr_addr;
	//counter_p1 <= counter; // currently not used
	ram_wren_p1 <= ram_wren; 
	control_p1 <= control;
	
	lmgResetState <= lmgResetState_c;
	lmgReadEnable <= lmgReadEnable_c;
	lmgDone_p1 <= lmgDone;
	writeCount <= writeCount_c;	
	writeFromLmgDone <= writeFromLmgDone_c;
	allMovesDone <= allMovesDone_c;
	preDone <= preDone_c;
	
	preRead <= preRead_c;
	readWord1 <= readWord1_c;
	readWord2 <= readWord2_c;
	readWord3 <= readWord3_c;
	readWord4 <= readWord4_c;
	readWord5 <= readWord5_c;
	readWord6 <= readWord6_c;
	readWord7 <= readWord7_c;
	readWord8 <= readWord8_c;

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
	
end // always @ (posedge clk)
   
endmodule