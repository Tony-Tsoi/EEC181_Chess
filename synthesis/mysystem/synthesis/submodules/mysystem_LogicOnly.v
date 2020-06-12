// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module mysystem_LogicOnly 
(
clk,
reset,

address,
write,
read,
writedata,
readdata
);

input            clk;
input            reset;

output  [ 31: 0] readdata;
input   [  1: 0] address;
input            write;
input            read;
input   [ 31: 0] writedata;


reg    [ 31: 0] readdata;


// I registered necessary signals in order to pipeline
// a write operation. 
reg [1:0] address_p1;
reg write_p1;
reg [ 31: 0] writedata_p1;


reg [31:0] storage;
reg [31:0] storage_p1;


always @(*)
begin
	storage = storage_p1;
	readdata = 0;

	if (write)
	begin
		if (address == 0) storage = writedata;
	end
	
	else if (read)
	begin
		if (address == 0) readdata = storage;
	end
	
end

always @(posedge clk or posedge reset)
begin
	if (reset == 1)
	begin
		storage_p1 <= 0;
	
		address_p1 	 <= 0;
		write_p1	 <= 0;
		writedata_p1 <= 0;
	end
	
	else
	begin
		storage_p1 <= storage;
	
		//address_p1 	 <= address;
		//write_p1	 <= write;
		//writedata_p1 <= writedata;
	
	end
		
end

endmodule

