--
-- 8052 compatible microcontroller
--
-- Version : 0300
--
-- Copyright (c) 2001-2002 Daniel Wallner (jesus@opencores.org)
--           (c) 2004-2005 Andreas Voggeneder (andreas.voggeneder@fh-hagenberg.at)
--
-- All rights reserved
--
-- Redistribution and use in source and synthezised forms, with or without
-- modification, are permitted provided that the following conditions are met:
--
-- Redistributions of source code must retain the above copyright notice,
-- this list of conditions and the following disclaimer.
--
-- Redistributions in synthesized form must reproduce the above copyright
-- notice, this list of conditions and the following disclaimer in the
-- documentation and/or other materials provided with the distribution.
--
-- Neither the name of the author nor the names of other contributors may
-- be used to endorse or promote products derived from this software without
-- specific prior written permission.
--
-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
-- AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
-- THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
-- PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE
-- LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
-- CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
-- SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
-- INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
-- CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
-- ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
-- POSSIBILITY OF SUCH DAMAGE.
--
-- Please report bugs to the author, but before you do so, please
-- make sure that this is not a derivative work and that
-- you have the latest version of this file.
--
-- The latest version of this file can be found at:
--  http://www.opencores.org/cvsweb.shtml/t51/
--
-- Limitations :
--
-- File history :
--

library IEEE;
use IEEE.std_logic_1164.all;
use work.T51_Pack.all;

