module top
(
	input CLOCK_50,
	
	output [12:0] DRAM_ADDR,
	output [1:0] DRAM_BA,
	output DRAM_CAS_N,
	output DRAM_CKE,
	output DRAM_CLK,
	output DRAM_CS_N,
	
	inout [15:0] DRAM_DQ,
	output DRAM_LDQM,
	output DRAM_RAS_N,
	output DRAM_UDQM,
	output DRAM_WE_N,
		
	output [6:0] HEX0,
	output [6:0] HEX1,
	output [6:0] HEX2,
	output [6:0] HEX3,
	output [6:0] HEX4,
	output [6:0] HEX5,
	
	output [14:0] HPS_DDR3_ADDR,
	output [2:0] HPS_DDR3_BA,
	output HPS_DDR3_CAS_N,
	output HPS_DDR3_CKE,
	output HPS_DDR3_CK_N,
	output HPS_DDR3_CK_P,
	output HPS_DDR3_CS_N,
	output [3:0] HPS_DDR3_DM,
	inout [31:0] HPS_DDR3_DQ,
	inout [3:0] HPS_DDR3_DQS_N,
	inout [3:0] HPS_DDR3_DQS_P,
	output HPS_DDR3_ODT,
	output HPS_DDR3_RAS_N,
	output HPS_DDR3_RESET_N,
	input HPS_DDR3_RZQ,
	output HPS_DDR3_WE_N,
	
	output HPS_SD_CLK,
	inout HPS_SD_CMD,
	inout [3:0] HPS_SD_DATA,
	
	input HPS_UART_RX,
	output HPS_UART_TX,
	
	input HPS_USB_CLKOUT,
	inout [7:0] HPS_USB_DATA,
	input HPS_USB_DIR,
	input HPS_USB_NXT,
	output HPS_USB_STP,
	
	
	input [3:0] KEY,
	output [9:0] LEDR,
	input [9:0] SW,
	
	output [7:0] VGA_B,
	output VGA_BLANK_N,
	output VGA_CLK,
	output [7:0] VGA_G,
	output VGA_HS,
	output [7:0] VGA_R,
	output VGA_SYNC_N,
	output VGA_VS	
);

wire [31:0] hex3_hex0;
wire [15:0] hex5_hex4;

assign HEX0 = ~hex3_hex0[6:0];
assign HEX1 = ~hex3_hex0[14:8];
assign HEX2 = ~hex3_hex0[22:16];
assign HEX3 = ~hex3_hex0[30:24];
assign HEX4 = ~hex5_hex4[6:0];
assign HEX5 = ~hex5_hex4[14:8];

//wire hps_fpga_reset_n;
wire clk_65;
wire [7:0] vid_r, vid_g, vid_b;
wire vid_v_sync;
wire vid_h_sync;
wire vid_datavalid;

assign VGA_BLANK_N = 1'b1;
assign VGA_SYNC_N = 1'b0;
assign VGA_CLK = clk_65;
assign {VGA_B, VGA_G, VGA_R} = {vid_b, vid_g, vid_r};
assign VGA_VS = vid_v_sync;
assign VGA_HS = vid_h_sync;

