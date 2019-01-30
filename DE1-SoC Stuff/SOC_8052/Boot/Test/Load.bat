@echo off
C:\Altera\15.0\quartus\bin64\quartus_stp.exe -t Load_Script.tcl %1 | find /V "Info:" | find /V "Warning (113007):"