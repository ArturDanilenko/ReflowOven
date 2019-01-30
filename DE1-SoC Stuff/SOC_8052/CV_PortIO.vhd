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

entity CV_PortIO is
	generic(
		tristate  : integer := 1
	);
	port(
		Clk       : in std_logic;
		Rst_n     : in std_logic;
		Port_Sel  : in std_logic;
		Mode_Sel  : in std_logic;
		Port_Wr   : in std_logic;
		Mode_Wr   : in std_logic;
		Data_In   : in std_logic_vector(7 downto 0);
		Data_Out  : out std_logic_vector(7 downto 0);
		IOPort    : inout std_logic_vector(7 downto 0)
	);
end CV_PortIO;

architecture rtl of CV_PortIO is 
	signal Port_Output : std_logic_vector(7 downto 0);
	signal Port_Input  : std_logic_vector(7 downto 0);
	signal Port_Mode   : std_logic_vector(7 downto 0);

begin

	tristate_mux: if tristate/=0 generate
		Data_Out <= Port_Input when Port_Sel = '1' else (others =>'Z');
		Data_Out <= Port_Mode  when Mode_Sel = '1' else (others =>'Z');
	end generate;
	
	std_mux: if tristate=0 generate
		Data_Out <= Port_Input when Port_Sel = '1' else 
					Port_Mode  when Mode_Sel = '1' else 
					(others =>'-');
	end generate;
  
	Z10iop: for i in 0 to 7 generate
		IOPort(i) <= Port_Output(i) when Port_Mode(i) = '1' else 'Z';
		Port_Input(i) <= To_X01Z(IOPort(i)) when Port_Mode(i) = '0' else Port_Output(i);
	end generate;

	process (Rst_n, Clk)
	begin
		if Rst_n = '0' then
			Port_Output <= (others =>'1');
			Port_Mode   <= (others =>'0'); -- Default port to all pins as inputs
		elsif Clk'event and Clk = '1' then
			if Port_Wr = '1' then
				Port_Output <= Data_In;
			end if;
			if Mode_Wr = '1' then
				Port_Mode <= Data_In;
			end if;
		end if;
	end process;

end;
