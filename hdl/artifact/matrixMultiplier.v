`define CONTROL_OFFSET 2'b00
`define MATRIX_A_ADDRESS_OFFSET 2'b01
`define MATRIX_B_ADDRESS_OFFSET 2'b10
`define MATRIX_RESULT_ADDRESS_OFFSET 2'b11


module matrixMultiplier (
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

	parameter DATA_WIDTH = 32;   
	
	// clock interface
	input clk;
	input reset;


	// slave interface
	input [9:0] slave_address; //
	input slave_read;
	input slave_write;
	output reg [DATA_WIDTH-1:0] slave_readdata;
	input [DATA_WIDTH-1:0] slave_writedata;
	input [(DATA_WIDTH/8)-1:0] slave_byteenable;


	// REGS / WIRES
	wire [DATA_WIDTH-1:0] matrixA_dout;
	wire [DATA_WIDTH-1:0] matrixB_dout;
	wire [DATA_WIDTH-1:0] matrixResult_dout;

	wire matrixA_wren = slave_write & (slave_address[9:8] == `MATRIX_A_ADDRESS_OFFSET);
	wire matrixB_wren = slave_write & (slave_address[9:8] == `MATRIX_B_ADDRESS_OFFSET);

	reg [7:0] rd_addr;
	reg [7:0] rd_addr_p1;
	reg [7:0] wr_addr;
	reg [7:0] wr_addr_p1;
	reg matrixResult_wren; // p1
	reg matrixResult_wren_p2;

	reg [7:0] element3; // The 4 elements that make up 1 entry in the result RAM
	reg [7:0] element2; 
	reg [7:0] element1; 
	reg [7:0] element0; 
	reg [31:0] result_writedata;


	reg [31:0] control;
	reg [31:0] control_p1;
	wire start;
	assign start = control[0];
	wire done;
	assign done = control[1];
	wire reset_current_entry;
	assign reset_current_entry = control[2];

	reg start_p1;
	reg [7:0] current_entry;
	reg [7:0] current_entry_p1;
	reg done_p1;



   //Instantiate two memories to hold the matrices and one for results. Each is 32bits wide and 256 deep. Each is dual ported.
   MatrixRAM	matrixA(
       .clock ( clk),
       .data ( slave_writedata ),
       .rdaddress (rd_addr),
       .wraddress (wr_addr),
       .wren (matrixA_wren),
       .q (matrixA_dout)
       );

   MatrixRAM	matrixB(
      .clock ( clk),
      .data ( slave_writedata ),
      .rdaddress (rd_addr),
      .wraddress (wr_addr),
      .wren (matrixB_wren),
      .q (matrixB_dout)
      );
   
   MatrixRAM	matrixResult(
       .clock ( clk),
       .data ( result_writedata ),
       .rdaddress (rd_addr),
       .wraddress (wr_addr),
       .wren (matrixResult_wren),
       .q (matrixResult_dout)
       );
		 

   always @(*) // @(slave_address or matrixA_dout or matrixB_dout or matrixResult_dout)
   begin
		matrixResult_wren = 1'b0;
		current_entry = current_entry_p1;
		control = control_p1;
		rd_addr = rd_addr_p1;
		wr_addr = wr_addr_p1;
		element3 = 0;
		element2 = 0;
		element1 = 0;
		element0 = 0;
		result_writedata = 0;

		if (slave_write == 1) 
		begin
			case(slave_address[9:8])  
				`MATRIX_A_ADDRESS_OFFSET: 
				begin
					wr_addr = slave_address[7:0];
				end
				`MATRIX_B_ADDRESS_OFFSET: 
				begin
					wr_addr = slave_address[7:0];
				end
				`MATRIX_RESULT_ADDRESS_OFFSET: begin end// This should never happen
				`CONTROL_OFFSET: 
				begin
					if (slave_address[7:0] == 0) 
					begin 
						control = slave_writedata; 
					end
				end
			endcase // case (slave_address[9:8])
		end
		
		if (reset_current_entry == 1) begin 
			current_entry = 0; 
		end
		
		if (start == 1'b0) begin 
			control[1] = 1'b0; // Done = 0
		end
		
		if (start == 1'b1) begin 
			rd_addr = current_entry; 
			if (start_p1 == 1'b1) begin // RAM read output is ready to read after 1 cycle
				element3 = matrixA_dout[31:24] + matrixB_dout[31:24];
				element2 = matrixA_dout[23:16] + matrixB_dout[23:16];
				element1 = matrixA_dout[15:8] + matrixB_dout[15:8];
				element0 = matrixA_dout[7:0] + matrixB_dout[7:0];
				result_writedata = {element3, element2, element1, element0};
				wr_addr = current_entry;
				matrixResult_wren = 1'b1;
			end
			if (matrixResult_wren_p2 == 1'b1) begin // If matrix result written then done
				control[1] = 1'b1; // Done = 1
			end
		end
		
		if (slave_read == 1) begin
			case(slave_address[9:8])  
				`MATRIX_A_ADDRESS_OFFSET: begin
					rd_addr = slave_address[7:0];
					slave_readdata = matrixA_dout;
				end
				`MATRIX_B_ADDRESS_OFFSET: begin
					rd_addr = slave_address[7:0];
					slave_readdata = matrixB_dout;
				end
				`MATRIX_RESULT_ADDRESS_OFFSET: begin
					rd_addr = slave_address[7:0];
					slave_readdata = matrixResult_dout;
				end
				`CONTROL_OFFSET: begin
					slave_readdata = 0;
					if (slave_address[7:0] == 0) begin slave_readdata = control; end
				end
			endcase // case (slave_address[9:8])
		end
		
		if ((done == 1)&&(done_p1 == 0)) begin 
			current_entry = current_entry_p1 + 1; 
		end// If done with 1 loop then increment entry
		if (current_entry == 256) begin 
			current_entry = 0; 
		end
   end
   
	
   always @ (posedge clk) begin
		start_p1 <= start;
		matrixResult_wren_p2 <= matrixResult_wren;
		done_p1 <= done;
		current_entry_p1 <= current_entry;
		control_p1 <= control;
		rd_addr_p1 <= rd_addr;
		wr_addr_p1 <= wr_addr;

	
   end // always @ (posedge clk)
endmodule 




   
	      
	     
	     
   
   
   
		       

   
