library IEEE;
use IEEE.std_logic_1164.all;

ENTITY SignExtend IS
	port (
		i:in  std_logic_vector(15 downto 0);
		o:out std_logic_vector(31 downto 0));
END SignExtend;

ARCHITECTURE Behavioral of SignExtend is
signal ones: std_logic_vector(15 downto 0):=(others=>'1');
signal zeros: std_logic_vector(15 downto 0):=(others=>'0');
BEGIN
	o <= ones & i  when i(15)='1' else
	             zeros & i  when i(15)='0';
END Behavioral;