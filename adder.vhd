library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity adder is
    port(
        a,b:in std_logic_vector(31 downto 0);
        o:out std_logic_vector(31 downto 0)
    );
end entity;

architecture Behavioral of adder is

signal oo:unsigned(31 downto 0);
begin   
    o <= std_logic_vector(unsigned(a) + unsigned(b));
end Behavioral;