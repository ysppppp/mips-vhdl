----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2020/12/12 00:22:43
-- Design Name: 
-- Module Name: mips_tb - Behavioral
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
use std.env.finish;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mips_tb is
--  Port ( );
end mips_tb;

architecture Behavioral of mips_tb is
signal clk:std_logic:='0';
signal rs_o,rt_o,rd_o:std_logic_vector(4 downto 0);
signal ins_o: std_logic_vector(31 downto 0);
signal read1,read2: std_logic_vector(31 downto 0);
signal wb: std_logic_vector(31 downto 0); --writeback value of the processor
signal aluresult:  std_logic_vector(31 downto 0);
signal clr: std_logic;
signal halt:  std_logic;
signal rd_o2:std_logic_vector(4 downto 0);
signal r: std_logic_vector(31 downto 0);
signal pc_cur:std_logic_vector(31 downto 0);
signal pc_next:std_logic_vector(31 downto 0);
component mips
    port(
        r_o: out std_logic_vector(31 downto 0);
        rd_2: out std_logic_vector(4 downto 0);
        clk: in std_logic;
        rs_o,rt_o,rd_o:out std_logic_vector(4 downto 0);
        ins_o:out std_logic_vector(31 downto 0);
        read1,read2:out std_logic_vector(31 downto 0);
        wb: out std_logic_vector(31 downto 0); --writeback value of the processor
        aluresult: out std_logic_vector(31 downto 0);
        clr: in std_logic;
        halt: inout std_logic;
        pc_current:out std_logic_vector(31 downto 0);
        pc_nextt:out std_logic_vector(31 downto 0)
    );
end component;
begin
clockgen: process
begin
    wait for 5ns;
    clk <= not clk;
end process;
UUT: mips port map(r,rd_o2,clk,rs_o,rt_o,rd_o,ins_o,read1,read2,wb,aluresult,clr,halt,pc_cur,pc_next);
test: process
begin
    clr <= '1';
    wait for 10ns;
    clr <= '0';
    wait for 600 ns;
finish;
end process;
end Behavioral;
