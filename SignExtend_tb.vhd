----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2020/11/20 14:40:55
-- Design Name: 
-- Module Name: SignExtend_tb - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
use std.env.finish;
entity SignExtend_tb is
--  Port ( );
end SignExtend_tb;

architecture Behavioral of SignExtend_tb is
signal i:std_logic_vector(15 downto 0);
signal o:std_logic_vector(31 downto 0);
component SignExtend
    port(
        i:in  std_logic_vector(15 downto 0);
		o:out std_logic_vector(31 downto 0)
    );
end component;
begin
UUT: signExtend port map(i,o);
test: process
begin
    i <= x"8000";
    wait for 10ns;
    assert(o = x"ffff8000") report"sign extend failed for negative value" severity error;
    
    i <= x"1000";
    wait for 10ns;
    assert(o = x"00001000") report"sign extend failed for positive value" severity error;
finish;    
end process;

end Behavioral;
