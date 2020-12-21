----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2020/11/20 13:44:58
-- Design Name: 
-- Module Name: ALU_tb - Behavioral
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
entity ALU_tb is
--  Port ( );
end ALU_tb;

architecture Behavioral of ALU_tb is
signal div_done:std_logic;
signal done:std_logic;
signal BLT,BEQ,BNE:std_logic;
signal ALUop:std_logic_vector(2 downto 0);
signal a,b:std_logic_vector(31 downto 0);
signal res:std_logic_vector(31 downto 0);
signal zero:std_logic:='0';
signal x:std_logic_vector(31 downto 0):=(others => 'X');
component ALU
    port(
        div_done: in std_logic; -- if division is done
        BLT,BEQ,BNE:in std_logic; -- branch type
        ALUop: in std_logic_vector(2 downto 0);
        a,b: in std_logic_vector(31 downto 0);
        -- u: in std_logic; -- unsgined
        res: out std_logic_vector(31 downto 0);
        zero: out std_logic:='0'; -- branch take or not
        done: out std_logic
    );
end component;
begin
UUT: ALU port map(div_done,BLT,BEQ,BNE,ALUop,a,b,res,zero,done);

test: process
begin
    --BLT
    BLT <= '1';
    a <= x"00000001";
    b <= x"00000002";
    wait for 10ns;
    BLT <= '0';
    assert(zero = '1')  report "BLT failed" severity error;
    --BEQ
    BEQ <= '1';
    a <= x"00000005";
    b <= x"00000003";
    wait for 10ns;
    BEQ <= '0';
    assert(zero = '0')  report "BEQ failed" severity error;
    --BNE
    BNE <= '1';
    a <= x"00000004";
    b <= x"00000003";
    wait for 10ns;
    BNE <= '0';
    assert(zero = '1')  report "BNE failed" severity error;
    
    --AND
    ALUop <= "001";
    a <= x"10101010";
    b <= x"ffffffff";
    wait for 10 ns;
    assert(res = x"10101010") report "and failed" severity error;
    
    --OR
    ALUop <= "010";
    a <= x"10101010";
    b <= x"01010101";
    wait for 10 ns;
    assert(res = x"11111111") report "or failed" severity error;
    
    --NOR
    ALUop <= "011";
    a <= x"00000000";
    b <= x"00000000";
    wait for 10 ns;
    assert(res = x"ffffffff") report "nor failed" severity error;
    
    --ADD
    ALUop <= "100";
    a <= x"00000004";
    b <= x"00000004";
    wait for 10 ns;
    assert(res = x"00000008") report "add failed" severity error;
    
    --div not implemented yet
    
    --XOR
    ALUop <= "110";
    a <= x"10101010";
    b <= x"ffffffff";
    wait for 10 ns;
    assert(res = x"efefefef") report "add failed" severity error;
    
    --SUB signed
    ALUop <= "111";
    a <= x"00000004";-- 4
    b <= x"fffffffc"; -- -4
    wait for 10 ns;
    assert(res = x"00000008") report "add failed" severity error;
    
    --nop
    ALUop <= "000";
    a <= x"00000004";
    b <= x"fffffffc";
    wait for 10 ns;
    assert(res = x) report "add failed" severity error;
    
    ALUop <= "101";
    div_done <= '0';
    wait for 2ns;
    div_done <='1';
    wait for 8 ns; 
finish;
end process;
end Behavioral;
