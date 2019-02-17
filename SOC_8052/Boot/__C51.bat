@echo off
::This file was created automatically by CrossIDE to compile with C51.
C:
cd "\Source\SOC_8052\Boot\"
"C:\Source\call51\Bin\c51.exe" --use-stdout --code-loc 0xf000 "C:\Source\SOC_8052\Boot\CV_Boot_SPI.c"
if not exist hex2mif.exe goto done
if exist CV_Boot_SPI.ihx hex2mif CV_Boot_SPI.ihx
if exist CV_Boot_SPI.hex hex2mif CV_Boot_SPI.hex
:done
echo done
echo Crosside_Action Set_Hex_File C:\Source\SOC_8052\Boot\CV_Boot_SPI.hex
