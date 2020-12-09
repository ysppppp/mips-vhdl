library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DataMem is
	port (
        clk:in std_logic;  
        Add:in std_logic_vector(31 downto 0);
        WrtData:in std_logic_vector(31 downto 0);
        WrtEn:in std_logic;
        RD:out std_logic_vector(31 downto 0)
        );
end DataMem;

architecture Behavioral of DataMem is
	type mem_type is array (natural range <>) of std_logic_vector(7 downto 0);
	signal mem: mem_type(0 to 1023) := (others=> (others => '0'));
	signal rd1,rd2,rd3,rd4:std_logic_vector(7 downto 0);
	signal address:integer;

begin
process(clk)
begin
    mem(4) <= x"ae";
    mem(5) <= x"c3";
    mem(6) <= x"2b";
    mem(7) <= x"77";
    address <= to_integer(unsigned(Add));
    if rising_edge(clk) then
        if address >= 0 then
            rd1 <= mem(address);
            rd2 <= mem(address+1);
            rd3 <= mem(address+2);
            rd4 <= mem(address+3);
        else
            rd1 <= (others => 'X');
            rd2 <= (others => 'X');
            rd3 <=(others => 'X');
            rd4 <=(others => 'X');
        end if;
        
        if WrtEn = '1' then
            mem(address) <= WrtData(31 downto 24);
            mem(address+1) <= WrtData(23 downto 16);
            mem(address+2) <= WrtData(15 downto 8);
            mem(address+3) <= WrtData(7 downto 0);
        end if;
    end if;
end process;
RD <= rd1&rd2&rd3&rd4;	
end Behavioral;