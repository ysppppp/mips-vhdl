----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2020/11/20 14:49:59
-- Design Name: 
-- Module Name: mux32_tb - Behavioral
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
entity mux32_tb is
--  Port ( );
end mux32_tb;

architecture Behavioral of mux32_tb is
signal a,b:std_logic_vector(31 downto 0);
signal sel:std_logic;
signal o: std_logic_vector(31 downto 0);
component mux32
    port(
        a,b:in STD_LOGIC_VECTOR(31 downto 0) ;
        sel:in STD_LOGIC;
        o:out STD_LOGIC_VECTOR(31 downto 0)
    );
end component;
begin
UUT:mux32 port map(a,b,sel,o);
test: process
begin
    a <= x"ffffffff";
    b <= x"01010101";
    sel <= '0';
    wait for 10ns;
    assert(o = x"ffffffff") report"selected wrong val" severity error;
    
    a <= x"ffffffff";
    b <= x"01010101";
    sel <= '1';
    wait for 10ns;
    assert(o = x"01010101") report"selected wrong val" severity error;
finish;
end process;

end Behavioral;
