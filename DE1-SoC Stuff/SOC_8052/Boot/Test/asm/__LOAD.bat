@echo off
::This file was created automatically by CrossIDE to load a hex file using Quartus_stp.
"C:\Programs\altera\15.0\quartus\bin64\quartus_stp.exe" -t "C:\Source\crosside\Load_Script.tcl" "C:\Source\CV_8052\Boot\Test\asm\LCD_Hello_world_test.HEX" | find /v "Warning (113007)"
