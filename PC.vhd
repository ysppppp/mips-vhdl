library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity PCreg is
    port(
        clk,clr: in std_logic;
        PCin: in std_logic_vector(31 downto 0);
        PCout: out std_logic_vector(31 downto 0);
    );
end PCreg;

architecture Behavioral of PCreg is
signal pcAdd:std_logic_vector(31 downto 0);
begin
process(clk)
begin
    if rising_edge(clk) then
        if clr='1' then
            pcAdd <= (others => '0');
        else
            pcAdd <= PCin;
        end if;
    end if;
end process;
PCout <= pcAdd;
end Behavioral;