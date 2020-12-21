----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2020/11/20 17:42:52
-- Design Name: 
-- Module Name: Registers_tb - Behavioral
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

entity Registers_tb is
--  Port ( );
end Registers_tb;

architecture Behavioral of Registers_tb is
signal clk:std_logic:='0';
signal Rs,Rt,Rd:std_logic_vector(4 downto 0);
signal data:std_logic_vector(31 downto 0);
signal WrtReg:std_logic;
signal RD1,RD2:std_logic_vector(31 downto 0);
signal done:std_logic;
component Registers 
	port (
	    clk:in std_logic;
	    done:std_logic;
		Rs:in std_logic_vector(4 downto 0);
		Rt:in std_logic_vector(4 downto 0);
		Rd:in std_logic_vector(4 downto 0);
		data:in std_logic_vector(31 downto 0);
		WrtReg:in std_logic;
		RD1:out std_logic_vector(31 downto 0);
        RD2:out std_logic_vector(31 downto 0)
        );
end component;
begin
UUT: Registers port map(clk,done,Rs,Rt,Rd,data,WrtReg,RD1,RD2);
clockgen: process
begin
wait for 5ns;
clk <= not clk;
end process;

test:process
begin
    Rs <= "00000";
    Rt <= "00000";
    Rd <= "00001";
    data <= x"ffffffff";
    done <= '1';
    WrtReg <= '1';
    wait for 10ns;
    
    Rs <= "00000";
    Rt <= "00000";
    Rd <= "00010";
    data <= x"10101010";
    WrtReg <= '1';
    done <= '0';
    wait for 10ns;
    
    Rs <= "00001";
    Rt <= "00010";
    Rd <= "00010";
    data <= x"11111111";
    WrtReg <= '0';
    wait for 10ns;
    assert(RD1 = x"ffffffff" and RD2 = x"00000000") report"read data error" severity error;
finish;
end process;

end Behavioral;
