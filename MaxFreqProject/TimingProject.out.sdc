## Generated SDC file "TimingProject.out.sdc"

## Copyright (C) 1991-2015 Altera Corporation. All rights reserved.
## Your use of Altera Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Altera Program License 
## Subscription Agreement, the Altera Quartus II License Agreement,
## the Altera MegaCore Function License Agreement, or other 
## applicable license agreement, including, without limitation, 
## that your use is for the sole purpose of programming logic 
## devices manufactured by Altera and sold by Altera or its 
## authorized distributors.  Please refer to the applicable 
## agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus II"
## VERSION "Version 15.0.0 Build 145 04/22/2015 SJ Full Version"

## DATE    "Wed Jun 10 16:52:17 2020"

##
## DEVICE  "5CSEMA5F31C6"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {clk} -period 2.000 -waveform { 0.000 1.000 } [get_ports { clk }]
create_clock -name {LMG:LMG_inst1|columnUnit:cole|sq_moved_flags[0]} -period 1.000 -waveform { 0.000 0.500 } [get_registers {LMG:LMG_inst1|columnUnit:cole|sq_moved_flags[0]}]
create_clock -name {LMG:LMG_inst1|columnUnit:colc|sq_moved_flags[0]} -period 1.000 -waveform { 0.000 0.500 } [get_registers {LMG:LMG_inst1|columnUnit:colc|sq_moved_flags[0]}]
create_clock -name {LMG:LMG_inst1|columnUnit:colb|sq_moved_flags[0]} -period 1.000 -waveform { 0.000 0.500 } [get_registers {LMG:LMG_inst1|columnUnit:colb|sq_moved_flags[0]}]
create_clock -name {LMG:LMG_inst1|columnUnit:cola|sq_moved_flags[0]} -period 1.000 -waveform { 0.000 0.500 } [get_registers {LMG:LMG_inst1|columnUnit:cola|sq_moved_flags[0]}]
create_clock -name {LMG:LMG_inst1|columnUnit:colf|sq_moved_flags[0]} -period 1.000 -waveform { 0.000 0.500 } [get_registers {LMG:LMG_inst1|columnUnit:colf|sq_moved_flags[0]}]
create_clock -name {LMG:LMG_inst1|columnUnit:cold|sq_moved_flags[0]} -period 1.000 -waveform { 0.000 0.500 } [get_registers {LMG:LMG_inst1|columnUnit:cold|sq_moved_flags[0]}]
create_clock -name {LMG:LMG_inst1|columnUnit:colh|sq_moved_flags[0]} -period 1.000 -waveform { 0.000 0.500 } [get_registers {LMG:LMG_inst1|columnUnit:colh|sq_moved_flags[0]}]
create_clock -name {LMG:LMG_inst1|columnUnit:colg|sq_moved_flags[0]} -period 1.000 -waveform { 0.000 0.500 } [get_registers {LMG:LMG_inst1|columnUnit:colg|sq_moved_flags[0]}]
create_clock -name {LMG:LMG_inst1|columnUnit:colg|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty} -period 1.000 -waveform { 0.000 0.500 } [get_registers {LMG:LMG_inst1|columnUnit:colg|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}]
create_clock -name {LMG:LMG_inst1|columnUnit:colb|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty} -period 1.000 -waveform { 0.000 0.500 } [get_registers {LMG:LMG_inst1|columnUnit:colb|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}]
create_clock -name {LMG:LMG_inst1|columnUnit:colf|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty} -period 1.000 -waveform { 0.000 0.500 } [get_registers {LMG:LMG_inst1|columnUnit:colf|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}]
create_clock -name {LMG:LMG_inst1|columnUnit:colc|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty} -period 1.000 -waveform { 0.000 0.500 } [get_registers {LMG:LMG_inst1|columnUnit:colc|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}]
create_clock -name {LMG:LMG_inst1|columnUnit:cola|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty} -period 1.000 -waveform { 0.000 0.500 } [get_registers {LMG:LMG_inst1|columnUnit:cola|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}]
create_clock -name {LMG:LMG_inst1|columnUnit:colh|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty} -period 1.000 -waveform { 0.000 0.500 } [get_registers {LMG:LMG_inst1|columnUnit:colh|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}]
create_clock -name {LMG:LMG_inst1|columnUnit:cole|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty} -period 1.000 -waveform { 0.000 0.500 } [get_registers {LMG:LMG_inst1|columnUnit:cole|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}]
create_clock -name {LMG:LMG_inst1|columnUnit:cold|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty} -period 1.000 -waveform { 0.000 0.500 } [get_registers {LMG:LMG_inst1|columnUnit:cold|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}]