mysystem u0 
(
	.clk_65_clk (clk_65),					 //clk_65.clk
	.clk_clk (CLOCK_50), 					//clk.clk
	//.reset_reset_n (1'b1), //reset.reset_n

	.memory_mem_a (HPS_DDR3_ADDR), //memory.mem_a
	.memory_mem_ba (HPS_DDR3_BA), //.mem_ba
	.memory_mem_ck (HPS_DDR3_CK_P), //.mem_ck
	.memory_mem_ck_n (HPS_DDR3_CK_N), //.mem_ck_n
	.memory_mem_cke (HPS_DDR3_CKE), //.mem_cke
	.memory_mem_cs_n (HPS_DDR3_CS_N), //.mem_cs_n
	.memory_mem_ras_n (HPS_DDR3_RAS_N), //.mem_ras_n
	.memory_mem_cas_n (HPS_DDR3_CAS_N), //.mem_cas_n
	.memory_mem_we_n (HPS_DDR3_WE_N), //.mem_we_n
	.memory_mem_reset_n (HPS_DDR3_RESET_N), //.mem_reset_n
	.memory_mem_dq (HPS_DDR3_DQ), //.mem_dq
	.memory_mem_dqs (HPS_DDR3_DQS_P), //.mem_dqs
	.memory_mem_dqs_n (HPS_DDR3_DQS_N), //.mem_dqs_n
	.memory_mem_odt (HPS_DDR3_ODT), //.mem_odt
	.memory_mem_dm (HPS_DDR3_DM), //.mem_dm
	.memory_oct_rzqin (HPS_DDR3_RZQ), //.oct_rzqin
		
	.hps_io_hps_io_sdio_inst_CMD (HPS_SD_CMD), //hps_io.hps_io_sdio_inst_CMD
	.hps_io_hps_io_sdio_inst_D0 (HPS_SD_DATA[0]), //.hps_io_sdio_inst_D0
	.hps_io_hps_io_sdio_inst_D1 (HPS_SD_DATA[1]), //.hps_io_sdio_inst_D1
	.hps_io_hps_io_sdio_inst_CLK (HPS_SD_CLK), //.hps_io_sdio_inst_CLK
	.hps_io_hps_io_sdio_inst_D2 (HPS_SD_DATA[2]), //.hps_io_sdio_inst_D2
	.hps_io_hps_io_sdio_inst_D3 (HPS_SD_DATA[3]), //.hps_io_sdio_inst_D3
	.hps_io_hps_io_usb1_inst_D0 (HPS_USB_DATA[0]), //.hps_io_usb1_inst_D0
	.hps_io_hps_io_usb1_inst_D1 (HPS_USB_DATA[1]), //.hps_io_usb1_inst_D1
	.hps_io_hps_io_usb1_inst_D2 (HPS_USB_DATA[2]), //.hps_io_usb1_inst_D2
	.hps_io_hps_io_usb1_inst_D3 (HPS_USB_DATA[3]), //.hps_io_usb1_inst_D3
	.hps_io_hps_io_usb1_inst_D4 (HPS_USB_DATA[4]), //.hps_io_usb1_inst_D4
	.hps_io_hps_io_usb1_inst_D5 (HPS_USB_DATA[5]), //.hps_io_usb1_inst_D5
	.hps_io_hps_io_usb1_inst_D6 (HPS_USB_DATA[6]), //.hps_io_usb1_inst_D6
	.hps_io_hps_io_usb1_inst_D7 (HPS_USB_DATA[7]), //.hps_io_usb1_inst_D7
	.hps_io_hps_io_usb1_inst_CLK (HPS_USB_CLKOUT), //.hps_io_usb1_inst_CLK
	.hps_io_hps_io_usb1_inst_STP (HPS_USB_STP), //.hps_io_usb1_inst_STP
	.hps_io_hps_io_usb1_inst_DIR (HPS_USB_DIR), //.hps_io_usb1_inst_DIR
	.hps_io_hps_io_usb1_inst_NXT (HPS_USB_NXT), //.hps_io_usb1_inst_NXT
	.hps_io_hps_io_uart0_inst_RX (HPS_UART_RX), //.hps_io_uart0_inst_RX
	.hps_io_hps_io_uart0_inst_TX (HPS_UART_TX), //.hps_io_uart0_inst_TX
	
	.leds_external_connection_export (LEDR), //led_pio_external_connection.export
	.switches_external_connection_export (SW), // switches_pio_external_connection.export
	.hex3_hex0_external_connection_export      (hex3_hex0),      // hex3_hex0_external_connection.export
	.hex5_hex4_external_connection_export      (hex5_hex4),      // hex5_hex4_external_connection.export
	
	//.hps_0_h2f_reset_reset_n (hps_fpga_reset_n), //hps_0_h2f_reset.reset_n   
	
	.alt_vip_itc_0_clocked_video_vid_clk (~clk_65), //alt_vip_itc_0_clocked_video.vid_clk
	.alt_vip_itc_0_clocked_video_vid_data ({vid_r,vid_g,vid_b}), //.vid_data
	.alt_vip_itc_0_clocked_video_underflow (), //.underflow
	.alt_vip_itc_0_clocked_video_vid_datavalid (vid_datavalid), // .vid_datavalid
	.alt_vip_itc_0_clocked_video_vid_v_sync (vid_v_sync), // .vid_v_sync
	.alt_vip_itc_0_clocked_video_vid_h_sync (vid_h_sync), // .vid_h_sync
	.alt_vip_itc_0_clocked_video_vid_f (), //.vid_f
	.alt_vip_itc_0_clocked_video_vid_h (), //.vid_h
	.alt_vip_itc_0_clocked_video_vid_v () // .vid_v
);

endmodule