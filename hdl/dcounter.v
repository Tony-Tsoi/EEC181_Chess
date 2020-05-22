module dcounter (clk, reset, setval, done);

input clk, reset;
input [11:0] setval;
output done;

reg [11:0] count, count_c;
assign done = (count == 11'd0);

always @(*) begin
	count_c = count - 11'd1;
	
	if (done == 1'b1)
		count_c = 11'd0;
	
	if (reset == 1'b1)
		count_c = setval;
end

always @(posedge clk) begin
	count <= count_c;
end

endmodule