#**************************************************************
# Create Generated Clock
#**************************************************************



#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:cold|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -rise_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:cold|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -rise_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:cold|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -fall_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:cold|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -fall_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:cold|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -rise_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:cold|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -rise_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:cold|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -fall_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:cold|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -fall_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:cole|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -rise_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:cole|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -rise_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:cole|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -fall_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:cole|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -fall_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:cole|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -rise_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:cole|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -rise_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:cole|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -fall_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:cole|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -fall_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:colh|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -rise_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:colh|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -rise_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:colh|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -fall_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:colh|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -fall_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:colh|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -rise_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:colh|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -rise_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:colh|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -fall_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:colh|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -fall_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:cola|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -rise_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:cola|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -rise_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:cola|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -fall_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:cola|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -fall_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:cola|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -rise_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:cola|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -rise_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:cola|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -fall_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:cola|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -fall_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:colc|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -rise_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:colc|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -rise_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:colc|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -fall_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:colc|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -fall_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:colc|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -rise_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:colc|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -rise_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:colc|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -fall_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:colc|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -fall_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:colf|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -rise_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:colf|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -rise_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:colf|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -fall_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:colf|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -fall_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:colf|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -rise_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:colf|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -rise_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:colf|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -fall_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:colf|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -fall_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:colb|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -rise_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:colb|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -rise_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:colb|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -fall_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:colb|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -fall_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:colb|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -rise_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:colb|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -rise_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:colb|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -fall_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:colb|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -fall_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:colg|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -rise_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:colg|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -rise_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:colg|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -fall_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:colg|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -fall_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:colg|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -rise_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:colg|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -rise_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:colg|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -fall_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:colg|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -fall_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:colg|sq_moved_flags[0]}] -rise_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:colg|sq_moved_flags[0]}] -rise_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:colg|sq_moved_flags[0]}] -fall_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:colg|sq_moved_flags[0]}] -fall_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:colg|sq_moved_flags[0]}] -rise_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:colg|sq_moved_flags[0]}] -rise_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:colg|sq_moved_flags[0]}] -fall_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:colg|sq_moved_flags[0]}] -fall_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:colh|sq_moved_flags[0]}] -rise_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:colh|sq_moved_flags[0]}] -rise_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:colh|sq_moved_flags[0]}] -fall_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:colh|sq_moved_flags[0]}] -fall_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:colh|sq_moved_flags[0]}] -rise_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:colh|sq_moved_flags[0]}] -rise_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:colh|sq_moved_flags[0]}] -fall_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:colh|sq_moved_flags[0]}] -fall_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:cold|sq_moved_flags[0]}] -rise_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:cold|sq_moved_flags[0]}] -rise_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:cold|sq_moved_flags[0]}] -fall_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:cold|sq_moved_flags[0]}] -fall_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:cold|sq_moved_flags[0]}] -rise_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:cold|sq_moved_flags[0]}] -rise_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:cold|sq_moved_flags[0]}] -fall_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:cold|sq_moved_flags[0]}] -fall_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:cola|sq_moved_flags[0]}] -rise_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:cola|sq_moved_flags[0]}] -rise_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:cola|sq_moved_flags[0]}] -fall_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:cola|sq_moved_flags[0]}] -fall_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:cola|sq_moved_flags[0]}] -rise_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:cola|sq_moved_flags[0]}] -rise_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:cola|sq_moved_flags[0]}] -fall_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:cola|sq_moved_flags[0]}] -fall_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:colb|sq_moved_flags[0]}] -rise_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:colb|sq_moved_flags[0]}] -rise_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:colb|sq_moved_flags[0]}] -fall_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:colb|sq_moved_flags[0]}] -fall_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:colb|sq_moved_flags[0]}] -rise_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:colb|sq_moved_flags[0]}] -rise_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:colb|sq_moved_flags[0]}] -fall_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:colb|sq_moved_flags[0]}] -fall_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:cole|sq_moved_flags[0]}] -rise_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:cole|sq_moved_flags[0]}] -rise_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:cole|sq_moved_flags[0]}] -fall_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:cole|sq_moved_flags[0]}] -fall_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:cole|sq_moved_flags[0]}] -rise_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:cole|sq_moved_flags[0]}] -rise_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:cole|sq_moved_flags[0]}] -fall_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:cole|sq_moved_flags[0]}] -fall_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:colc|sq_moved_flags[0]}] -rise_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:colc|sq_moved_flags[0]}] -rise_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:colc|sq_moved_flags[0]}] -fall_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:colc|sq_moved_flags[0]}] -fall_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:colc|sq_moved_flags[0]}] -rise_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:colc|sq_moved_flags[0]}] -rise_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:colc|sq_moved_flags[0]}] -fall_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:colc|sq_moved_flags[0]}] -fall_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -rise_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:cold|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -setup 0.090  
set_clock_uncertainty -rise_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:cold|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -hold 0.080  
set_clock_uncertainty -rise_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:cold|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -setup 0.090  
set_clock_uncertainty -rise_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:cold|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -hold 0.080  
set_clock_uncertainty -rise_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:cole|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -setup 0.090  
set_clock_uncertainty -rise_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:cole|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -hold 0.080  
set_clock_uncertainty -rise_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:cole|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -setup 0.090  
set_clock_uncertainty -rise_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:cole|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -hold 0.080  
set_clock_uncertainty -rise_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:colh|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -setup 0.090  
set_clock_uncertainty -rise_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:colh|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -hold 0.080  
set_clock_uncertainty -rise_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:colh|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -setup 0.090  
set_clock_uncertainty -rise_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:colh|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -hold 0.080  
set_clock_uncertainty -rise_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:cola|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -setup 0.090  
set_clock_uncertainty -rise_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:cola|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -hold 0.080  
set_clock_uncertainty -rise_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:cola|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -setup 0.090  
set_clock_uncertainty -rise_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:cola|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -hold 0.080  
set_clock_uncertainty -rise_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:colc|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -setup 0.090  
set_clock_uncertainty -rise_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:colc|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -hold 0.080  
set_clock_uncertainty -rise_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:colc|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -setup 0.090  
set_clock_uncertainty -rise_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:colc|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -hold 0.080  
set_clock_uncertainty -rise_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:colf|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -setup 0.090  
set_clock_uncertainty -rise_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:colf|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -hold 0.080  
set_clock_uncertainty -rise_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:colf|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -setup 0.090  
set_clock_uncertainty -rise_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:colf|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -hold 0.080  
set_clock_uncertainty -rise_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:colb|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -setup 0.090  
set_clock_uncertainty -rise_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:colb|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -hold 0.080  
set_clock_uncertainty -rise_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:colb|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -setup 0.090  
set_clock_uncertainty -rise_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:colb|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -hold 0.080  
set_clock_uncertainty -rise_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:colg|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -setup 0.090  
set_clock_uncertainty -rise_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:colg|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -hold 0.080  
set_clock_uncertainty -rise_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:colg|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -setup 0.090  
set_clock_uncertainty -rise_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:colg|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -hold 0.080  
set_clock_uncertainty -rise_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:colg|sq_moved_flags[0]}] -setup 0.090  
set_clock_uncertainty -rise_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:colg|sq_moved_flags[0]}] -hold 0.080  
set_clock_uncertainty -rise_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:colg|sq_moved_flags[0]}] -setup 0.090  
set_clock_uncertainty -rise_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:colg|sq_moved_flags[0]}] -hold 0.080  
set_clock_uncertainty -rise_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:colh|sq_moved_flags[0]}] -setup 0.090  
set_clock_uncertainty -rise_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:colh|sq_moved_flags[0]}] -hold 0.080  
set_clock_uncertainty -rise_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:colh|sq_moved_flags[0]}] -setup 0.090  
set_clock_uncertainty -rise_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:colh|sq_moved_flags[0]}] -hold 0.080  
set_clock_uncertainty -rise_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:cold|sq_moved_flags[0]}] -setup 0.090  
set_clock_uncertainty -rise_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:cold|sq_moved_flags[0]}] -hold 0.080  
set_clock_uncertainty -rise_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:cold|sq_moved_flags[0]}] -setup 0.090  
set_clock_uncertainty -rise_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:cold|sq_moved_flags[0]}] -hold 0.080  
set_clock_uncertainty -rise_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:cola|sq_moved_flags[0]}] -setup 0.090  
set_clock_uncertainty -rise_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:cola|sq_moved_flags[0]}] -hold 0.080  
set_clock_uncertainty -rise_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:cola|sq_moved_flags[0]}] -setup 0.090  
set_clock_uncertainty -rise_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:cola|sq_moved_flags[0]}] -hold 0.080  
set_clock_uncertainty -rise_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:colb|sq_moved_flags[0]}] -setup 0.090  
set_clock_uncertainty -rise_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:colb|sq_moved_flags[0]}] -hold 0.080  
set_clock_uncertainty -rise_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:colb|sq_moved_flags[0]}] -setup 0.090  
set_clock_uncertainty -rise_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:colb|sq_moved_flags[0]}] -hold 0.080  
set_clock_uncertainty -rise_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:cole|sq_moved_flags[0]}] -setup 0.090  
set_clock_uncertainty -rise_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:cole|sq_moved_flags[0]}] -hold 0.080  
set_clock_uncertainty -rise_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:cole|sq_moved_flags[0]}] -setup 0.090  
set_clock_uncertainty -rise_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:cole|sq_moved_flags[0]}] -hold 0.080  
set_clock_uncertainty -rise_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:colc|sq_moved_flags[0]}] -setup 0.090  
set_clock_uncertainty -rise_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:colc|sq_moved_flags[0]}] -hold 0.080  
set_clock_uncertainty -rise_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:colc|sq_moved_flags[0]}] -setup 0.090  
set_clock_uncertainty -rise_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:colc|sq_moved_flags[0]}] -hold 0.080  
set_clock_uncertainty -rise_from [get_clocks {clk}] -rise_to [get_clocks {clk}] -setup 0.170  
set_clock_uncertainty -rise_from [get_clocks {clk}] -rise_to [get_clocks {clk}] -hold 0.060  
set_clock_uncertainty -rise_from [get_clocks {clk}] -fall_to [get_clocks {clk}] -setup 0.170  
set_clock_uncertainty -rise_from [get_clocks {clk}] -fall_to [get_clocks {clk}] -hold 0.060  
set_clock_uncertainty -rise_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:colf|sq_moved_flags[0]}] -setup 0.090  
set_clock_uncertainty -rise_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:colf|sq_moved_flags[0]}] -hold 0.080  
set_clock_uncertainty -rise_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:colf|sq_moved_flags[0]}] -setup 0.090  
set_clock_uncertainty -rise_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:colf|sq_moved_flags[0]}] -hold 0.080  
set_clock_uncertainty -fall_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:cold|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -setup 0.090  
set_clock_uncertainty -fall_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:cold|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -hold 0.080  
set_clock_uncertainty -fall_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:cold|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -setup 0.090  
set_clock_uncertainty -fall_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:cold|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -hold 0.080  
set_clock_uncertainty -fall_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:cole|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -setup 0.090  
set_clock_uncertainty -fall_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:cole|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -hold 0.080  
set_clock_uncertainty -fall_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:cole|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -setup 0.090  
set_clock_uncertainty -fall_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:cole|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -hold 0.080  
set_clock_uncertainty -fall_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:colh|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -setup 0.090  
set_clock_uncertainty -fall_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:colh|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -hold 0.080  
set_clock_uncertainty -fall_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:colh|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -setup 0.090  
set_clock_uncertainty -fall_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:colh|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -hold 0.080  
set_clock_uncertainty -fall_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:cola|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -setup 0.090  
set_clock_uncertainty -fall_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:cola|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -hold 0.080  
set_clock_uncertainty -fall_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:cola|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -setup 0.090  
set_clock_uncertainty -fall_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:cola|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -hold 0.080  
set_clock_uncertainty -fall_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:colc|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -setup 0.090  
set_clock_uncertainty -fall_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:colc|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -hold 0.080  
set_clock_uncertainty -fall_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:colc|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -setup 0.090  
set_clock_uncertainty -fall_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:colc|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -hold 0.080  
set_clock_uncertainty -fall_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:colf|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -setup 0.090  
set_clock_uncertainty -fall_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:colf|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -hold 0.080  
set_clock_uncertainty -fall_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:colf|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -setup 0.090  
set_clock_uncertainty -fall_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:colf|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -hold 0.080  
set_clock_uncertainty -fall_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:colb|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -setup 0.090  
set_clock_uncertainty -fall_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:colb|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -hold 0.080  
set_clock_uncertainty -fall_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:colb|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -setup 0.090  
set_clock_uncertainty -fall_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:colb|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -hold 0.080  
set_clock_uncertainty -fall_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:colg|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -setup 0.090  
set_clock_uncertainty -fall_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:colg|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -hold 0.080  
set_clock_uncertainty -fall_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:colg|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -setup 0.090  
set_clock_uncertainty -fall_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:colg|squareUnit:sq1|Square_FIFO:F1F0|scfifo:scfifo_component|scfifo_85a1:auto_generated|a_dpfifo_rs91:dpfifo|a_fefifo_66f:fifo_state|b_non_empty}] -hold 0.080  
set_clock_uncertainty -fall_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:colg|sq_moved_flags[0]}] -setup 0.090  
set_clock_uncertainty -fall_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:colg|sq_moved_flags[0]}] -hold 0.080  
set_clock_uncertainty -fall_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:colg|sq_moved_flags[0]}] -setup 0.090  
set_clock_uncertainty -fall_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:colg|sq_moved_flags[0]}] -hold 0.080  
set_clock_uncertainty -fall_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:colh|sq_moved_flags[0]}] -setup 0.090  
set_clock_uncertainty -fall_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:colh|sq_moved_flags[0]}] -hold 0.080  
set_clock_uncertainty -fall_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:colh|sq_moved_flags[0]}] -setup 0.090  
set_clock_uncertainty -fall_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:colh|sq_moved_flags[0]}] -hold 0.080  
set_clock_uncertainty -fall_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:cold|sq_moved_flags[0]}] -setup 0.090  
set_clock_uncertainty -fall_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:cold|sq_moved_flags[0]}] -hold 0.080  
set_clock_uncertainty -fall_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:cold|sq_moved_flags[0]}] -setup 0.090  
set_clock_uncertainty -fall_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:cold|sq_moved_flags[0]}] -hold 0.080  
set_clock_uncertainty -fall_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:cola|sq_moved_flags[0]}] -setup 0.090  
set_clock_uncertainty -fall_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:cola|sq_moved_flags[0]}] -hold 0.080  
set_clock_uncertainty -fall_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:cola|sq_moved_flags[0]}] -setup 0.090  
set_clock_uncertainty -fall_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:cola|sq_moved_flags[0]}] -hold 0.080  
set_clock_uncertainty -fall_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:colb|sq_moved_flags[0]}] -setup 0.090  
set_clock_uncertainty -fall_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:colb|sq_moved_flags[0]}] -hold 0.080  
set_clock_uncertainty -fall_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:colb|sq_moved_flags[0]}] -setup 0.090  
set_clock_uncertainty -fall_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:colb|sq_moved_flags[0]}] -hold 0.080  
set_clock_uncertainty -fall_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:cole|sq_moved_flags[0]}] -setup 0.090  
set_clock_uncertainty -fall_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:cole|sq_moved_flags[0]}] -hold 0.080  
set_clock_uncertainty -fall_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:cole|sq_moved_flags[0]}] -setup 0.090  
set_clock_uncertainty -fall_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:cole|sq_moved_flags[0]}] -hold 0.080  
set_clock_uncertainty -fall_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:colc|sq_moved_flags[0]}] -setup 0.090  
set_clock_uncertainty -fall_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:colc|sq_moved_flags[0]}] -hold 0.080  
set_clock_uncertainty -fall_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:colc|sq_moved_flags[0]}] -setup 0.090  
set_clock_uncertainty -fall_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:colc|sq_moved_flags[0]}] -hold 0.080  
set_clock_uncertainty -fall_from [get_clocks {clk}] -rise_to [get_clocks {clk}] -setup 0.170  
set_clock_uncertainty -fall_from [get_clocks {clk}] -rise_to [get_clocks {clk}] -hold 0.060  
set_clock_uncertainty -fall_from [get_clocks {clk}] -fall_to [get_clocks {clk}] -setup 0.170  
set_clock_uncertainty -fall_from [get_clocks {clk}] -fall_to [get_clocks {clk}] -hold 0.060  
set_clock_uncertainty -fall_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:colf|sq_moved_flags[0]}] -setup 0.090  
set_clock_uncertainty -fall_from [get_clocks {clk}] -rise_to [get_clocks {LMG:LMG_inst1|columnUnit:colf|sq_moved_flags[0]}] -hold 0.080  
set_clock_uncertainty -fall_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:colf|sq_moved_flags[0]}] -setup 0.090  
set_clock_uncertainty -fall_from [get_clocks {clk}] -fall_to [get_clocks {LMG:LMG_inst1|columnUnit:colf|sq_moved_flags[0]}] -hold 0.080  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:colf|sq_moved_flags[0]}] -rise_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:colf|sq_moved_flags[0]}] -rise_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:colf|sq_moved_flags[0]}] -fall_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {LMG:LMG_inst1|columnUnit:colf|sq_moved_flags[0]}] -fall_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:colf|sq_moved_flags[0]}] -rise_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:colf|sq_moved_flags[0]}] -rise_to [get_clocks {clk}] -hold 0.090  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:colf|sq_moved_flags[0]}] -fall_to [get_clocks {clk}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {LMG:LMG_inst1|columnUnit:colf|sq_moved_flags[0]}] -fall_to [get_clocks {clk}] -hold 0.090  


#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************



#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************

