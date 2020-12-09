----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2020/11/20 16:58:11
-- Design Name: 
-- Module Name: DataMem_tb - Behavioral
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

entity DataMem_tb is
--  Port ( );
end DataMem_tb;

architecture Behavioral of DataMem_tb is
signal clk:std_logic:= '0';
signal Add:std_logic_vector(31 downto 0);
signal WrtData:std_logic_vector(31 downto 0);
signal WrtEn:std_logic;
signal RD:std_logic_vector(31 downto 0);
component DataMem
	port (
        clk:in std_logic;  
        Add:in std_logic_vector(31 downto 0);
        WrtData:in std_logic_vector(31 downto 0);
        WrtEn:in std_logic;
        RD:out std_logic_vector(31 downto 0)
        );
end component;
begin
UUT: DataMem port map(clk,Add,WrtData,WrtEn,RD);
clockgen: process
begin
    wait for 5ns;
    clk <= not clk;
end process;
test:process
begin
    Add <= x"00000000";
    WrtData <= x"aef34ced";
    WrtEn <= '1';
    wait for 10ns;
    
    Add <= x"00000000";
    WrtData <= x"ff11ff11";
    WrtEn <= '0';
    wait for 10ns;
    assert(RD = x"aef34ced") report"read data error" severity error;
    
    Add <= x"00000004";
    WrtData <= x"ff11ff11";
    WrtEn <= '0';
    wait for 10ns;
    assert(RD = x"aec32b77") report"read data error" severity error;
finish;
end process;
end Behavioral;
