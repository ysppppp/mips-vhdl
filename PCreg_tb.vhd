----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2020/11/20 11:35:07
-- Design Name: 
-- Module Name: PCreg_tb - Behavioral
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
entity PCreg_tb is
    --Port ( );
end PCreg_tb;

architecture Behavioral of PCreg_tb is
signal clr,clk:std_logic:= '0';
signal done:std_logic:='1';
signal PCin,PCout:std_logic_vector(31 downto 0);
constant CLK_PERIOD: Time := 10ns;
component PCreg
    port(
        done: in std_logic;
        clk,clr: in std_logic;
        PCin: in std_logic_vector(31 downto 0);
        PCout: out std_logic_vector(31 downto 0)
    );
end component;
begin
UUT: PCreg port map(done,clk, clr, PCin, PCout);
gen_clock: process
begin
    wait for(CLK_PERIOD/2);
    clk<=not clk;
end process;

test:process
begin
    PCin <= x"af8ec302";
    wait for CLK_PERIOD;
    assert(PCout = x"af8ec302") report "sth. failed1" severity error;
    
    PCin <= x"6aecb0c2";
    wait for CLK_PERIOD;
    assert(PCout = x"6aecb0c2") report "sth. failed1" severity error;
    
    done <= '0';
    PCin <= x"c4b8decf";
    wait for CLK_PERIOD;
    done <= '1';
    assert(PCout = x"6aecb0c2") report "sth. failed1" severity error;
    
    PCin <= x"af8ec302";
    wait for CLK_PERIOD;
    assert(PCout = x"af8ec302") report "sth. failed1" severity error;
    
    clr <= '1';
    wait for CLK_PERIOD;
    assert(PCout = x"00000000") report "sth. failed1" severity error;
finish;
end process;
end Behavioral;