entity T51_Glue is
  generic(
    tristate  : integer := 1
  );
  port(
    Clk     : in std_logic;
    Rst_n   : in std_logic;
    INT0    : in std_logic;
    INT1    : in std_logic;
    RI      : in std_logic;
    TI      : in std_logic;
    OF0     : in std_logic;
    OF1     : in std_logic;
    OF2     : in std_logic;
    BPI     : in std_logic;
    IO_Wr   : in std_logic;
    IO_Addr   : in std_logic_vector(6 downto 0);
    IO_Addr_r : in std_logic_vector(6 downto 0);
    IO_WData  : in std_logic_vector(7 downto 0);
    IO_RData  : out std_logic_vector(7 downto 0);
    Selected  : out std_logic;
    Int_Acc   : in std_logic_vector(6 downto 0);    -- Acknowledge
    R0      : out std_logic;
    R1      : out std_logic;
    SMOD    : out std_logic;
    P0_Sel    : out std_logic;
    P1_Sel    : out std_logic;
    P2_Sel    : out std_logic;
    P3_Sel    : out std_logic;
    HEX0_Sel    : out std_logic;
    HEX1_Sel    : out std_logic;
    HEX2_Sel    : out std_logic;
    HEX3_Sel    : out std_logic;
    HEX4_Sel    : out std_logic;
    HEX5_Sel    : out std_logic;
    HEX6_Sel    : out std_logic;
    HEX7_Sel    : out std_logic;
    LEDR0_Sel   : out std_logic;
    LEDR1_Sel   : out std_logic;
    LEDR2_Sel   : out std_logic;
    KEY_Sel    : out std_logic;
    TMOD_Sel  : out std_logic;
    TL0_Sel   : out std_logic;
    TL1_Sel   : out std_logic;
    TH0_Sel   : out std_logic;
    TH1_Sel   : out std_logic;
    T2CON_Sel : out std_logic;
    RCAP2L_Sel  : out std_logic;
    RCAP2H_Sel  : out std_logic;
    TL2_Sel   : out std_logic;
    TH2_Sel   : out std_logic;
    SCON_Sel  : out std_logic;
    SBUF_Sel  : out std_logic;
	JBUF_Sel  : out std_logic;
	JCMD_Sel  : out std_logic;
 	JCNT_Sel  : out std_logic;
 	P0MOD_Sel  : out std_logic;
 	P1MOD_Sel  : out std_logic;
 	P2MOD_Sel  : out std_logic;
 	P3MOD_Sel  : out std_logic;
 	SharedRamReg_Sel  : out std_logic;
 	BPC_Sel 	: out std_logic;
	BPS_Sel 	: out std_logic;
	BPAL_Sel 	: out std_logic;
	BPAH_Sel 	: out std_logic;
	LCall_Addr_L_Sel : out std_logic;
	LCall_Addr_H_Sel : out std_logic;
	Rep_Addr_L_Sel   : out std_logic;
	Rep_Addr_H_Sel   : out std_logic;
	Rep_Value_Sel    : out std_logic;
	LCD_CMD_Sel    : out std_logic;
	LCD_DAT_Sel    : out std_logic;
	LCD_MOD_Sel    : out std_logic;
	FLASH_CMD_Sel    : out std_logic;
	FLASH_DAT_Sel    : out std_logic;
	FLASH_MOD_Sel    : out std_logic;
	FLASH_ADD0_Sel    : out std_logic;
	FLASH_ADD1_Sel    : out std_logic;
	FLASH_ADD2_Sel    : out std_logic;

    P0_Wr   : out std_logic;
    P1_Wr   : out std_logic;
    P2_Wr   : out std_logic;
    P3_Wr   : out std_logic;
    HEX0_Wr   : out std_logic;
    HEX1_Wr   : out std_logic;
    HEX2_Wr   : out std_logic;
    HEX3_Wr   : out std_logic;
    HEX4_Wr   : out std_logic;
    HEX5_Wr   : out std_logic;
    HEX6_Wr   : out std_logic;
    HEX7_Wr   : out std_logic;
    LEDR0_Wr  : out std_logic;
    LEDR1_Wr  : out std_logic;
    LEDR2_Wr  : out std_logic;
    KEY_Wr   : out std_logic;
    TMOD_Wr   : out std_logic;
    TL0_Wr    : out std_logic;
    TL1_Wr    : out std_logic;
    TH0_Wr    : out std_logic;
    TH1_Wr    : out std_logic;
    T2CON_Wr  : out std_logic;
    RCAP2L_Wr : out std_logic;
    RCAP2H_Wr : out std_logic;
    TL2_Wr    : out std_logic;
    TH2_Wr    : out std_logic;
    SCON_Wr   : out std_logic;
    SBUF_Wr   : out std_logic;
	JBUF_Wr   : out std_logic;
	JCMD_Wr   : out std_logic;
	JCNT_Wr   : out std_logic;
	P0MOD_Wr  : out std_logic;
	P1MOD_Wr  : out std_logic;
	P2MOD_Wr  : out std_logic;
	P3MOD_Wr  : out std_logic;
  	SharedRamReg_Wr  : out std_logic;
    BPC_Wr 	: out std_logic;
	BPS_Wr 	: out std_logic;
	BPAL_Wr : out std_logic;
	BPAH_Wr : out std_logic;
	LCall_Addr_L_Wr  : out std_logic;
	LCall_Addr_H_Wr  : out std_logic;
	Rep_Addr_L_Wr    : out std_logic;
	Rep_Addr_H_Wr    : out std_logic;
	Rep_Value_Wr     : out std_logic;
	LCD_CMD_Wr    : out std_logic;
	LCD_DAT_Wr    : out std_logic;
	LCD_MOD_Wr    : out std_logic;
	FLASH_CMD_Wr    : out std_logic;
	FLASH_DAT_Wr    : out std_logic;
	FLASH_MOD_Wr    : out std_logic;
	FLASH_ADD0_Wr    : out std_logic;
	FLASH_ADD1_Wr    : out std_logic;
	FLASH_ADD2_Wr    : out std_logic;
    Int_Trig  : out std_logic_vector(6 downto 0)
  );
end T51_Glue;

architecture rtl of T51_Glue is

  signal  IE      : std_logic_vector(7 downto 0);
  signal  TCON    : std_logic_vector(7 downto 0);
  signal  PCON    : std_logic_vector(7 downto 0);

  signal  Int0_r    : std_logic_vector(1 downto 0);
  signal  Int1_r    : std_logic_vector(1 downto 0);

