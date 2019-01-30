set_global_assignment -entity "CV_PLL" -library "lib_CV_PLL" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "CV_PLL" -library "lib_CV_PLL" -name IP_TOOL_VERSION "15.1"
set_global_assignment -entity "CV_PLL" -library "lib_CV_PLL" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_CV_PLL" -name SPD_FILE [file join $::quartus(sip_path) "CV_PLL.spd"]

set_global_assignment -library "lib_CV_PLL" -name MISC_FILE [file join $::quartus(sip_path) "CV_PLL_sim/CV_PLL.vho"]
