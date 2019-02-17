--  Copyright (C) 2011-2015  Jesus Calvino-Fraga, jesusc (at) ece.ubc.ca
--     
-- This program is free software; you can redistribute it and/or modify it
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

LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY altera_mf;
USE altera_mf.all;

ENTITY SSRAM2 IS
	generic(
		AddrWidth	: integer := 15;
		DataWidth	: integer := 8;
		Inst_Name	: STRING := "ENABLE_RUNTIME_MOD=NO,INSTANCE_NAME=NONE"
	);
	PORT
	(
		address	: IN STD_LOGIC_VECTOR (AddrWidth-1 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (DataWidth-1 DOWNTO 0);
		wren		: IN STD_LOGIC ;
		q		   : OUT STD_LOGIC_VECTOR (DataWidth-1 DOWNTO 0)
	);
END SSRAM2;


ARCHITECTURE SYN OF ssram2 IS

	SIGNAL sub_wire0	: STD_LOGIC_VECTOR (DataWidth-1 DOWNTO 0);

	COMPONENT altsyncram
	GENERIC (
		clock_enable_input_a	   : STRING;
		clock_enable_output_a   : STRING;
		intended_device_family  : STRING;
		lpm_hint                : STRING;
		lpm_type                : STRING;
		numwords_a              : NATURAL;
		operation_mode          : STRING;
		outdata_aclr_a          : STRING;
		outdata_reg_a           : STRING;
		power_up_uninitialized  : STRING;
		widthad_a               : NATURAL;
		width_a                 : NATURAL;
		width_byteena_a         : NATURAL
	);
	PORT (
			address_a	: IN STD_LOGIC_VECTOR (AddrWidth-1 DOWNTO 0);
			clock0	: IN STD_LOGIC ;
			data_a	: IN STD_LOGIC_VECTOR (DataWidth-1 DOWNTO 0);
			wren_a	: IN STD_LOGIC ;
			q_a	: OUT STD_LOGIC_VECTOR (DataWidth-1 DOWNTO 0)
	);
	END COMPONENT;

BEGIN
	q    <= sub_wire0(7 DOWNTO 0);

	altsyncram_component : altsyncram
	GENERIC MAP (
		clock_enable_input_a => "BYPASS",
		clock_enable_output_a => "BYPASS",
		intended_device_family => "Cyclone V",
		lpm_hint => Inst_Name, --lpm_hint => "ENABLE_RUNTIME_MOD=YES,INSTANCE_NAME=R32K",
		lpm_type => "altsyncram",
		numwords_a => 2 ** AddrWidth,--if AddrWidth = 15 then numwords_a => 32768,
		operation_mode => "SINGLE_PORT",
		outdata_aclr_a => "NONE",
		outdata_reg_a => "UNREGISTERED",
		power_up_uninitialized => "FALSE",
		widthad_a => AddrWidth,
		width_a => DataWidth,
		width_byteena_a => 1
	)
	PORT MAP (
		address_a => address,
		clock0 => clock,
		data_a => data,
		wren_a => wren,
		q_a => sub_wire0
	);

END SYN;

