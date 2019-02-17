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

--	This implementation T51_RAM was suggested by user 'rbugalho' in the Altera forum found at
--	http://www.alteraforum.com/forum/showthread.php?t=4766
--	It allows Quartus II to implement the RAM using M4K blocks. This improves the
--	number of LE used (50% of original design) and the compilation speed.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
 
entity T51_RAM is
	generic(
		RAMAddressWidth : integer := 8
	);
	port (
		Clk			: in std_logic;
		Rst_n		: in std_logic;
		ARE			: in std_logic;
		Wr			: in std_logic;
		DIn			: in std_logic_vector(7 downto 0);
		Int_AddrA	: in std_logic_vector(7 downto 0);
		Int_AddrA_r	: out std_logic_vector(7 downto 0);
		Int_AddrB	: in std_logic_vector(7 downto 0);
		Mem_A		: out std_logic_vector(7 downto 0);
		Mem_B		: out std_logic_vector(7 downto 0)
	);
end T51_RAM;

architecture rtl_altera of T51_RAM is

	type RAM_Image is array (2**RAMAddressWidth - 1 downto 0) of std_logic_vector(7 downto 0);
	signal	IRAMA	: RAM_Image := (others => x"00");
 
	signal Int_AddrA_r_i : std_logic_vector(7 downto 0);
	signal Din_r_i       : std_logic_vector(7 downto 0);
	signal fwdToA  		 : std_logic;
	signal fwdToB		 : std_logic;
	
	signal qA            : std_logic_vector(7 downto 0);
	signal qB            : std_logic_vector(7 downto 0);

begin

	process (Clk) begin
		if Clk'event and Clk = '1' then
			if ARE = '1' then
				--if not is_x(Int_AddrA) then -- This generates warnings in Quartus II
				if Int_AddrA /= "ZZZZZZZZ" and  Int_AddrA /= "--------" then 
					qA <= IRAMA(to_integer(unsigned(Int_AddrA)));
				else
					qA <= (others => '-');
				end if;
				-- if not is_x(Int_AddrB) then  -- This generates warnings in Quartus II
				if Int_AddrB /= "ZZZZZZZZ" and  Int_AddrB /= "--------" then 
					qB <= IRAMA(to_integer(unsigned(Int_AddrB)));
				else
					qB <= (others => '-');
				end if;
			end if;

			if Wr = '1' then 
				IRAMA(to_integer(unsigned(Int_AddrA_r_i))) <= DIn;
			end if;
		end if;
	end process;
	  
	process (Clk, Rst_n) begin
		if Rst_n = '0' then 
			Int_AddrA_r_i <= x"00";
			Din_r_i <= x"00";
		else 
			if Clk'event and Clk = '1' then
				Int_AddrA_r_i <= Int_AddrA;
				Din_r_i <= Din;
				
				if Wr = '1' and Int_AddrA = Int_AddrA_r_i then
					fwdToA <= '1';
				else
					fwdToA <= '0';
				end if;
				
				if Wr = '1' and Int_AddrB = Int_AddrA_r_i then
					fwdToB <= '1';
				else
					fwdToB <= '0';
				end if;
			end if;
		end if;
	end process;
	  
	Mem_A	<= qA when fwdToA = '0' else Din_r_i;
	Mem_B	<= qB when fwdToB = '0' else Din_r_i; 
	Int_AddrA_r <= Int_AddrA_r_i;
  
end;