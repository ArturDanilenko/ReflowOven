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

ENTITY CV_Debug IS
	generic(
		tristate  : integer := 1
	);
   PORT (
 		Clk			     : in std_logic;
		Rst_n		     : in std_logic;
		BPC_Sel 		 : in std_logic;
		BPC_Wr  		 : in std_logic;
		BPS_Sel 		 : in std_logic;
		BPS_Wr  		 : in std_logic;
		BPAL_Sel 		 : in std_logic;
		BPAL_Wr  		 : in std_logic;
		BPAH_Sel 		 : in std_logic;
		BPAH_Wr  		 : in std_logic;
		LCall_Addr_L_Sel : in std_logic;
		LCall_Addr_L_Wr  : in std_logic;
		LCall_Addr_H_Sel : in std_logic;
		LCall_Addr_H_Wr  : in std_logic;
		Rep_Addr_L_Sel   : in std_logic;
		Rep_Addr_L_Wr    : in std_logic;
		Rep_Addr_H_Sel   : in std_logic;
		Rep_Addr_H_Wr    : in std_logic;
		Rep_Value_Sel    : in std_logic;
		Rep_Value_Wr     : in std_logic;
		Data_In		     : in std_logic_vector(7 downto 0);
		Data_Out	     : out std_logic_vector(7 downto 0);
		ROM_Addr  		 : in std_logic_vector(15 downto 0);
		LCall_Addr  	 : out std_logic_vector(15 downto 0);
		Rep_Addr 	 	 : out std_logic_vector(15 downto 0);
		Rep_Value 	 	 : out std_logic_vector(7 downto 0);
		BPI              : out std_logic;
		Break_point_out  : out std_logic

   );
END CV_Debug;

architecture rtl of CV_Debug is

	signal	BPC		: std_logic_vector(7 downto 0);  -- Break point control
	signal	BPS		: std_logic_vector(7 downto 0);  -- Break point status
	signal	BPA		: std_logic_vector(15 downto 0); -- Break point address to set
	signal	LCall_Add_r	: std_logic_vector(15 downto 0); -- The address of the service routine for single step and break points
	signal	Rep_Add_r	: std_logic_vector(15 downto 0); -- The address where  Rep_Value_r will be inserted as program memory
	signal	Rep_Value_r	: std_logic_vector(7 downto 0);
	signal	rdaddress	: std_logic_vector(15 downto 0);
	signal	wraddress	: std_logic_vector(15 downto 0);
	signal  Break_State : std_logic;
	signal  Break_State2 : std_logic;

	component CV_DPRAM
		PORT
		(
			clock		: IN STD_LOGIC  := '1';
			data		: IN STD_LOGIC_VECTOR (0 DOWNTO 0);
			rdaddress	: IN STD_LOGIC_VECTOR (14 DOWNTO 0);
			wraddress	: IN STD_LOGIC_VECTOR (14 DOWNTO 0);
			wren		: IN STD_LOGIC  := '0';
			q		    : OUT STD_LOGIC_VECTOR (0 DOWNTO 0)
		);
	end component;

