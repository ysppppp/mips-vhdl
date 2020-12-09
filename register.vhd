library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Registers is
	port (
        clk:in std_logic;
		Rs:in std_logic_vector(4 downto 0);
		Rt:in std_logic_vector(4 downto 0);
		Rd:in std_logic_vector(4 downto 0);
		data:in std_logic_vector(31 downto 0);
		WrtReg:in std_logic;
		RD1:out std_logic_vector(31 downto 0);
        RD2:out std_logic_vector(31 downto 0)
        );
end Registers;

architecture Behavioral of Registers is
	type registers is array (0 to 31) of std_logic_vector(31 downto 0);
	signal regs:registers:= (others=> (others => '0'));
begin
process(clk)
begin
    if(rising_edge(clk)) then
        RD1 <= regs(to_integer(unsigned(Rs)));
        RD2 <= regs(to_integer(unsigned(Rt)));
        if WrtReg = '1' then
            regs(to_integer(unsigned(Rd))) <= data;
        end if;
    end if;
end process;
end Behavioral;
