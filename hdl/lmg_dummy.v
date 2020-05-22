module lmg_dummy (clk, reset, bstate, done, fifoOut, rden, fifoEmpty,
	lcas_flag, rcas_flag, enp_flags);

// IO
input clk, reset, rden;
output done, fifoEmpty;
output [159:0] fifoOut;

// not used
input [255:0] bstate; // board state
input lcas_flag, rcas_flag;
input [1:8] enp_flags;

// state definitions
parameter RSET = 3'b000;
parameter WRW1 = 3'b001;
parameter WRW2 = 3'b011;
parameter WRW3 = 3'b111;
parameter DONE = 3'b110;

// invalid move
parameter IMOV = {7'h40, 6'o00, 6'o00};

// state bits
reg [2:0] state, state_c;

reg [159:0] wr1, wr1_c;
reg wrreq, wrreq_c;

// fifo
My_FIFO F1F0 (.clock(clk), .data(wr1), .q(fifoOut), .wrreq(wrreq), .rdreq(rden), .empty(fifoEmpty), .clear(reset),
	.usedw(), .full() );

// predefined moves to be written into FIFO
7'b0000000, 6'o01, 6'o02, 
parameter DMV1 = {8'd0, 
	7'd0, 6'o01, 6'o02, 7'd0, 6'o11, 6'o12, 7'd0, 6'o21, 6'o22, 7'd0, 6'o31, 6'o32, 
	7'd0, 6'o41, 6'o42, 7'd0, 6'o51, 6'o52, 7'd0, 6'o61, 6'o62, 7'd0, 6'o71, 6'o72}; // pawn mv 1
parameter DMV2 = {8'd0, 
	7'd0, 6'o01, 6'o03, 7'd0, 6'o11, 6'o13, 7'd0, 6'o21, 6'o23, 7'd0, 6'o31, 6'o33, 
	7'd0, 6'o41, 6'o43, 7'd0, 6'o51, 6'o53, 7'd0, 6'o61, 6'o63, 7'd0, 6'o71, 6'o73}; // pawn mv 2
parameter DMV3 = {8'd0, 
	7'd0, 6'o10, 6'o02, 7'd0, 6'o10, 6'o22, 7'd0, 6'o60, 6'o52, 7'd0, 6'o60, 6'o72, 
	7'h40, 6'o41, 6'o42, 7'h40, 6'o51, 6'o52, 7'h40, 6'o61, 6'o62, 7'h40, 6'o71, 6'o72}; // 4 kni 4 inv
	
// done signal
assign done = (state == DONE);

// always block
always @(*) begin
	state_c = state;
	wr1_c = {8'd0, {8{IMOV}}};
	
	case (state)
		RSET: begin
			state_c = WRFI;
		end
		WRW1: begin
			wr1_c = DMV1;
			wrreq_c = 1'b1;
			state_c = WRW2;
		end
		WRW2: begin
			wr1_c = DMV2;
			wrreq_c = 1'b1;
			state_c = WRW3;
		end
		WRW3: begin
			wr1_c = DMV3;
			wrreq_c = 1'b1;
			state_c = DONE;
		end
		DONE: begin end
		default: begin
			state_c = RSET;
		end
	endcase
end

// FF
always @(posedge clk) begin
	state <= (reset == 1'b1)? RSET : state_c;
	wrreq <= wrreq_c;
	wr1 <= wr1_c;
end

endmodule