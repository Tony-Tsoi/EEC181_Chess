module lmg (clk, reset, bstate, done, fifoOut, rden);

// 19 bit output per move from fifoOut has the following format:
// [7b flag][6b from][6b to]
// seven bit flag bits as follows:
// [invalid][promote][pawn move][pawn 2 sq][en passant][castle][capture]

// TODO: add king castling

input clk, reset;
input [255:0] bstate; // board state

output done = &{done_cols}; // to be changed by state

output [151:0] fifoOut;
input rden;

// parameter declarations
parameter PVOID = 9'h0; // it's just {3'o0, 3'o0, EMPTY} - denotes an empty space at xpos = 0, ypos = 0
parameter PVOID8 = 72'h0;
parameter PVOID7 = 63'h0;
parameter PVOID6 = 54'h0;

parameter COLA = 3'o0; parameter COLB = 3'o1; parameter COLC = 3'o2; parameter COLD = 3'o3;
parameter COLE = 3'o4; parameter COLF = 3'o5; parameter COLG = 3'o6; parameter COLH = 3'o7;

// parameter for states
parameter WAIT = 2'b01;
parameter GETM = 2'b11;
parameter DONE = 2'b10;

// board state
wire colstate_a = {bstate[227:224], bstate[195:192], bstate[163:160], bstate[131:128], 
	bstate[99:96], bstate[67:64], bstate[35:32], bstate[3:0]};
wire colstate_b = {bstate[231:228], bstate[199:196], bstate[167:164], bstate[135:132], 
	bstate[103:100], bstate[71:68], bstate[39:36], bstate[7:4]};
wire colstate_c = {bstate[235:232], bstate[203:200], bstate[171:168], bstate[139:136], 
	bstate[107:104], bstate[75:72], bstate[43:40], bstate[11:8]};
wire colstate_d = {bstate[239:236], bstate[207:204], bstate[175:172], bstate[143:140], 
	bstate[111:108], bstate[79:76], bstate[47:44], bstate[15:12]};
wire colstate_e = {bstate[243:240], bstate[211:208], bstate[179:176], bstate[147:144], 
	bstate[115:112], bstate[83:80], bstate[51:48], bstate[19:16]};
wire colstate_f = {bstate[247:244], bstate[215:212], bstate[183:180], bstate[151:148], 
	bstate[119:116], bstate[87:84], bstate[55:52], bstate[23:20]};
wire colstate_g = {bstate[251:248], bstate[219:216], bstate[187:184], bstate[155:152], 
	bstate[123:120], bstate[91:88], bstate[59:56], bstate[27:24]};
wire colstate_h = {bstate[255:252], bstate[223:220], bstate[191:188], bstate[159:156], 
	bstate[127:124], bstate[95:92], bstate[63:60], bstate[31:28]};

// done signals from columns
wire [7:0] done_cols;

// state bit
reg [1:0] state, state_c;

// moves transferred to local fifo flag
reg [8:1] col_moved_flags, col_moved_flags_c;

// pointer for GETM state
reg [2:0] col_move_ptr, col_move_ptr_c;

// read enable for square fifo
reg [8:1] col_rden, col_rden_c;

// FIFO Module Declaration
wire [151:0] fifoOut_col8, fifoOut_col7, fifoOut_col6, fifoOut_col5, 
	fifoOut_col4, fifoOut_col3, fifoOut_col2, fifoOut_col1;

