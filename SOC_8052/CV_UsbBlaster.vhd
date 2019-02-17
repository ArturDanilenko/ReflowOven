--  Copyright (C) 2011  Jesus Calvino-Fraga, jesusc (at) ece.ubc.ca
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

ENTITY USB_BLASTER IS
	generic(
		tristate  : integer := 1
	);
   PORT (
 		Clk			  : in std_logic;
		Rst_n		  : in std_logic;
		JBUF_Sel      : in std_logic;
		JCMD_Sel      : in std_logic;
		JCNT_Sel      : in std_logic;
		JBUF_Wr       : in std_logic;
		JCMD_Wr       : in std_logic;
		JCNT_wr       : in std_logic;
		Data_In		  : in std_logic_vector(7 downto 0);
		Data_Out	  : out std_logic_vector(7 downto 0);
		TDO           : out std_logic;
		TDI           : in std_logic;
		TCS           : in std_logic;
		TCK           : in std_logic
   );
END USB_BLASTER;

architecture rtl of USB_BLASTER is

	signal	TXD		: std_logic_vector(7 downto 0);
	signal	TXD2	: std_logic_vector(7 downto 0);
	signal	RXD		: std_logic_vector(7 downto 0);
	signal	RXD_r	: std_logic_vector(7 downto 0);
	signal	RXD2	: std_logic_vector(7 downto 0);
	signal  JCNT    : std_logic_vector(7 downto 0);
	signal	CMD		: std_logic_vector(7 downto 0);  -- Command status register
	signal  rDATA   : std_logic_vector(7 DOWNTO 0);
	signal  rCont   : std_logic_vector(2 DOWNTO 0);
	signal  tCont   : std_logic_vector(2 DOWNTO 0);
	signal  RX_FIFO_State  : std_logic_vector(1 DOWNTO 0);
	signal  RX_FIFO_State2 : std_logic_vector(2 DOWNTO 0);
	signal  TX_FIFO_State  : std_logic_vector(1 DOWNTO 0);
	signal  TX_FIFO_State2 : std_logic_vector(1 DOWNTO 0);
	signal  JTAG_in : std_logic;
	signal  JTAG_out : std_logic;
	signal  wrreq   : std_logic;
	signal  rdreq   : std_logic;
	signal  rdempty : std_logic;
	signal  tx_wrreq   : std_logic;
	signal  tx_rdreq   : std_logic;
	signal  tx_rdempty : std_logic;
	signal  tx_full : std_logic;
	signal  rx_full : std_logic;

	component CV_Fifo
		PORT
		(
			aclr	: IN STD_LOGIC ;
			clock	: IN STD_LOGIC ;
			data	: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
			rdreq	: IN STD_LOGIC ;
			wrreq	: IN STD_LOGIC ;
			almost_full		: OUT STD_LOGIC ;
			empty	: OUT STD_LOGIC ;
			q		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
		);
	end component;

