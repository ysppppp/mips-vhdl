----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2020/11/20 16:27:04
-- Design Name: 
-- Module Name: InsMem_tb - Behavioral
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

entity InsMem_tb is
--  Port ( );
end InsMem_tb;

architecture Behavioral of InsMem_tb is
signal pc:std_logic_vector(31 downto 0);
signal ins:std_logic_vector(31 downto 0);
component InsMem 
	port (  
		pc:in std_logic_vector(31 downto 0);
        ins:out std_logic_vector(31 downto 0)
        );
end component;

begin
UUT: InsMem port map(pc,ins);
test: process
begin
    pc <= x"00000000";
    wait for 10ns;
    
    pc <= x"00000004";
    wait for 10ns;
    assert(ins = x"aec32b77")report"read error"  severity error;
finish;
end process;
end Behavioral;