reg wren1;
wire [47:0] wr1 = (col_move_ptr == 3'd7)? fifoOut_col8 :
	(col_move_ptr == 3'd6)? fifoOut_col7 :
	(col_move_ptr == 3'd5)? fifoOut_col6 :
	(col_move_ptr == 3'd4)? fifoOut_col5 :
	(col_move_ptr == 3'd3)? fifoOut_col4 :
	(col_move_ptr == 3'd2)? fifoOut_col3 :
	(col_move_ptr == 3'd1)? fifoOut_col2 : fifoOut_col1;
MyFifo F1F0 (.clk(clk), .wr1(wr1), .wr2(48'd0), .rd1(fifoOut), .wren1(wren1), .wren2(1'b0));

// next state logic
always @(*) begin
	state_c = state;
	col_rden_c = 8'h00;
	
	case (state)
		WAIT: begin
			// if a done signal is up and is not grabbed to FIFO
			if (done_cols[8])
				if (~col_moved_flags[8]) begin
					state_c = GETM;
					col_move_ptr_c = 3'd7;
					col_rden_c = 8'h80;
				end
			
			if (done_cols[7])
				if (~col_moved_flags[7]) begin
					state_c = GETM;
					col_move_ptr_c = 3'd6;
					col_rden_c = 8'h40;
				end
			
			if (done_cols[6])
				if (~col_moved_flags[6]) begin
					state_c = GETM;
					col_move_ptr_c = 3'd5;
					col_rden_c = 8'h20;
				end
			
			if (done_cols[5])
				if (~col_moved_flags[5]) begin
					state_c = GETM;
					col_move_ptr_c = 3'd4;
					col_rden_c = 8'h10;
				end
			
			if (done_cols[4])
				if (~col_moved_flags[4]) begin
					state_c = GETM;
					col_move_ptr_c = 3'd3;
					col_rden_c = 8'h08;
				end
			
			if (done_cols[3])
				if (~col_moved_flags[3]) begin
					state_c = GETM;
					col_move_ptr_c = 3'd2;
					col_rden_c = 8'h04;
				end
			
			if (done_cols[2])
				if (~col_moved_flags[2]) begin
					state_c = GETM;
					col_move_ptr_c = 3'd1;
					col_rden_c = 8'h02;
				end
			
			if (done_cols[1])
				if (~col_moved_flags[1]) begin
					state_c = GETM;
					col_move_ptr_c = 3'd0;
					col_rden_c = 8'h01;
				end
			
			if (&{col_moved_flags}) // if all columns grabbed move
				state_c = DONE;
		end
		GETM: begin
			// get move from specified column until exhausted
			col_rden_c = col_rden;
			
			// if all moves from column fifo gone
			if (wr1 == ENDMOV)
				state_c = WAIT;
		end
	endcase
	
	if (reset == 1'b1)
		col_moved_flags = 8'h00;
end

// wiring all the hold signals from all directions that is across columns
wire [8:1] chdiri_a = chlri_a | chlurdi_a | chldrui_a;
wire [8:1] chdiri_b = chlri_b | chlurdi_b | chldrui_b;
wire [8:1] chdiri_c = chlri_c | chlurdi_c | chldrui_c;
wire [8:1] chdiri_d = chlri_d | chlurdi_d | chldrui_d;
wire [8:1] chdiri_e = chlri_e | chlurdi_e | chldrui_e;
wire [8:1] chdiri_f = chlri_f | chlurdi_f | chldrui_f;
wire [8:1] chdiri_g = chlri_g | chlurdi_g | chldrui_g;
wire [8:1] chdiri_h = chlri_h | chlurdi_h | chldrui_h;

// only to left or right holds
wire [8:1] chlri_a =          chlo_b | chlo_c | chlo_d | chlo_e | chlo_f | chlo_g | chlo_h;
wire [8:1] chlri_b = chro_a |          chlo_c | chlo_d | chlo_e | chlo_f | chlo_g | chlo_h;
wire [8:1] chlri_c = chro_a | chro_b |          chlo_d | chlo_e | chlo_f | chlo_g | chlo_h;
wire [8:1] chlri_d = chro_a | chro_b | chro_c |          chlo_e | chlo_f | chlo_g | chlo_h;
wire [8:1] chlri_e = chro_a | chro_b | chro_c | chro_d |          chlo_f | chlo_g | chlo_h;
wire [8:1] chlri_f = chro_a | chro_b | chro_c | chro_d | chro_e |          chlo_g | chlo_h;
wire [8:1] chlri_g = chro_a | chro_b | chro_c | chro_d | chro_e | chro_f |          chlo_h;
wire [8:1] chlri_h = chro_a | chro_b | chro_c | chro_d | chro_e | chro_f | chro_g         ;

// only to top left or bottom right holds
wire [8:1] chlurdi_a, chlurdi_b, chlurdi_c, chlurdi_d, chlurdi_e, chlurdi_f, chlurdi_g;

assign chlurdi_a[1] = 1'b0;

assign chlurdi_a[2] =             chluo_b[1];
assign chlurdi_b[1] = chrdo_a[2];

assign chlurdi_a[3] = |{            chluo_b[2], chluo_c[1]};
assign chlurdi_b[2] = |{chrdo_a[3],             chluo_c[1]};
assign chlurdi_c[1] = |{chrdo_a[3], chrdo_b[2]            };

assign chlurdi_a[4] = |{            chluo_b[3], chluo_c[2], chluo_d[1]};
assign chlurdi_b[3] = |{chrdo_a[4],             chluo_c[2], chluo_d[1]};
assign chlurdi_c[2] = |{chrdo_a[4], chrdo_b[3],             chluo_d[1]};
assign chlurdi_d[1] = |{chrdo_a[4], chrdo_b[3], chrdo_c[2]            };

assign chlurdi_a[5] = |{            chluo_b[4], chluo_c[3], chluo_d[2], chluo_e[1]};
assign chlurdi_b[4] = |{chrdo_a[5],             chluo_c[3], chluo_d[2], chluo_e[1]};
assign chlurdi_c[3] = |{chrdo_a[5], chrdo_b[4],             chluo_d[2], chluo_e[1]};
assign chlurdi_d[2] = |{chrdo_a[5], chrdo_b[4], chrdo_c[3],             chluo_e[1]};
assign chlurdi_e[1] = |{chrdo_a[5], chrdo_b[4], chrdo_c[3], chrdo_d[2]            };

assign chlurdi_a[6] = |{            chluo_b[5], chluo_c[4], chluo_d[3], chluo_e[2], chluo_f[1]};
assign chlurdi_b[5] = |{chrdo_a[6],             chluo_c[4], chluo_d[3], chluo_e[2], chluo_f[1]};
assign chlurdi_c[4] = |{chrdo_a[6], chrdo_b[5],             chluo_d[3], chluo_e[2], chluo_f[1]};
assign chlurdi_d[3] = |{chrdo_a[6], chrdo_b[5], chrdo_c[4],             chluo_e[2], chluo_f[1]};
assign chlurdi_e[2] = |{chrdo_a[6], chrdo_b[5], chrdo_c[4], chrdo_d[3],             chluo_f[1]};
assign chlurdi_f[1] = |{chrdo_a[6], chrdo_b[5], chrdo_c[4], chrdo_d[3], chrdo_e[2],           };

assign chlurdi_a[7] = |{            chluo_b[6], chluo_c[5], chluo_d[4], chluo_e[3], chluo_f[2], chluo_g[1]};
assign chlurdi_b[6] = |{chrdo_a[7],             chluo_c[5], chluo_d[4], chluo_e[3], chluo_f[2], chluo_g[1]};
assign chlurdi_c[5] = |{chrdo_a[7], chrdo_b[6],             chluo_d[4], chluo_e[3], chluo_f[2], chluo_g[1]};
assign chlurdi_d[4] = |{chrdo_a[7], chrdo_b[6], chrdo_c[5],             chluo_e[3], chluo_f[2], chluo_g[1]};
assign chlurdi_e[3] = |{chrdo_a[7], chrdo_b[6], chrdo_c[5], chrdo_d[4],             chluo_f[2], chluo_g[1]};
assign chlurdi_f[2] = |{chrdo_a[7], chrdo_b[6], chrdo_c[5], chrdo_d[4], chrdo_e[3],             chluo_g[1]};
assign chlurdi_f[2] = |{chrdo_a[7], chrdo_b[6], chrdo_c[5], chrdo_d[4], chrdo_e[3], chrdo_f[2]            };

assign chlurdi_a[8] = |{            chluo_b[7], chluo_c[6], chluo_d[5], chluo_e[4], chluo_f[3], chluo_g[2], chluo_h[1]};
assign chlurdi_b[7] = |{chrdo_a[8],             chluo_c[6], chluo_d[5], chluo_e[4], chluo_f[3], chluo_g[2], chluo_h[1]};
assign chlurdi_c[6] = |{chrdo_a[8], chrdo_b[7],             chluo_d[5], chluo_e[4], chluo_f[3], chluo_g[2], chluo_h[1]};
assign chlurdi_d[5] = |{chrdo_a[8], chrdo_b[7], chrdo_c[6],             chluo_e[4], chluo_f[3], chluo_g[2], chluo_h[1]};
assign chlurdi_e[4] = |{chrdo_a[8], chrdo_b[7], chrdo_c[6], chrdo_d[5],             chluo_f[3], chluo_g[2], chluo_h[1]};
assign chlurdi_f[3] = |{chrdo_a[8], chrdo_b[7], chrdo_c[6], chrdo_d[5], chrdo_e[4],             chluo_g[2], chluo_h[1]};
assign chlurdi_g[2] = |{chrdo_a[8], chrdo_b[7], chrdo_c[6], chrdo_d[5], chrdo_e[4], chrdo_f[3],             chluo_h[1]};
assign chlurdi_h[1] = |{chrdo_a[8], chrdo_b[7], chrdo_c[6], chrdo_d[5], chrdo_e[4], chrdo_f[3], chrdo_g[2]             };

assign chlurdi_b[8] = |{            chluo_c[7], chluo_d[6], chluo_e[5], chluo_f[4], chluo_g[3], chluo_h[2]};
assign chlurdi_c[7] = |{chrdo_b[8],             chluo_d[6], chluo_e[5], chluo_f[4], chluo_g[3], chluo_h[2]};
assign chlurdi_d[6] = |{chrdo_b[8], chrdo_c[7],             chluo_e[5], chluo_f[4], chluo_g[3], chluo_h[2]};
assign chlurdi_e[5] = |{chrdo_b[8], chrdo_c[7], chrdo_d[6],             chluo_f[4], chluo_g[3], chluo_h[2]};
assign chlurdi_f[4] = |{chrdo_b[8], chrdo_c[7], chrdo_d[6], chrdo_e[5],             chluo_g[3], chluo_h[2]};
assign chlurdi_g[3] = |{chrdo_b[8], chrdo_c[7], chrdo_d[6], chrdo_e[5], chrdo_f[4],             chluo_h[2]};
assign chlurdi_h[2] = |{chrdo_b[8], chrdo_c[7], chrdo_d[6], chrdo_e[5], chrdo_f[4], chrdo_g[3]            };

assign chlurdi_c[8] = |{            chluo_d[7], chluo_e[6], chluo_f[5], chluo_g[4], chluo_h[3]};
assign chlurdi_d[7] = |{chrdo_c[8],             chluo_e[6], chluo_f[5], chluo_g[4], chluo_h[3]};
assign chlurdi_e[6] = |{chrdo_c[8], chrdo_d[7],             chluo_f[5], chluo_g[4], chluo_h[3]};
assign chlurdi_f[5] = |{chrdo_c[8], chrdo_d[7], chrdo_e[6],             chluo_g[4], chluo_h[3]};
assign chlurdi_g[4] = |{chrdo_c[8], chrdo_d[7], chrdo_e[6], chrdo_f[5],             chluo_h[3]};
assign chlurdi_h[3] = |{chrdo_c[8], chrdo_d[7], chrdo_e[6], chrdo_f[5], chrdo_g[4]            };

assign chlurdi_d[8] = |{            chluo_e[7], chluo_f[6], chluo_g[5], chluo_h[4]};
assign chlurdi_e[7] = |{chrdo_d[8],             chluo_f[6], chluo_g[5], chluo_h[4]};
assign chlurdi_f[6] = |{chrdo_d[8], chrdo_e[7],             chluo_g[5], chluo_h[4]};
assign chlurdi_g[5] = |{chrdo_d[8], chrdo_e[7], chrdo_f[6],             chluo_h[4]};
assign chlurdi_h[4] = |{chrdo_d[8], chrdo_e[7], chrdo_f[6], chrdo_g[5]            };

assign chlurdi_e[8] = |{            chluo_f[7], chluo_g[6], chluo_h[5]};
assign chlurdi_f[7] = |{chrdo_e[8],             chluo_g[6], chluo_h[5]};
assign chlurdi_g[6] = |{chrdo_e[8], chrdo_f[7],             chluo_h[5]};
assign chlurdi_h[5] = |{chrdo_e[8], chrdo_f[7], chrdo_g[6]            };

assign chlurdi_f[8] = |{            chluo_g[6], chluo_h[5]};
assign chlurdi_g[7] = |{chrdo_f[7],             chluo_h[5]};
assign chlurdi_h[6] = |{chrdo_f[7], chrdo_g[6]            };

assign chlurdi_g[8] = chluo_h[7];
assign chlurdi_h[7] =             chrdo_g[8];

assign chlurdi_h[8] = 1'b0;

// only to top right and bottom left direction holds
wire [8:1] chldrui_a, chldrui_b, chldrui_c, chldrui_d, chldrui_e, chldrui_f, chldrui_g, chldrui_h;

assign chldrui_a[8] = 1'b0;

assign chldrui_a[7] = chldo_b[8];
assign chldrui_b[8] = chruo_a[7];

assign chldrui_a[6] = |{            chldo_b[7], chldo_c[8]};
assign chldrui_b[7] = |{chruo_a[6],             chldo_c[8]};
assign chldrui_c[8] = |{chruo_a[6], chruo_b[7]            };

assign chldrui_a[5] = |{            chldo_b[6], chldo_c[7], chldo_d[8]};
assign chldrui_b[6] = |{chruo_a[5],             chldo_c[7], chldo_d[8]};
assign chldrui_c[7] = |{chruo_a[5], chruo_b[6],             chldo_d[8]};
assign chldrui_d[8] = |{chruo_a[5], chruo_b[6], chruo_c[7]            };

assign chldrui_a[4] = |{            chldo_b[5], chldo_c[6], chldo_d[7], chldo_e[8]};
assign chldrui_b[5] = |{chruo_a[4],             chldo_c[6], chldo_d[7], chldo_e[8]};
assign chldrui_c[6] = |{chruo_a[4], chruo_b[5],             chldo_d[7], chldo_e[8]};
assign chldrui_d[7] = |{chruo_a[4], chruo_b[5], chruo_c[6],             chldo_e[8]};
assign chldrui_e[8] = |{chruo_a[4], chruo_b[5], chruo_c[6], chruo_d[7]            };

assign chldrui_a[3] = |{            chldo_b[4], chldo_c[5], chldo_d[6], chldo_e[7], chldo_f[8]};
assign chldrui_b[4] = |{chruo_a[3],             chldo_c[5], chldo_d[6], chldo_e[7], chldo_f[8]};
assign chldrui_c[5] = |{chruo_a[3], chruo_b[4],             chldo_d[6], chldo_e[7], chldo_f[8]};
assign chldrui_d[6] = |{chruo_a[3], chruo_b[4], chruo_c[5],             chldo_e[7], chldo_f[8]};
assign chldrui_e[7] = |{chruo_a[3], chruo_b[4], chruo_c[5], chruo_d[6],             chldo_f[8]};
assign chldrui_f[8] = |{chruo_a[3], chruo_b[4], chruo_c[5], chruo_d[6], chruo_e[7]            };

assign chldrui_a[2] = |{            chldo_b[3], chldo_c[4], chldo_d[5], chldo_e[6], chldo_f[7], chldo_g[8]};
assign chldrui_b[3] = |{chruo_a[2],             chldo_c[4], chldo_d[5], chldo_e[6], chldo_f[7], chldo_g[8]};
assign chldrui_c[4] = |{chruo_a[2], chruo_b[3],             chldo_d[5], chldo_e[6], chldo_f[7], chldo_g[8]};
assign chldrui_d[5] = |{chruo_a[2], chruo_b[3], chruo_c[4],             chldo_e[6], chldo_f[7], chldo_g[8]};
assign chldrui_e[6] = |{chruo_a[2], chruo_b[3], chruo_c[4], chruo_d[5],             chldo_f[7], chldo_g[8]};
assign chldrui_f[7] = |{chruo_a[2], chruo_b[3], chruo_c[4], chruo_d[5], chruo_e[6],             chldo_g[8]};
assign chldrui_g[8] = |{chruo_a[2], chruo_b[3], chruo_c[4], chruo_d[5], chruo_e[6], chldo_f[7]            };

assign chldrui_a[1] = |{            chldo_b[2], chldo_c[3], chldo_d[4], chldo_e[5], chldo_f[6], chldo_g[7], chldo_h[8]};
assign chldrui_b[2] = |{chruo_a[1],             chldo_c[3], chldo_d[4], chldo_e[5], chldo_f[6], chldo_g[7], chldo_h[8]};
assign chldrui_c[3] = |{chruo_a[1], chruo_b[2],             chldo_d[4], chldo_e[5], chldo_f[6], chldo_g[7], chldo_h[8]};
assign chldrui_d[4] = |{chruo_a[1], chruo_b[2], chruo_c[3],             chldo_e[5], chldo_f[6], chldo_g[7], chldo_h[8]};
assign chldrui_e[5] = |{chruo_a[1], chruo_b[2], chruo_c[3], chruo_d[4],             chldo_f[6], chldo_g[7], chldo_h[8]};
assign chldrui_f[6] = |{chruo_a[1], chruo_b[2], chruo_c[3], chruo_d[4], chruo_e[5],             chldo_g[7], chldo_h[8]};
assign chldrui_g[7] = |{chruo_a[1], chruo_b[2], chruo_c[3], chruo_d[4], chruo_e[5], chruo_f[6],             chldo_h[8]};
assign chldrui_h[8] = |{chruo_a[1], chruo_b[2], chruo_c[3], chruo_d[4], chruo_e[5], chruo_f[6], chldo_g[7]            };

assign chldrui_b[1] = |{            chldo_c[2], chldo_d[3], chldo_e[4], chldo_f[5], chldo_g[6], chldo_h[7]};
assign chldrui_c[2] = |{chruo_b[1],             chldo_d[3], chldo_e[4], chldo_f[5], chldo_g[6], chldo_h[7]};
assign chldrui_d[3] = |{chruo_b[1], chruo_c[2],             chldo_e[4], chldo_f[5], chldo_g[6], chldo_h[7]};
assign chldrui_e[4] = |{chruo_b[1], chruo_c[2], chruo_d[3],             chldo_f[5], chldo_g[6], chldo_h[7]};
assign chldrui_f[5] = |{chruo_b[1], chruo_c[2], chruo_d[3], chruo_e[4],             chldo_g[6], chldo_h[7]};
assign chldrui_g[6] = |{chruo_b[1], chruo_c[2], chruo_d[3], chruo_e[4], chruo_f[5],             chldo_h[7]};
assign chldrui_h[7] = |{chruo_b[1], chruo_c[2], chruo_d[3], chruo_e[4], chruo_f[5], chruo_g[6]            };

assign chldrui_c[1] = |{            chldo_d[2], chldo_e[3], chldo_f[4], chldo_g[5], chldo_h[6]};
assign chldrui_d[2] = |{chruo_c[1],             chldo_e[3], chldo_f[4], chldo_g[5], chldo_h[6]};
assign chldrui_e[3] = |{chruo_c[1], chruo_d[2],             chldo_f[4], chldo_g[5], chldo_h[6]};
assign chldrui_f[4] = |{chruo_c[1], chruo_d[2], chruo_e[3],             chldo_g[5], chldo_h[6]};
assign chldrui_g[5] = |{chruo_c[1], chruo_d[2], chruo_e[3], chruo_f[4],             chldo_h[6]};
assign chldrui_h[6] = |{chruo_c[1], chruo_d[2], chruo_e[3], chruo_f[4], chldo_g[5]            };

assign chldrui_d[1] = |{            chldo_e[2], chldo_f[3], chldo_g[4], chldo_h[5]};
assign chldrui_e[2] = |{chruo_d[1],             chldo_f[3], chldo_g[4], chldo_h[5]};
assign chldrui_f[3] = |{chruo_d[1], chruo_e[2],             chldo_g[4], chldo_h[5]};
assign chldrui_g[4] = |{chruo_d[1], chruo_e[2], chruo_f[3],             chldo_h[5]};
assign chldrui_h[5] = |{chruo_d[1], chruo_e[2], chruo_f[3], chruo_g[4]            };

assign chldrui_e[1] = |{            chldo_f[2], chldo_g[3], chldo_h[4]};
assign chldrui_f[2] = |{chruo_e[1],             chldo_g[3], chldo_h[4]};
assign chldrui_g[3] = |{chruo_e[1], chruo_f[2],             chldo_h[4]};
assign chldrui_h[4] = |{chruo_e[1], chruo_f[2], chruo_g[3]            };

assign chldrui_f[1] = |{            chldo_g[2], chldo_h[3]};
assign chldrui_g[2] = |{chruo_f[1],             chldo_h[3]};
assign chldrui_h[3] = |{chruo_f[1], chldo_g[2]            };

assign chldrui_g[1] = chldo_h[2];
assign chldrui_h[2] = chruo_g[1];

assign chldrui_h[1] = 1'b0;

// Column A
wire [53:0] cilddi_a, coruuo_a;
wire [62:0] cidi_a, cildi_a, cilldi_a, couo_a, coruo_a, corruo_a;
wire [71:0] cili_a, coro_a;
wire [71:9] ciui_a, cilui_a, cillui_a, codo_a, cordo_a, corrdo_a;
wire [71:18] ciluui_a, corddo_a;

wire [8:2] chluo_a, chruo_a;
wire [8:1] chlo_a, chro_a;
wire [7:1] chldo_a, chrdo_a;

columnUnit cola (.clk(clk), .xpos(COLA), .done(done_cols[7]), .bstate(bstate), .reset(reset), .colstate(colstate_a),
	.chdiri(chdiri_a), 
	.cirrdi(PVOID7), .cirrui(PVOID7), .cirddi(PVOID6), .cirdi(PVOID7), .ciri(PVOID8), 
	.cirui(PVOID7), .ciruui(PVOID6),
	.cidi(cidi_a), .ciui(ciui_a), .cilddi(cilddi_a), .cildi(cildi_a), .cili(cili_a), 
	.cilui(cilui_a), .ciluui(ciluui_a), .cilldi(cilldi_a), .cillui(cillui_a),
	.colluo(), .colldo(), .coluuo(), .coluo(), .colo(), .coldo(), .colddo(),
	.couo(couo_a), .codo(codo_a), .coruuo(coruuo_a), .coruo(coruo_a), .coro(coro_a),
	.cordo(cordo_a), .corddo(corddo_a), .corruo(corruo_a), .corrdo(corrdo_a),
	.chluo(chluo_a), .chruo(chruo_a), .chlo(chlo_a), .chro(chro_a), .chldo(chldo_a), .chrdo(chrdo_a));

// Column B
wire [53:0] cirddi_b, cilddi_b;
wire [62:0] cirdi_b, cidi_b, cildi_b, cilldi_b;
wire [71:0] ciri_b, cili_b;
wire [71:9] cirui_b, ciui_b, cilui_b, cillui_b;
wire [71:18] ciruui_b, ciluui_b;

wire [53:0] coluuo_b, coruuo_b;
wire [62:0] coluo_b, couo_b, coruo_b, corruo_b;
wire [71:0] colo_b, coro_b;
wire [71:9] coldo_b, codo_b, cordo_b, corrdo_b;
wire [71:18] colddo_b, corddo_b;

wire [8:2] chluo_b, chruo_b;
wire [8:1] chlo_b, chro_b;
wire [7:1] chldo_b, chrdo_b;

columnUnit colb (.clk(clk), .xpos(COLB), .done(done_cols[6]), .bstate(bstate), .reset(reset), .colstate(colstate_b),
	.chdiri(chdiri_b), 
	.cirrdi(PVOID7), .cirrui(PVOID7), 
	.cirddi(cirddi_b), .cirdi(cirdi_b), .ciri(ciri_b), .cirui(cirui_b), .ciruui(ciruui_b),
	.cidi(cidi_b), .ciui(ciui_b), .cilddi(cilddi_b), .cildi(cildi_b), .cili(cili_b), 
	.cilui(cilui_b), .ciluui(ciluui_b), .cilldi(cilldi_b), .cillui(cillui_b),
	.colluo(), .colldo(),
	.coluuo(coluuo_b), .coluo(coluo_b), .colo(colo_b), .coldo(coldo_b), .colddo(colddo_b),
	.couo(couo_b), .codo(codo_b), .coruuo(coruuo_b), .coruo(coruo_b), .coro(coro_b),
	.cordo(cordo_b), .corddo(corddo_b), .corruo(corruo_b), .corrdo(corrdo_b),
	.chluo(chluo_b), .chruo(chruo_b), .chlo(chlo_b), .chro(chro_b), .chldo(chldo_b), .chrdo(chrdo_b) );

// Column C
wire [53:0] cirddi_c, cilddi_c;
wire [62:0] cirrdi_c, cirdi_c, cidi_c, cildi_c, cilldi_c;
wire [71:0] ciri_c, cili_c;
wire [71:9] cirrui_c, cirui_c, ciui_c, cilui_c, cillui_c;
wire [71:18] ciruui_c, ciluui_c;

wire [53:0] coluuo_c, coruuo_c;
wire [62:0] colluo_c, coluo_c, couo_c, coruo_c, corruo_c;
wire [71:0] colo_c, coro_c;
wire [71:9] colldo_c, coldo_c, codo_c, cordo_c, corrdo_c;
wire [71:18] colddo_c, corddo_c;

wire [8:2] chluo_c, chruo_c;
wire [8:1] chlo_c, chro_c;
wire [7:1] chldo_c, chrdo_c;

columnUnit colc (.clk(clk), .xpos(COLC), .done(done_cols[5]), .bstate(bstate), .reset(reset), .colstate(colstate_c),
	.chdiri(chdiri_c), 
	.cirrdi(cirrdi_c), .cirrui(cirrui_c), 
	.cirddi(cirddi_c), .cirdi(cirdi_c), .ciri(ciri_c), .cirui(cirui_c), .ciruui(ciruui_c),
	.cidi(cidi_c), .ciui(ciui_c), .cilddi(cilddi_c), .cildi(cildi_c), .cili(cili_c), 
	.cilui(cilui_c), .ciluui(ciluui_c), .cilldi(cilldi_c), .cillui(cillui_c),
	.colluo(colluo_c), .colldo(colldo_c),
	.coluuo(coluuo_c), .coluo(coluo_c), .colo(colo_c), .coldo(coldo_c), .colddo(colddo_c),
	.couo(couo_c), .codo(codo_c), .coruuo(coruuo_c), .coruo(coruo_c), .coro(coro_c),
	.cordo(cordo_c), .corddo(corddo_c), .corruo(corruo_c), .corrdo(corrdo_c),
	.chluo(chluo_c), .chruo(chruo_c), .chlo(chlo_c), .chro(chro_c), .chldo(chldo_c), .chrdo(chrdo_c) );

// Column D
wire [53:0] cirddi_d, cilddi_d;
wire [62:0] cirrdi_d, cirdi_d, cidi_d, cildi_d, cilldi_d;
wire [71:0] ciri_d, cili_d;
wire [71:9] cirrui_d, cirui_d, ciui_d, cilui_d, cillui_d;
wire [71:18] ciruui_d, ciluui_d;

wire [53:0] coluuo_d, coruuo_d;
wire [62:0] colluo_d, coluo_d, couo_d, coruo_d, corruo_d;
wire [71:0] colo_d, coro_d;
wire [71:9] colldo_d, coldo_d, codo_d, cordo_d, corrdo_d;
wire [71:18] colddo_d, corddo_d;

wire [8:2] chluo_d, chruo_d;
wire [8:1] chlo_d, chro_d;
wire [7:1] chldo_d, chrdo_d;

columnUnit cold (.clk(clk), .xpos(COLD), .done(done_cols[4]), .bstate(bstate), .reset(reset), .colstate(colstate_d),
	.chdiri(chdiri_d), 
	.cirrdi(cirrdi_d), .cirrui(cirrui_d), 
	.cirddi(cirddi_d), .cirdi(cirdi_d), .ciri(ciri_d), .cirui(cirui_d), .ciruui(ciruui_d),
	.cidi(cidi_d), .ciui(ciui_d), .cilddi(cilddi_d), .cildi(cildi_d), .cili(cili_d), 
	.cilui(cilui_d), .ciluui(ciluui_d), .cilldi(cilldi_d), .cillui(cillui_d),
	.colluo(colluo_d), .colldo(colldo_d),
	.coluuo(coluuo_d), .coluo(coluo_d), .colo(colo_d), .coldo(coldo_d), .colddo(colddo_d),
	.couo(couo_d), .codo(codo_d), .coruuo(coruuo_d), .coruo(coruo_d), .coro(coro_d),
	.cordo(cordo_d), .corddo(corddo_d), .corruo(corruo_d), .corrdo(corrdo_d),
	.chluo(chluo_d), .chruo(chruo_d), .chlo(chlo_d), .chro(chro_d), .chldo(chldo_d), .chrdo(chrdo_d) );

// Column E
wire [53:0] cirddi_e, cilddi_e;
wire [62:0] cirrdi_e, cirdi_e, cidi_e, cildi_e, cilldi_e;
wire [71:0] ciri_e, cili_e;
wire [71:9] cirrui_e, cirui_e, ciui_e, cilui_e, cillui_e;
wire [71:18] ciruui_e, ciluui_e;

wire [53:0] coluuo_e, coruuo_e;
wire [62:0] colluo_e, coluo_e, couo_e, coruo_e, corruo_e;
wire [71:0] colo_e, coro_e;
wire [71:9] colldo_e, coldo_e, codo_e, cordo_e, corrdo_e;
wire [71:18] colddo_e, corddo_e;

wire [8:2] chluo_e, chruo_e;
wire [8:1] chlo_e, chro_e;
wire [7:1] chldo_e, chrdo_e;

columnUnit cole (.clk(clk), .xpos(COLE), .done(done_cols[3]), .bstate(bstate), .reset(reset), .colstate(colstate_e),
	.chdiri(chdiri_e), 
	.cirrdi(cirrdi_e), .cirrui(cirrui_e), 
	.cirddi(cirddi_e), .cirdi(cirdi_e), .ciri(ciri_e), .cirui(cirui_e), .ciruui(ciruui_e),
	.cidi(cidi_e), .ciui(ciui_e), .cilddi(cilddi_e), .cildi(cildi_e), .cili(cili_e), 
	.cilui(cilui_e), .ciluui(ciluui_e), .cilldi(cilldi_e), .cillui(cillui_e),
	.colluo(colluo_e), .colldo(colldo_e),
	.coluuo(coluuo_e), .coluo(coluo_e), .colo(colo_e), .coldo(coldo_e), .colddo(colddo_e),
	.couo(couo_e), .codo(codo_e), .coruuo(coruuo_e), .coruo(coruo_e), .coro(coro_e),
	.cordo(cordo_e), .corddo(corddo_e), .corruo(corruo_e), .corrdo(corrdo_e),
	.chluo(chluo_e), .chruo(chruo_e), .chlo(chlo_e), .chro(chro_e), .chldo(chldo_e), .chrdo(chrdo_e) );

// Column F
wire [53:0] cirddi_f, cilddi_f;
wire [62:0] cirrdi_f, cirdi_f, cidi_f, cildi_f, cilldi_f;
wire [71:0] ciri_f, cili_f;
wire [71:9] cirrui_f, cirui_f, ciui_f, cilui_f, cillui_f;
wire [71:18] ciruui_f, ciluui_f;

wire [53:0] coluuo_f, coruuo_f;
wire [62:0] colluo_f, coluo_f, couo_f, coruo_f, corruo_f;
wire [71:0] colo_f, coro_f;
wire [71:9] colldo_f, coldo_f, codo_f, cordo_f, corrdo_f;
wire [71:18] colddo_f, corddo_f;

wire [8:2] chluo_f, chruo_f;
wire [8:1] chlo_f, chro_f;
wire [7:1] chldo_f, chrdo_f;

columnUnit colf (.clk(clk), .xpos(COLF), .done(done_cols[2]), .bstate(bstate), .reset(reset), .colstate(colstate_f),
	.chdiri(chdiri_f), 
	.cirrdi(cirrdi_f), .cirrui(cirrui_f), 
	.cirddi(cirddi_f), .cirdi(cirdi_f), .ciri(ciri_f), .cirui(cirui_f), .ciruui(ciruui_f),
	.cidi(cidi_f), .ciui(ciui_f), .cilddi(cilddi_f), .cildi(cildi_f), .cili(cili_f), 
	.cilui(cilui_f), .ciluui(ciluui_f), .cilldi(cilldi_f), .cillui(cillui_f),
	.colluo(colluo_f), .colldo(colldo_f),
	.coluuo(coluuo_f), .coluo(coluo_f), .colo(colo_f), .coldo(coldo_f), .colddo(colddo_f),
	.couo(couo_f), .codo(codo_f), .coruuo(coruuo_f), .coruo(coruo_f), .coro(coro_f),
	.cordo(cordo_f), .corddo(corddo_f), .corruo(corruo_f), .corrdo(corrdo_f),
	.chluo(chluo_f), .chruo(chruo_f), .chlo(chlo_f), .chro(chro_f), .chldo(chldo_f), .chrdo(chrdo_f) );

// Column G
wire [53:0] cirddi_g, cilddi_g;
wire [62:0] cirrdi_g, cirdi_g, cidi_g, cildi_g;
wire [71:0] ciri_g, cili_g;
wire [71:9] cirrui_g, cirui_g, ciui_g, cilui_g;
wire [71:18] ciruui_g, ciluui_g;

wire [53:0] coluuo_g, coruuo_g;
wire [62:0] colluo_g, coluo_g, couo_g, coruo_g;
wire [71:0] colo_g, coro_g;
wire [71:9] colldo_g, coldo_g, codo_g, cordo_g;
wire [71:18] colddo_g, corddo_g;

wire [8:2] chluo_g, chruo_g;
wire [8:1] chlo_g, chro_g;
wire [7:1] chldo_g, chrdo_g;

columnUnit colg (.clk(clk), .xpos(COLG), .done(done_cols[1]), .bstate(bstate), .reset(reset), .colstate(colstate_g),
	.chdiri(chdiri_g), 
	.cirrdi(cirrdi_g), .cirrui(cirrui_g), 
	.cirddi(cirddi_g), .cirdi(cirdi_g), .ciri(ciri_g), .cirui(cirui_g), .ciruui(ciruui_g),
	.cidi(cidi_g), .ciui(ciui_g), .cilddi(cilddi_g), .cildi(cildi_g), .cili(cili_g), 
	.cilui(cilui_g), .ciluui(ciluui_g), .cilldi(PVOID7), .cillui(PVOID7),
	.colluo(colluo_g), .colldo(colldo_g),
	.coluuo(coluuo_g), .coluo(coluo_g), .colo(colo_g), .coldo(coldo_g), .colddo(colddo_g),
	.couo(couo_g), .codo(codo_g), .coruuo(coruuo_g), .coruo(coruo_g), .coro(coro_g),
	.cordo(cordo_g), .corddo(corddo_g), .corruo(), .corrdo(),
	.chluo(chluo_g), .chruo(chruo_g), .chlo(chlo_g), .chro(chro_g), .chldo(chldo_g), .chrdo(chrdo_g) );

// Column H
wire [53:0] cirddi_h;
wire [62:0] cirrdi_h, cirdi_h, cidi_h;
wire [71:0] ciri_h;
wire [71:9] cirrui_h, cirui_h, ciui_h;
wire [71:18] ciruui_h;

wire [53:0] coluuo_h;
wire [62:0] colluo_h, coluo_h, couo_h;
wire [71:0] colo_h;
wire [71:9] colldo_h, coldo_h, codo_h;
wire [71:18] colddo_h;

wire [8:2] chluo_h, chruo_h;
wire [8:1] chlo_h, chro_h;
wire [7:1] chldo_h, chrdo_h;

columnUnit colh (.clk(clk), .xpos(COLH), .done(done_cols[0]), .bstate(bstate), .reset(reset), .colstate(colstate_h),
	.chdiri(chdiri_h), 
	.cirrdi(cirrdi_h), .cirrui(cirrui_h), 
	.cirddi(cirddi_h), .cirdi(cirdi_h), .ciri(ciri_h), .cirui(cirui_h), .ciruui(ciruui_h),
	.cidi(cidi_h), .ciui(ciui_h), .cilddi(PVOID6), .cildi(PVOID7), .cili(PVOID8), 
	.cilui(PVOID7), .ciluui(PVOID6), .cilldi(PVOID7), .cillui(PVOID7),
	.colluo(colluo_h), .colldo(colldo_h),
	.coluuo(coluuo_h), .coluo(coluo_h), .colo(colo_h), .coldo(coldo_h), .colddo(colddo_h),
	.couo(couo_h), .codo(codo_h), .coruuo(), .coruo(), .coro(),
	.cordo(), .corddo(), .corruo(), .corrdo(),
	.chluo(chluo_h), .chruo(chruo_h), .chlo(chlo_h), .chro(chro_h), .chldo(chldo_h), .chrdo(chrdo_h) );

endmodule