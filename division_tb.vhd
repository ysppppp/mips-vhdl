----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2020/12/10 05:21:54
-- Design Name: 
-- Module Name: division_tb - Behavioral
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
use ieee.numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
use std.env.finish;
entity division_tb is
--  Port ( );
end division_tb;

architecture Behavioral of division_tb is
component division
    port(
        start,rst,clk: in std_logic;
        n,d: in std_logic_vector(31 downto 0);
        q,r: out std_logic_vector(31 downto 0);
        done: out std_logic;
        ready: out std_logic
    );
end component;
signal n,d,q,r:std_logic_vector(31 downto 0);
signal start,rst,done,ready:std_logic;
signal clk:std_logic:='0';
begin
div: division port map(
    start => start,
    rst => rst,
    clk => clk,
    n => n,
    d => d,
    q => q,
    r => r,
    done => done,
    ready => ready
);
clock_gen:process
begin
    wait for 5ns;
    clk <= not clk;
    
end process;
test:process
begin
    start <= '0';
    rst <= '1';
    wait for 10 ns;
    
    rst <= '0';
    start <= '1';
    n <= x"00000004";
    d <= x"00000003";
    wait for 320 ns;
    
    start <= '1';
    n <= x"00000008";
    d <= x"00000003";
    wait for 320 ns;
finish;    
end process;
end Behavioral;
