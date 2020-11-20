library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE. NUMERIC_STD.ALL;

entity mux5 is
    Port (a,b:in STD_LOGIC_VECTOR(4 downto 0) ;
          sel:in STD_LOGIC;
          o:out STD_LOGIC_VECTOR(4 downto 0));
end mux5;

architecture Behavioral of mux32 is
begin
    o <= a when sel = '0' else
         b when sel = ‘1’；
end Behavioral;