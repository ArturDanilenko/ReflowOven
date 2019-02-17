@echo off
C:\Altera\13.0sp1\quartus\bin\quartus_stp.exe -t Load_Script.tcl %1 | find /V "Info:" | find /V "Warning (113007):"