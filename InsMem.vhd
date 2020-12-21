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
	signal mem: mem_type(0 to 1023) := (
	0 => x"1c", 1 => x"01", 2 =>x"00", 3 => x"00", 
	4 => x"1c", 5 => x"02", 6 =>x"00", 7 => x"01",
	8 => x"00", 9 => x"22", 10 =>x"18", 11 => x"21",
	12 => x"20", 13 => x"63", 14 =>x"00", 15 => x"01",
	16 => x"2c", 17 => x"23", 18 =>x"00", 19 => x"01",
	20 => x"20", 21 => x"63", 22 =>x"00", 23 => x"01",
	24 => x"1c", 25 => x"04", 26 =>x"00", 27 => x"02",
	28 => x"20", 29 => x"84", 30 =>x"00", 31 => x"01",
	32 => x"00", 33 => x"83", 34 =>x"f0", 35 => x"1a",
	36 => x"23", 37 => x"de", 38 =>x"00", 39 => x"01",
	40 => x"1c", 41 => x"05", 42 =>x"00", 43 => x"03",
	44 => x"1c", 45 => x"06", 46 =>x"00", 47 => x"04",
	48 => x"00", 49 => x"a6", 50 =>x"38", 51 => x"12",
	52 => x"00", 53 => x"a6", 54 =>x"38", 55 => x"13",
	56 => x"00", 57 => x"a6", 58 =>x"38", 59 => x"14",	
	60 => x"00", 61 => x"a6", 62 =>x"39", 63 => x"50",
	64 => x"00", 65 => x"a6", 66 =>x"39", 67 => x"51",
	68 => x"00", 69 => x"a6", 70 =>x"38", 71 => x"d5",
	72 => x"00", 73 => x"a6", 74 =>x"38", 75 => x"96",
	76 => x"0c", 77 => x"e7", 78 =>x"8c", 79 => x"de",
	80 => x"10", 81 => x"e7", 82 =>x"a5", 83 => x"4d",
	84 => x"24", 85 => x"27", 86 =>x"00", 87 => x"01",
	88 => x"24", 89 => x"27", 90 =>x"00", 91 => x"01",
	92 => x"30", 93 => x"00", 94 =>x"00", 95 => x"01",
	96 => x"24", 97 => x"27", 98 =>x"00", 99 => x"01",
    100 => x"ac", 101 => x"07", 102 =>x"00", 103 => x"05",
    104 => x"1c", 105 => x"08", 106 =>x"00", 107 => x"05",    
	108 => x"28", 109 => x"64", 110 =>x"00", 111 => x"01",
	112 => x"28", 113 => x"64", 114 =>x"00", 115 => x"01",
	116 => x"ff", 117 => x"ff", 118 =>x"ff", 119 => x"ff",
	others=> (others => '0'));
	signal FullInstruction:std_logic_vector(31 downto 0); -- to merge the 4 memory bytes
	signal address:integer;
begin
	address <= to_integer(unsigned(pc));-- when (to_integer(unsigned(inIM)) >= 0) else 0;
	FullInstruction <= mem(address) & mem(address+1) & mem(address+2) & mem(address+3)
		when (address >= 0) else (others => 'X');--std_logic_vector(to_unsigned(0,32));
	ins <= FullInstruction;
end Behavioral;