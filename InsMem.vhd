library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity InsMem is
	port (  
		pc:in std_logic_vector(31 downto 0);
        ins:out std_logic_vector(31 downto 0)
        );
end InsMem;

architecture Behavioral of InsMem is
	type mem_type is array (natural range <>) of std_logic_vector(7 downto 0);
	signal mem: mem_type(0 to 1023) := (others=> (others => '0'));
	signal FullInstruction:std_logic_vector(31 downto 0); -- to merge the 4 memory bytes
	signal address:integer;
begin
    mem(4) <= x"ae";
    mem(5) <= x"c3";
    mem(6) <= x"2b";
    mem(7) <= x"77";
	address <= to_integer(unsigned(pc));-- when (to_integer(unsigned(inIM)) >= 0) else 0;
	FullInstruction <= mem(address) & mem(address+1) & mem(address+2) & mem(address+3)
		when (address >= 0) else std_logic_vector(to_signed(-1,32));
	ins <= FullInstruction;
end Behavioral;