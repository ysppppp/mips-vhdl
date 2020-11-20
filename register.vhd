library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY Registers is
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
END Registers;

ARCHITECTURE Behavioral of Registers is
	type registers is array (0 to 31) of std_logic_vector(31 downto 0);
	signal regs:registers:= (others=> (others => '0'));
BEGIN
process(clk)
begin
    if(rising_edge(clk)) then
        RegOut1 <= regs(to_integer(unsigned(RegIn1)));
        RegOut2 <= regs(to_integer(unsigned(RegIn2)));
        regs(to_integer(unsigned(RegWriteIn))) <= data when (WrtReg = '1');
    end if;
end process;
END Behavioral;
