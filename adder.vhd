library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE. NUMERIC_STD.ALL;

entity adder is
    port(
        a,b:in std_logic_vector(31 downto 0);
        o:out std_logic_vector(31 downto 0);
        carry:out std_logic
    );
end entity;

architecture Behavioral of adder is
    signal temp:std_logic_vector(32 downto 0);
begin
    temp <= std_logic_vector(unsigned(a)+unsigned(b));
    carry <= temp(32);
    o <= temp(31 downto 0);
end Behavioral;