begin

  R0 <= TCON(4);
  R1 <= TCON(6);
  SMOD <= PCON(7);

  -- Registers/Interrupts
  tristate_mux: if tristate/=0 generate
    IO_RData <= TCON when IO_Addr = "0001000" else "ZZZZZZZZ"; -- $88 TCON
    IO_RData <= PCON when IO_Addr = "0000111" else "ZZZZZZZZ"; -- $87 TCON
    IO_RData <= IE when IO_Addr = "0101000" else "ZZZZZZZZ";
    Selected <= '0';
  end generate;
  
  std_mux: if tristate=0 generate
    IO_RData <= TCON when IO_Addr = "0001000" else 
                PCON when IO_Addr = "0000111" else
                IE when IO_Addr = "0101000" else 
                (others =>'-');
    Selected <= '1' when IO_Addr = "0001000" or 
                         IO_Addr = "0000111" or
                         IO_Addr = "0101000" else
                '0';
  end generate;
  
  process (Rst_n, Clk)
  begin
    if Rst_n = '0' then
      IE   <= "00000000";
      TCON <= "00000000";
      PCON <= "00000000";
      Int0_r <= "11";
      Int1_r <= "11";
    elsif Clk'event and Clk = '1' then
      Int0_r(0) <= INT0;
      Int0_r(1) <= Int0_r(0);
      Int1_r(0) <= INT1;
      Int1_r(1) <= Int1_r(0);
 
      if IO_Wr = '1' and IO_Addr_r = "0101000" then
        IE <= IO_WData;
      end if;

      if IO_Wr = '1' and IO_Addr_r = "0001000" then
        TCON <= IO_WData;
      end if;

      if IO_Wr = '1' and IO_Addr_r = "0000111" then
        PCON <= IO_WData;
      end if;

      if OF0 = '1' then
        TCON(5) <= '1';
      end if;
      if Int_Acc(1) = '1' then
        TCON(5) <= '0';
      end if;
      if OF1 = '1' then
        TCON(7) <= '1';
      end if;
      if Int_Acc(3) = '1' then
        TCON(7) <= '0';
      end if;

      -- External interrupts
      if TCON(0) = '1' then
        if Int_Acc(0) = '1' then
          TCON(1) <= '0';
        end if;
        if Int0_r = "10" then
          TCON(1) <= '1';
        end if;
      else
        TCON(1) <= not Int0_r(0);
      end if;
      if TCON(2) = '1' then
        if Int_Acc(2) = '1' then
          TCON(3) <= '0';
        end if;
        if Int1_r = "10" then
          TCON(3) <= '1';
        end if;
      else
        TCON(3) <= not Int1_r(0);
      end if;
    end if;
  end process;

  Int_Trig(0) <= '0' when IE(7) = '0' or IE(0) = '0' else not Int0_r(1) when TCON(0) = '0' else TCON(1);
  Int_Trig(1) <= '1' when IE(7) = '1' and IE(1) = '1' and TCON(5) = '1' else '0';
  Int_Trig(2) <= '0' when IE(7) = '0' or IE(2) = '0' else not Int1_r(1) when TCON(2) = '0' else TCON(3);
  Int_Trig(3) <= '1' when IE(7) = '1' and IE(3) = '1' and TCON(7) = '1' else '0';
  Int_Trig(4) <= '1' when IE(7) = '1' and IE(4) = '1' and (RI = '1' or TI = '1') else '0';
  Int_Trig(5) <= '1' when IE(7) = '1' and IE(5) = '1' and OF2 = '1' else '0';
  Int_Trig(6) <= '1' when BPI = '1' else '0'; -- Single step interrupt is non IE maskable.  Use BPC instead

  -- 0x80 : P0
  P0_Sel <= '1' when IO_Addr = "0000000" else '0';
  P0_Wr <= '1' when IO_Addr_r = "0000000" and IO_Wr = '1' else '0';
  -- 0x81 : SP
  -- 0x82 : DPL
  -- 0x83 : DPH
  -- 0x84 : DPL1 (?)
  -- 0x85 : DPH1 (?)
  -- 0x86 : DPS (?)
  -- 0x87 : PCON
  -- 0x88 : TCON
  -- 0x89 : TMOD
  TMOD_Sel <= '1' when IO_Addr = "0001001" else '0';
  TMOD_Wr <= '1' when IO_Addr_r = "0001001" and IO_Wr = '1' else '0';
  -- 0x8A : TL0
  TL0_Sel <= '1' when IO_Addr = "0001010" else '0';
  TL0_Wr <= '1' when IO_Addr_r = "0001010" and IO_Wr = '1' else '0';
  -- 0x8B : TL1
  TL1_Sel <= '1' when IO_Addr = "0001011" else '0';
  TL1_Wr <= '1' when IO_Addr_r = "0001011" and IO_Wr = '1' else '0';
  -- 0x8C : TH0
  TH0_Sel <= '1' when IO_Addr = "0001100" else '0';
  TH0_Wr <= '1' when IO_Addr_r = "0001100" and IO_Wr = '1' else '0';
  -- 0x8D : TH1
  TH1_Sel <= '1' when IO_Addr = "0001101" else '0';
  TH1_Wr <= '1' when IO_Addr_r = "0001101" and IO_Wr = '1' else '0';
  -- 0x8E : HEX4
  HEX4_Sel <= '1' when IO_Addr = "0001110" else '0';
  HEX4_Wr <= '1' when IO_Addr_r = "0001110" and IO_Wr = '1' else '0';
  -- 0x8F : HEX5
  HEX5_Sel <= '1' when IO_Addr = "0001111" else '0';
  HEX5_Wr <= '1' when IO_Addr_r = "0001111" and IO_Wr = '1' else '0';
  -- 0x90 : P1
  P1_Sel <= '1' when IO_Addr = "0010000" else '0';
  P1_Wr <= '1' when IO_Addr_r = "0010000" and IO_Wr = '1' else '0';
  -- 0x91 : HEX0
  HEX0_Sel <= '1' when IO_Addr = "0010001" else '0';
  HEX0_Wr <= '1' when IO_Addr_r = "0010001" and IO_Wr = '1' else '0';
  -- 0x92 : HEX1
  HEX1_Sel <= '1' when IO_Addr = "0010010" else '0';
  HEX1_Wr <= '1' when IO_Addr_r = "0010010" and IO_Wr = '1' else '0';
  -- 0x93 : HEX2
  HEX2_Sel <= '1' when IO_Addr = "0010011" else '0';
  HEX2_Wr <= '1' when IO_Addr_r = "0010011" and IO_Wr = '1' else '0';
  -- 0x94 : HEX3
  HEX3_Sel <= '1' when IO_Addr = "0010100" else '0';
  HEX3_Wr <= '1' when IO_Addr_r = "0010100" and IO_Wr = '1' else '0';
  -- 0x95 : LEDR1 
  LEDR1_Sel <= '1' when IO_Addr = "0010101" else '0';
  LEDR1_Wr <= '1' when IO_Addr_r = "0010101" and IO_Wr = '1' else '0';
  -- 0x96 : HEX6
  HEX6_Sel <= '1' when IO_Addr = "0010110" else '0';
  HEX6_Wr <= '1' when IO_Addr_r = "0010110" and IO_Wr = '1' else '0';
  -- 0x97 : HEX7
  HEX7_Sel <= '1' when IO_Addr = "0010111" else '0';
  HEX7_Wr <= '1' when IO_Addr_r = "0010111" and IO_Wr = '1' else '0';
  -- 0x98 : SCON
  SCON_Sel <= '1' when IO_Addr = "0011000" else '0';
  SCON_Wr <= '1' when IO_Addr_r = "0011000" and IO_Wr = '1' else '0';
  -- 0x99 : SBUF
  SBUF_Sel <= '1' when IO_Addr = "0011001" else '0';
  SBUF_Wr <= '1' when IO_Addr_r = "0011001" and IO_Wr = '1' else '0';
  -- 0x9A : P0MOD
  P0MOD_Sel <= '1' when IO_Addr = "0011010" else '0';
  P0MOD_Wr <= '1'  when IO_Addr_r = "0011010" and IO_Wr = '1' else '0';
  -- 0x9B : P1MOD
  P1MOD_Sel <= '1' when IO_Addr = "0011011" else '0';
  P1MOD_Wr <= '1'  when IO_Addr_r = "0011011" and IO_Wr = '1' else '0';
  -- 0x9C : P2MOD
  P2MOD_Sel <= '1' when IO_Addr = "0011100" else '0';
  P2MOD_Wr <= '1'  when IO_Addr_r = "0011100" and IO_Wr = '1' else '0';
  -- 0x9D : P3MOD
  P3MOD_Sel <= '1' when IO_Addr = "0011101" else '0';
  P3MOD_Wr <= '1'  when IO_Addr_r = "0011101" and IO_Wr = '1' else '0';
  -- 0x9E : LEDR2
  LEDR2_Sel <= '1' when IO_Addr = "0011110" else '0';
  LEDR2_Wr <= '1' when IO_Addr_r = "0011110" and IO_Wr = '1' else '0';
  -- 0x9F : AVAILABLE
  -- 0xA0 : P2
  P2_Sel <= '1' when IO_Addr = "0100000" else '0';
  P2_Wr <= '1' when IO_Addr_r = "0100000" and IO_Wr = '1' else '0';
  -- 0xA1 : AVAILABLE
  -- 0xA2 : AVAILABLE
  -- 0xA3 : AVAILABLE
  -- 0xA4 : AVAILABLE
  -- 0xA5 : AVAILABLE
  -- 0xA6 : AVAILABLE
  -- 0xA7 : AVAILABLE
  -- 0xA8 : IE
  -- 0xA9 : AVAILABLE
  -- 0xAA : AVAILABLE
  -- 0xAB : AVAILABLE
  -- 0xAC : AVAILABLE
  -- 0xAD : AVAILABLE
  -- 0xAE : AVAILABLE
  -- 0xAF : AVAILABLE
  -- 0xB0 : P3 
  P3_Sel <= '1' when IO_Addr = "0110000" else '0';
  P3_Wr <= '1' when IO_Addr_r = "0110000" and IO_Wr = '1' else '0';
  -- 0xB1 : AVAILABLE
  -- 0xB2 : AVAILABLE
  -- 0xB3 : AVAILABLE
  -- 0xB4 : AVAILABLE
  -- 0xB5 : AVAILABLE
  -- 0xB6 : AVAILABLE
  -- 0xB7 : AVAILABLE
  -- 0xB8 : IP
  -- 0xB9 : AVAILABLE
  -- 0xBA : AVAILABLE
  -- 0xBB : AVAILABLE
  -- 0xBC : AVAILABLE
  -- 0xBD : AVAILABLE
  -- 0xBE : AVAILABLE
  -- 0xBF : AVAILABLE
  -- 0xC0 : JCMD
  JCMD_Sel <= '1' when IO_Addr = "1000000" else '0';
  JCMD_Wr <= '1' when IO_Addr_r = "1000000" and IO_Wr = '1' else '0';
  -- 0xC1 : JBUF
  JBUF_Sel <= '1' when IO_Addr = "1000001" else '0';
  JBUF_Wr <= '1' when IO_Addr_r = "1000001" and IO_Wr = '1' else '0';
  -- 0xC2 : JCNT
  JCNT_Sel <= '1' when IO_Addr = "1000010" else '0';
  JCNT_Wr <= '1' when IO_Addr_r = "1000010" and IO_Wr = '1' else '0';
  -- 0xC3 : SHARED_START  Where the VonNeumann memory starts
  SharedRamReg_Sel <= '1' when IO_Addr = "1000011" else '0';
  SharedRamReg_Wr <= '1' when IO_Addr_r = "1000011" and IO_Wr = '1' else '0';
  -- 0xC4 : AVAILABLE
  -- 0xC5 : AVAILABLE
  -- 0xC6 : AVAILABLE
  -- 0xC7 : AVAILABLE
  -- 0xC8 : T2CON 
  T2CON_Sel <= '1' when IO_Addr = "1001000" else '0';
  T2CON_Wr <= '1' when IO_Addr_r = "1001000" and IO_Wr = '1' else '0';
  -- 0xC9 : T2MOD (Not used here?)
  -- 0xCA : TCAP2L
  RCAP2L_Sel <= '1' when IO_Addr = "1001010" else '0';
  RCAP2L_Wr <= '1' when IO_Addr_r = "1001010" and IO_Wr = '1' else '0';
  -- 0xCB : RCAP2H
  RCAP2H_Sel <= '1' when IO_Addr = "1001011" else '0';
  RCAP2H_Wr <= '1' when IO_Addr_r = "1001011" and IO_Wr = '1' else '0';
  -- 0xCC : TL2
  TL2_Sel <= '1' when IO_Addr = "1001100" else '0';
  TL2_Wr <= '1' when IO_Addr_r = "1001100" and IO_Wr = '1' else '0';
  -- 0xCD : TH2
  TH2_Sel <= '1' when IO_Addr = "1001101" else '0';
  TH2_Wr <= '1' when IO_Addr_r = "1001101" and IO_Wr = '1' else '0';
  -- 0xCE : AVAILABLE
  -- 0xCF : AVAILABLE
  -- 0xD0 : PSW
  -- 0xD1 : AVAILABLE
  -- 0xD2 : AVAILABLE
  -- 0xD3 : AVAILABLE
  -- 0xD4 : AVAILABLE
  -- 0xD5 : AVAILABLE
  -- 0xD6 : AVAILABLE
  -- 0xD7 : AVAILABLE
  -- 0xD8 : LCD_CMD
  LCD_CMD_Sel <= '1' when IO_Addr = "1011000" else '0';
  LCD_CMD_Wr <= '1' when IO_Addr_r = "1011000" and IO_Wr = '1' else '0';
  -- 0xD9 : LCD_DATA
  LCD_DAT_Sel <= '1' when IO_Addr = "1011001" else '0';
  LCD_DAT_Wr <= '1' when IO_Addr_r = "1011001" and IO_Wr = '1' else '0';
  -- 0xDA : LCD_MOD
  LCD_MOD_Sel <= '1' when IO_Addr = "1011010" else '0';
  LCD_MOD_Wr <= '1' when IO_Addr_r = "1011010" and IO_Wr = '1' else '0';
  -- 0xDB : FLASH CMD
  FLASH_CMD_Sel <= '1' when IO_Addr = "1011011" else '0';
  FLASH_CMD_Wr <= '1' when IO_Addr_r = "1011011" and IO_Wr = '1' else '0';
  -- 0xDC : FLASH_DATA
  FLASH_DAT_Sel <= '1' when IO_Addr = "1011100" else '0';
  FLASH_DAT_Wr <= '1' when IO_Addr_r = "1011100" and IO_Wr = '1' else '0';
  -- 0xDD : FLASH_MOD
  FLASH_MOD_Sel <= '1' when IO_Addr = "1011101" else '0';
  FLASH_MOD_Wr <= '1' when IO_Addr_r = "1011101" and IO_Wr = '1' else '0';
  -- 0xDE : AVAILABLE
  -- 0xDF : AVAILABLE
  -- 0xE0 : ACC
  -- 0xE1 : FLASH ADD0
  FLASH_ADD0_Sel <= '1' when IO_Addr = "1100001" else '0';
  FLASH_ADD0_Wr <= '1' when IO_Addr_r = "1100001" and IO_Wr = '1' else '0';
  -- 0xE2 : FLASH ADD1
  FLASH_ADD1_Sel <= '1' when IO_Addr = "1100010" else '0';
  FLASH_ADD1_Wr <= '1' when IO_Addr_r = "1100010" and IO_Wr = '1' else '0';
  -- 0xE3 : FLASH ADD2
  FLASH_ADD2_Sel <= '1' when IO_Addr = "1100011" else '0';
  FLASH_ADD2_Wr <= '1' when IO_Addr_r = "1100011" and IO_Wr = '1' else '0';
  -- 0xE4 : AVAILABLE
  -- 0xE5 : AVAILABLE
  -- 0xE6 : AVAILABLE
  -- 0xE7 : AVAILABLE
  -- 0xE8 : LEDR0
  LEDR0_Sel <= '1' when IO_Addr = "1101000" else '0';
  LEDR0_Wr <= '1' when IO_Addr_r = "1101000" and IO_Wr = '1' else '0';
  -- 0xE9 : AVAILABLE
  -- 0xEA : AVAILABLE
  -- 0xEB : AVAILABLE
  -- 0xEC : AVAILABLE
  -- 0xED : AVAILABLE
  -- 0xEE : AVAILABLE
  -- 0xEF : AVAILABLE
  -- 0xF0 : B
  -- 0xF1 : REP_ADD_L
  Rep_Addr_L_Sel <= '1' when IO_Addr = "1110001" else '0';
  Rep_Addr_L_Wr <= '1' when IO_Addr_r = "1110001" and IO_Wr = '1' else '0';
  -- 0xF2 : REP_ADD_H
  Rep_Addr_H_Sel <= '1' when IO_Addr = "1110010" else '0';
  Rep_Addr_H_Wr <= '1' when IO_Addr_r = "1110010" and IO_Wr = '1' else '0';
  -- 0xF3 : REP_VAL
  Rep_Value_Sel <= '1' when IO_Addr = "1110011" else '0';
  Rep_Value_Wr <= '1' when IO_Addr_r = "1110011" and IO_Wr = '1' else '0';
  -- 0xF4 : AVAILABLE
  -- 0xF5 : AVAILABLE
  -- 0xF6 : AVAILABLE
  -- 0xF7 : AVAILABLE
  -- 0xF8 : KEY
  KEY_Sel <= '1' when IO_Addr = "1111000" else '0';
  KEY_Wr <= '1' when IO_Addr_r = "1111000" and IO_Wr = '1' else '0';
  -- 0xF9 : AVAILABLE
  -- 0xFA : DEBUG_CALL_L single-step/break-point address low
  LCall_Addr_L_Sel <= '1' when IO_Addr = "1111010" else '0';
  LCall_Addr_L_Wr <= '1' when IO_Addr_r = "1111010" and IO_Wr = '1' else '0';
  -- 0xFB : DEBUG_CALL_H single-step/break-point address high
  LCall_Addr_H_Sel <= '1' when IO_Addr = "1111011" else '0';
  LCall_Addr_H_Wr <= '1' when IO_Addr_r = "1111011" and IO_Wr = '1' else '0';
  -- 0xFC : BPC (Break Point Control)
  BPC_Sel <= '1' when IO_Addr = "1111100" else '0';
  BPC_Wr <= '1' when IO_Addr_r = "1111100" and IO_Wr = '1' else '0';
  -- 0xFD : BPS (Break Point Status)
  BPS_Sel <= '1' when IO_Addr = "1111101" else '0';
  BPS_Wr <= '1' when IO_Addr_r = "1111101" and IO_Wr = '1' else '0';
  -- 0xFE : BPAL (Break Point Address Low)
  BPAL_Sel <= '1' when IO_Addr = "1111110" else '0';
  BPAL_Wr <= '1' when IO_Addr_r = "1111110" and IO_Wr = '1' else '0';
  -- 0xFF : BPAH (Break Point Address High)
  BPAH_Sel <= '1' when IO_Addr = "1111111" else '0';
  BPAH_Wr <= '1' when IO_Addr_r = "1111111" and IO_Wr = '1' else '0';
end;
