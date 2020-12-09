----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2020/11/20 11:58:43
-- Design Name: 
-- Module Name: rotation_tb - Behavioral
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
entity rotation_tb is
--  Port ( );
end rotation_tb;

architecture Behavioral of rotation_tb is
signal a,b:std_logic_vector(31 downto 0);
signal dir:std_logic;
signal rot_amt:std_logic_vector(2 downto 0);
constant CLK_PERIOD: time := 10ns;
component rotation
    port(
        a: in std_logic_vector(31 downto 0);
        dir: in std_logic;
        rot_amt:in std_logic_vector(2 downto 0);
        b: out std_logic_vector(31 downto 0)
    );
end component;
begin
UUT: rotation port map(a, dir, rot_amt, b);

test: process
begin
    a <= x"ffff0000";
    dir <= '0';
    rot_amt <= "100";
    wait for CLK_PERIOD;
    assert(b = x"fff0000f") report "shift left failed" severity error;
    
    a <= x"ffff0000";
    dir <= '1';
    rot_amt <= "101";
    wait for CLK_PERIOD;
    assert(b = x"07fff800") report "shift right failed" severity error;
finish;
end process;

end Behavioral;