begin

	RXFIFO : CV_Fifo port map(
		aclr => not Rst_n,
		data => RXD_r,
		clock => Clk,
		rdreq => rdreq,
		wrreq => wrreq,
		almost_full => rx_full,
		empty => rdempty,
		q => RXD2);

	TXFIFO : CV_Fifo port map(
		aclr => not Rst_n,
		data => TXD,
		clock => Clk,
		rdreq => tx_rdreq and CMD(3) and (not tx_rdempty), -- See below how the wrreq (for reception) is generated
		wrreq => tx_wrreq,
		almost_full => tx_full,
		empty => tx_rdempty,
		q => TXD2);
		
	-- Registers
	tristate_mux: if tristate/=0 generate
		Data_Out <= RXD2 when JBUF_Sel = '1' else "ZZZZZZZZ";
		Data_Out <= JCNT when JCNT_Sel = '1' else "ZZZZZZZZ";
		Data_Out <= CMD  when JCMD_Sel = '1' else "ZZZZZZZZ";
	end generate;
	
	std_mux: if tristate=0 generate
	Data_Out <= RXD2 when JBUF_Sel = '1' else
	            CMD  when JCMD_Sel = '1' else
	            JCNT when JCNT_Sel = '1' else
	            (others =>'-');
	end generate;
	
	CMD(7) <= TCS;
	CMD(6) <= tx_rdempty;
	CMD(5) <= rx_full;
	CMD(4) <= tx_full;
	CMD(0) <= not rdempty;
	
	process (Rst_n, Clk)
	begin
		if Rst_n = '0' then
			TXD <= (others => '0');
			JCNT <= (others => '0');
			CMD(2) <= '0';  -- Rx Enable
			CMD(3) <= '0';  -- Tx enable
		elsif Clk'event and Clk = '1' then
			-- Register write
			if JBUF_Wr = '1' then
				TXD <= Data_In;
			end if;
			if JCNT_Wr = '1' then
				JCNT <= Data_In;
			end if;
			if JCMD_Wr = '1' then
				CMD(2) <= Data_In(2);  -- Rx Enable
				CMD(3) <= Data_In(3);  -- Tx enable
			end if;
		end if;
	end process;

    -- JTAG reception: this procces captures each individual bit from the blaster port.
	process (TCK)
	begin
		if (TCK'event and TCK = '1') then
			--for i in 0 to 7 loop
			--	if ( rCont = i ) then RXD(i)<=TDI; end if;
			--end loop;
			if    ( rCont = "000" ) then RXD(0)<=TDI;
			elsif ( rCont = "001" ) then RXD(1)<=TDI;
			elsif ( rCont = "010" ) then RXD(2)<=TDI;
			elsif ( rCont = "011" ) then RXD(3)<=TDI;
			elsif ( rCont = "100" ) then RXD(4)<=TDI;
			elsif ( rCont = "101" ) then RXD(5)<=TDI;
			elsif ( rCont = "110" ) then RXD(6)<=TDI;
			elsif ( rCont = "111" ) then RXD(7)<=TDI;
			end if;
		end if;
	end process;
	
    -- JTAG reception: this procces manages the receive counter and saves a completed byte
    -- using a register before storing it into the FIFO.
	process (Rst_n, TCK, CMD(2))
	begin
		if (Rst_n = '0') or (CMD(2) = '0') then -- CMD(2) is the receive enable signal
		  JTAG_in <= '0';
		  JTAG_out <= '0';
		  rCont <= (others => '0');
		elsif (TCK'event and TCK = '1') then
			rCont <= rCont + 1;
			if ( rCont = "111" ) then
				if RXD /= "00000000" then 
					JTAG_in <= '1'; -- Only write to receive FIFO if the received character is not 0x00
					JTAG_out <= '0';
					RXD_r <= RXD;
				else
					JTAG_in <= '0';
					JTAG_out <= '1'; -- Only read from transmit FIFO if the received character is 0x00
				end if;
			else
				JTAG_in <= '0';
				JTAG_out <= '0';
			end if;
		end if;
	end process;
	
	--This process is used to store the received data from the USB-Blaster into a FIFO using the wrreq signal.
	process (Rst_n, Clk)
	begin
		if (Rst_n = '0') then
			RX_FIFO_State <= "00";
			wrreq <= '0';
		elsif (Clk'event and Clk = '0') then
			case RX_FIFO_State is
				when "00" =>
					if JTAG_in = '1' then
						RX_FIFO_State<="01";
					else
						RX_FIFO_State<="00";
					end if;
					wrreq <= '0'; 
				when "01" =>
					wrreq <= '1'; -- Write to FIFO
					RX_FIFO_State<="10";
				when "10" =>
					wrreq <= '0';
					if JTAG_in = '1' then
						RX_FIFO_State <= "10";
					else
						RX_FIFO_State <= "00";
					end if;
				when "11" =>
					RX_FIFO_State <= "00";
			end case;
		end if;
	end process;

	-- This process is used to acknowledge data from the FIFO and increment the FIFO counter.  Notice that
	-- JBUF_Sel is asserted twice for each individual read of JBUF.  Make sure rdreq=0 when JBUF_Wr=1
	process (Rst_n, Clk)
	begin
		if (Rst_n = '0') then
			RX_FIFO_State2 <= (others => '0');
			rdreq <= '0';
		elsif (Clk'event and Clk = '0') then
			case RX_FIFO_State2 is
				when "000" =>
					rdreq <= '0';
					if JBUF_Wr = '1' then
						RX_FIFO_State2 <= "000";
					elsif JBUF_Sel = '1' then
						RX_FIFO_State2 <= "001";
					else
						RX_FIFO_State2 <= "000";
					end if;
				when "001" =>
					rdreq <= '0';
					if JBUF_Wr = '1' then
						RX_FIFO_State2 <= "000";
					elsif JBUF_Sel = '1' then
						RX_FIFO_State2 <= "001";
					else
						RX_FIFO_State2 <= "010";
					end if;
				when "010" =>
					rdreq <= '0';
					if JBUF_Wr = '1' then
						RX_FIFO_State2 <= "000";
					elsif JBUF_Sel = '1' then
						RX_FIFO_State2 <= "011";
					else
						RX_FIFO_State2 <= "010";
					end if;
				when "011" =>
					rdreq <= '0';
					if JBUF_Wr = '1' then
						RX_FIFO_State2 <= "000";
					elsif JBUF_Sel = '1' then
						RX_FIFO_State2 <= "011";
					else
						RX_FIFO_State2 <= "100";
					end if;
				when others =>
					if JBUF_Wr = '1' then
						rdreq <= '0';
					else
						rdreq <= '1';
					end if;
					RX_FIFO_State2 <= "000";
			end case;
		end if;
	end process;

	--This process is used to generate the wrreq signal for the transmit FIFO.
	process (Rst_n, Clk)
	begin
		if (Rst_n = '0') then
			TX_FIFO_State <= "00";
			tx_wrreq <= '0';
		elsif (Clk'event and Clk = '0') then
			case TX_FIFO_State is
				when "00" =>
					if JBUF_Wr = '1' then
						TX_FIFO_State<="01";
					else
						TX_FIFO_State<="00";
					end if;
					tx_wrreq <= '0'; 
				when "01" =>
					tx_wrreq <= '1'; -- Write to FIFO
					TX_FIFO_State<="10";
				when "10" =>
					tx_wrreq <= '0';
					if JBUF_Wr = '1' then
						TX_FIFO_State <= "10";
					else
						TX_FIFO_State <= "00";
					end if;
				when "11" =>
					TX_FIFO_State <= "00";
			end case;
		end if;
	end process;

	process (Rst_n, Clk)
	begin
		if (Rst_n = '0') then
			TX_FIFO_State2 <= "00";
			tx_rdreq <= '0';
		elsif (Clk'event and Clk = '0') then
			case TX_FIFO_State2 is
				when "00" =>
					if JTAG_out = '1' then
						TX_FIFO_State2<="01";
					else
						TX_FIFO_State2<="00";
					end if;
					tx_rdreq <= '0'; 
				when "01" =>
					tx_rdreq <= '1'; -- Write to FIFO
					TX_FIFO_State2<="10";
				when "10" =>
					tx_rdreq <= '0';
					if JTAG_out = '1' then
						TX_FIFO_State2 <= "10";
					else
						TX_FIFO_State2 <= "00";
					end if;
				when "11" =>
					TX_FIFO_State2 <= "00";
			end case;
		end if;
	end process;

   -- JTAG transmission.  Reads/transmits from the FIFO only when is not empty.  Otherwise, sends a 0x00.
   process (Rst_n, TCK, CMD(3))
   begin
      if (Rst_n = '0') or (CMD(3) = '0') then -- CMD(3) is the transmmit enable signal
         CMD(1) <= '0';  -- TX ready signal
         tCont <= "000";
         TDO <= '0';
      elsif (TCK'event and TCK = '1') then
		CMD(1) <= '1';
		tCont <= tCont + "001";
		if    ( tCont = "000" ) then TDO<=TXD2(0) and (not tx_rdempty);
		elsif ( tCont = "001" ) then TDO<=TXD2(1) and (not tx_rdempty);
		elsif ( tCont = "010" ) then TDO<=TXD2(2) and (not tx_rdempty);
		elsif ( tCont = "011" ) then TDO<=TXD2(3) and (not tx_rdempty);
		elsif ( tCont = "100" ) then TDO<=TXD2(4) and (not tx_rdempty);
		elsif ( tCont = "101" ) then TDO<=TXD2(5) and (not tx_rdempty);
		elsif ( tCont = "110" ) then TDO<=TXD2(6) and (not tx_rdempty);
		elsif ( tCont = "111" ) then TDO<=TXD2(7) and (not tx_rdempty);
		end if;
      end if;
   end process;
	
end rtl;	

