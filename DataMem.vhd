library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DataMem is
	port (
	    clk: in std_logic;
        Add:in std_logic_vector(31 downto 0);
        WrtData:in std_logic_vector(31 downto 0);
        WrtEn:in std_logic;
        RD:out std_logic_vector(31 downto 0)
        );
end DataMem;

architecture Behavioral of DataMem is
	type mem_type is array (natural range <>) of std_logic_vector(31 downto 0);
	signal mem: mem_type(0 to 255) := (
	0 => x"00000001", 
	1 => x"00000002",
	2 => x"00000003",
	3 => x"cccccccc",
	4 => x"55555555",
	others=> (others => '0'));
	signal delayclk:std_logic;
    
begin
    delayclk <= transport clk after 2 ns;
    RD <= mem(to_integer(unsigned(Add))) when (to_integer(unsigned(Add)) >= 0 and to_integer(unsigned(Add)) <= 255) else (x"00000000");

    process(delayclk)
    begin
    if(rising_edge(delayclk)) then
        if(WrtEn = '1') then
            mem(to_integer(unsigned(Add))) <= Wrtdata;
        end if;
    end if;
    end process;
	
end Behavioral;