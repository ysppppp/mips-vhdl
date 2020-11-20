library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE. NUMERIC_STD.ALL;

entity mux32 is
    Port (a,b:in STD_LOGIC_VECTOR(31 downto 0) ;
          sel:in STD_LOGIC;
          o:out STD_LOGIC_VECTOR(31 downto 0));
end mux32;

architecture Behavioral of mux32 is
begin
    o <= a when sel = '0' else
         b;
end Behavioral;