begin

	BreakPointRam : CV_DPRAM port map(
		clock => Clk,
		data  => BPC(0 downto 0),
		rdaddress => rdaddress(14 downto 0), -- The current ROM address
		wraddress => wraddress(14 downto 0), -- The address were we want the break point.
		wren => BPC(1),
		q => BPS(0 downto 0) );
	
	BPS(7) <= BPS(0) and BPC(4);
	Break_point_out <= BPS(0) and BPC(4); -- BPC(4) is the enable breakpoint signal
	BPI <= BPS(6) and (not BPC(6)); -- Only interrupt for single step
	
	rdaddress <= ROM_Addr when BPC(6) = '0' else BPA;
	wraddress <= BPA when BPC(6) = '0' else not BPA;
	
	LCall_Addr <= LCall_Add_r;
	Rep_Addr <= Rep_Add_r;
	Rep_Value <= Rep_Value_r;
	
	-- Register read
	tristate_mux: if tristate/=0 generate
		Data_Out <= BPC when BPC_Sel = '1' else "ZZZZZZZZ";
		Data_Out <= BPS when BPS_Sel = '1' else "ZZZZZZZZ";
		Data_Out <= BPA(7  downto 0) when BPAL_Sel = '1' else "ZZZZZZZZ";
		Data_Out <= BPA(15 downto 8) when BPAH_Sel = '1' else "ZZZZZZZZ";
		Data_Out <= LCall_Add_r(7  downto 0) when LCall_Addr_L_Sel = '1' else "ZZZZZZZZ";
		Data_Out <= LCall_Add_r(15 downto 8) when LCall_Addr_H_Sel = '1' else "ZZZZZZZZ";
		Data_Out <= Rep_Add_r(7  downto 0) when Rep_Addr_L_Sel = '1' else "ZZZZZZZZ";
		Data_Out <= Rep_Add_r(15 downto 8) when Rep_Addr_H_Sel = '1' else "ZZZZZZZZ";
		Data_Out <= Rep_Value_r when Rep_Value_Sel = '1' else "ZZZZZZZZ";
	end generate;
	
	std_mux: if tristate=0 generate
	Data_Out <= BPC when BPC_Sel = '1' else
	            BPS when BPS_Sel = '1' else
	            BPA(7  downto 0) when BPAL_Sel = '1' else
	            BPA(15 downto 8) when BPAH_Sel = '1' else
	            LCall_Add_r(7  downto 0) when LCall_Addr_L_Sel = '1' else
	            LCall_Add_r(15 downto 8) when LCall_Addr_H_Sel = '1' else
				Rep_Add_r(7  downto 0) when Rep_Addr_L_Sel = '1' else
				Rep_Add_r(15 downto 8) when Rep_Addr_H_Sel = '1' else
				Rep_Value_r when Rep_Value_Sel = '1' else
	            (others =>'-');
	end generate;

	process (Rst_n, Clk)
	begin
		if Rst_n = '0' then
			BPA <= (others => '1'); -- Initialize BPA to 0xffff so there is no conflict at reset
			BPC <= (others => '0');
			BPS(5 downto 1) <= (others => '0');
			LCall_Add_r <= X"0033";
			Rep_Add_r <= X"FFFF";
			Rep_Value_r <= X"00";
		elsif Clk'event and Clk = '1' then
			-- Register write
			if BPC_Wr = '1'  then BPC <= Data_In; end if;
			if BPS_Wr = '1'  then BPS(5 downto 1) <= Data_In(5 downto 1); end if; -- Doesn't make much sense to write to the status register, but...
			if BPAL_Wr = '1' then BPA(7  downto 0) <= Data_In; end if;
			if BPAH_Wr = '1' then BPA(15 downto 8) <= Data_In; end if;
			if LCall_Addr_L_Wr = '1' then LCall_Add_r(7  downto 0) <= Data_In; end if;
			if LCall_Addr_H_Wr = '1' then LCall_Add_r(15 downto 8) <= Data_In; end if;
			if Rep_Addr_L_Wr = '1' then Rep_Add_r(7  downto 0) <= Data_In; end if;
			if Rep_Addr_H_Wr = '1' then Rep_Add_r(15 downto 8) <= Data_In; end if;
			if Rep_Value_Wr = '1' then Rep_Value_r <= Data_In; end if;
		end if;
	end process;

	-- Produces a break point after a one byte instruction (reti, for example).  This is used
	-- to implement step-by-step execution.
	process (Rst_n, Clk)
	begin
		if Rst_n = '0' then
			BPS(6) <= '0';
			Break_State2 <= '0';
		elsif Clk'event and Clk = '0' then
			if Break_State2 = '0' then
				if BPC(5) = '1' then
					BPS(6) <= '0';
					Break_State2 <= '1';
				else
					BPS(6) <= '0';
					Break_State2 <= '0';
				end if;
			else
				if BPS_Sel = '1' then -- Reading BPS clears the interrupt flag.
					BPS(6) <= '0';
					Break_State2 <= '0';
				else
					BPS(6) <= '1';
					Break_State2 <= '1';
				end if;
			end if;
		end if;
	end process;
	
end rtl;
