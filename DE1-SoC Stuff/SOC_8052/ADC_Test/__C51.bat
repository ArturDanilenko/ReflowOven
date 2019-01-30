@echo off
::This file was created automatically by CrossIDE to compile with C51.
C:
cd "\Source\SOC_8052\ADC_Test\"
"C:\Source\call51\Bin\c51.exe" --use-stdout  "C:\Source\SOC_8052\ADC_Test\LTC2308_test.c"
if not exist hex2mif.exe goto done
if exist LTC2308_test.ihx hex2mif LTC2308_test.ihx
if exist LTC2308_test.hex hex2mif LTC2308_test.hex
:done
echo done
echo Crosside_Action Set_Hex_File C:\Source\SOC_8052\ADC_Test\LTC2308_test.hex
