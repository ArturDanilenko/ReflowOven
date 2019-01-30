@echo off
C:
cd "\Source\CV_8052\Boot\Test\asm\"
"C:\Source\call51\bin\a51.exe" -l "C:\Source\CV_8052\Boot\Test\asm\LCD_Hello_world_test.asm"
echo Crosside_Action Set_Hex_File C:\Source\CV_8052\Boot\Test\asm\LCD_Hello_world_test.HEX
