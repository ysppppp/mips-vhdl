----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2020/11/20 15:19:52
-- Design Name: 
-- Module Name: Decoder_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
use std.env.finish;
entity Decoder_tb is
--  Port ( );
end Decoder_tb;

architecture Behavioral of Decoder_tb is
signal op,funct:std_logic_vector(5 downto 0); --input
signal  MemtoReg,WrtMem,Branch,ALUsrc,RegDst,WrtReg:std_logic:='0';
signal  ALUop:std_logic_vector(2 downto 0):="000";
signal  opR,resR:std_logic:='0';--operand rotation or result rotation;
signal  dir:std_logic:='0';--rotation direction;
signal  BLT,BEQ,BNE:std_logic:= '0'; --branch type indicator
signal  halt:std_logic:='0'; --halt
signal  J:std_logic:='0'; --jump

signal start:std_logic;
signal rst:std_logic;
signal div_alu:std_logic;
component Decoder is
    port(
        op:in std_logic_vector(5 downto 0);
        funct: in std_logic_vector(5 downto 0);
        MemtoReg,WrtMem,Branch,ALUsrc,RegDst,WrtReg:out std_logic:='0';
        ALUop: out std_logic_vector(2 downto 0):="000";
        opR,resR: out std_logic:='0';--operand rotation or result rotation;
        dir:out std_logic:='0';--rotation direction;
        BLT,BEQ,BNE:out std_logic:= '0'; --branch type indicator
        halt:out std_logic:='0'; --halt
        J:out std_logic:='0';--jump
        div_start:out std_logic;
        div_rst:out std_logic;
        div_alu:out std_logic 
    );
end component;
begin
UUT: Decoder port map(op,funct,MemtoReg,WrtMem,Branch,ALUsrc,RegDst,WrtReg,ALUop,opR,resR,dir,BLT,BEQ,BNE,halt,J,start,rst,div_alu);
test:process
begin
    --and
    op <= "000000";
    funct <= "010010";
    wait for 10ns;
    --or
    op <= "000000";
    funct <= "010011";
    wait for 10ns;
    --halt
    op <= "111111";
    funct <= "010010";
    wait for 10ns;
    --nor
    op <= "000000";
    funct <= "010100";
    wait for 10ns;
    --andi
    op <= "000011";
    funct <= "010100";
    wait for 10ns;
    
    --BLT
    op <= "001001";
    funct <= "010110";
    wait for 10ns;
    
    --BEQ
    op <= "001010";
    funct <= "010101";
    wait for 10ns;
    
    --BNE
    op <= "001011";
    funct <= "011100";
    wait for 10ns;
    
    --LW
    op <= "000111";
    wait for 10ns;
    
    --SW
    op <= "101011";
    wait for 10ns;
    
    --rrxr
    op <= "000000";
    funct <= "010001";
    wait for 10ns;
    
     --xrlr
    op <= "000000";
    funct <= "010000";
    wait for 10ns;
    
     --j
    op <= "001100";
    funct <= "010000";
    wait for 10ns;
    
    --divu
    op <= "000000";
    funct <= "101010";
    wait for 10ns;
    
    --divu
    op <= "000000";
    funct <= "101010";
    wait for 10ns;
    
finish;
end process;
end Behavioral;
