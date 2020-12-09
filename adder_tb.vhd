----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2020/11/20 12:31:00
-- Design Name: 
-- Module Name: adder_tb - Behavioral
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
entity adder_tb is
--  Port ( );
end adder_tb;

architecture Behavioral of adder_tb is
signal a,b:std_logic_vector(31 downto 0);
signal o:std_logic_vector(31 downto 0);
component adder
 port(
        a,b:in std_logic_vector(31 downto 0);
        o:out std_logic_vector(31 downto 0)
    );
end component;
begin
UUT:adder port map(a,b,o);

test: process
begin
    a <= x"ffffffff";
    b <= x"fff00004";
    wait for 10ns;
    
    a <= x"8437beaf";
    b <= x"00000004";
    wait for 10ns;
    
    a <= x"00000000";
    b <= x"00000004";
    wait for 10ns;
    
finish;
end process;

end Behavioral;
