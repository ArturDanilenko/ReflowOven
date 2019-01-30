--  Copyright (C) 2011-2015  Jesus Calvino-Fraga, jesusc (at) ece.ubc.ca
--     
--  This program is free software; you can redistribute it and/or modify it
--	under the terms of the GNU General Public License as published by the
--	Free Software Foundation; either version 2, or (at your option) any
--	later version.
--
--	This program is distributed in the hope that it will be useful,
--	but WITHOUT ANY WARRANTY; without even the implied warranty of
--	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--	GNU General Public License for more details.
--
--	You should have received a copy of the GNU General Public License
--	along with this program; if not, write to the Free Software
--	Foundation, 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

ENTITY Memory_Control IS
	generic(
		tristate  : integer := 1
	);
   PORT (
 		Clk			     : in std_logic;
		Rst_n		     : in std_logic;
		SharedRamReg_Sel : in std_logic;
		SharedRamReg_Wr  : in std_logic;
		Data_In		     : in std_logic_vector(7 downto 0);
		Data_Out	     : out std_logic_vector(7 downto 0);
		SharedRamReg_Out : out std_logic_vector(7 downto 0)
   );
END Memory_Control;

architecture rtl of Memory_Control is

	signal	SharedRamReg		: std_logic_vector(7 downto 0);

begin

	SharedRamReg_Out <= SharedRamReg;
	
	-- Registers
	tristate_mux: if tristate/=0 generate
		Data_Out <= SharedRamReg when SharedRamReg_Sel = '1' else "ZZZZZZZZ";
	end generate;
	
	std_mux: if tristate=0 generate
	Data_Out <= SharedRamReg when SharedRamReg_Sel = '1' else
	            (others =>'-');
	end generate;

	process (Rst_n, Clk)
	begin
		if Rst_n = '0' then
			SharedRamReg <= (others => '1');
		elsif Clk'event and Clk = '1' then
			-- Register write
			if SharedRamReg_Wr = '1' then
				SharedRamReg <= Data_In;
			end if;
		end if;
	end process;

end rtl;
