## Generated SDC file "DE2_8052.sdc"

## Copyright (C) 1991-2013 Altera Corporation
## Your use of Altera Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Altera Program License 
## Subscription Agreement, Altera MegaCore Function License 
## Agreement, or other applicable license agreement, including, 
## without limitation, that your use is for the sole purpose of 
## programming logic devices manufactured by Altera and sold by 
## Altera or its authorized distributors.  Please refer to the 
## applicable agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus II"
## VERSION "Version 13.0.0 Build 156 04/24/2013 SJ Web Edition"

## DATE    "Thu Jun 06 22:27:33 2013"

##
## DEVICE  "EP2C35F672C6"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {TCK} -period 100.000 -waveform { 0.000 50.000 } [get_ports {TCK}]
create_clock -name {CLOCK_50} -period 20.000 -waveform { 0.000 10.000 } [get_ports {CLOCK_50}]

#**************************************************************
# Create Generated Clock
#**************************************************************
# 1. In tcl console window of TimeQuest, type derive_pll_clocks
# 2. tcl console window will update with the correct create_generated_clock constraints
# 3. copy the constraints and add into SDC file.

create_generated_clock -source {pll_33_MHz|cv_pll_inst|altera_pll_i|general[0].gpll~FRACTIONAL_PLL|refclkin} -multiply_by 8 -duty_cycle 50.00 -name {pll_33_MHz|cv_pll_inst|altera_pll_i|general[0].gpll~FRACTIONAL_PLL|vcoph[0]} {pll_33_MHz|cv_pll_inst|altera_pll_i|general[0].gpll~FRACTIONAL_PLL|vcoph[0]}
create_generated_clock -source {pll_33_MHz|cv_pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|vco0ph[0]} -divide_by 12 -duty_cycle 50.00 -name {pll_33_MHz|cv_pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk} {pll_33_MHz|cv_pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}

#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************



#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************

set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 


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

