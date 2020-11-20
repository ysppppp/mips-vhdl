library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY DataMem IS
	port (
        clk:in std_logic;  
        Add:in std_logic_vector(31 downto 0);
        WrtData:in std_logic_vector(31 downto 0);
        WrtEn:in std_logic;
        RD:out std_logic_vector(31 downto 0)
        );
END DataMem;

ARCHITECTURE Behavioral of DataMem is
	type mem_type is array (natural range <>) of std_logic_vector(7 downto 0);
	signal mem: mem_type(0 to 1023) := (others=> (others => '0'));
	signal ReadData: std_logic_vector(31 downto 0);
	signal address:      integer;

BEGIN
process(clk)
    address <= to_integer(unsigned(Add));
    if rising_edge(clk) then
        ReadData <= mem(address) & mem(address+1) & mem(address+2) & mem(address+3)
            when (address >= 0) else std_logic_vector(to_signed(-1,32));
        if WrtEn = '1' then
            mem(address) <= WrtData(31 downto 24);
            mem(address+1) <= WrtData(23 downto 16);
            mem(address+2) <= WrtData(15 downto 8);
            mem(address+3) <= WrtData(7 downto 0);
        end if;
    end if;
end process;	
	RD <= ReadData;
END Behavioral;