library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
entity PCreg is
    port(
        halt:in std_logic;
        done: in std_logic;
        clk,clr: in std_logic;
        PCin: in std_logic_vector(31 downto 0);
        PCout: out std_logic_vector(31 downto 0)
    );
end PCreg;

architecture Behavioral of PCreg is
signal pcAdd:std_logic_vector(31 downto 0):=std_logic_vector(to_signed(-4,32));
begin
process(clk)
begin
    if rising_edge(clk) then
        if clr='1' then
            pcAdd <= std_logic_vector(to_signed(-4,32));
        elsif done = '1'and halt /= '1' then
            pcAdd <= PCin;
        end if;
    end if;
end process;
PCout <= pcAdd;
end Behavioral;