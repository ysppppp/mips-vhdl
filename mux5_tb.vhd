----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2020/11/20 15:02:44
-- Design Name: 
-- Module Name: mux5_tb - Behavioral
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
entity mux5_tb is
--  Port ( );
end mux5_tb;

architecture Behavioral of mux5_tb is
signal a,b:std_logic_vector(4 downto 0);
signal sel:std_logic;
signal o: std_logic_vector(4 downto 0);
component mux5
    port(
        a,b:in STD_LOGIC_VECTOR(4 downto 0) ;
        sel:in STD_LOGIC;
        o:out STD_LOGIC_VECTOR(4 downto 0)
    );
end component;
begin
UUT:mux5 port map(a,b,sel,o);
test: process
begin
    a <= "10101";
    b <= "01010";
    sel <= '0';
    wait for 10ns;
    assert(o = "10101") report"selected wrong val" severity error;
    
    a <= "10101";
    b <= "01010";
    sel <= '1';
    wait for 10ns;
    assert(o = "01010") report"selected wrong val" severity error;
finish;
end process;



end Behavioral;
