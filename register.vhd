library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Registers is
	port (
	    alu_op:in std_logic_vector(2 downto 0);
	    done:in std_logic; -- alu is done
	    clk:in std_logic;
		Rs:in std_logic_vector(4 downto 0);
		Rt:in std_logic_vector(4 downto 0);
		Rd:in std_logic_vector(4 downto 0);
		Rd_2:in std_logic_vector(4 downto 0);
		data:in std_logic_vector(31 downto 0);
		data2:in std_logic_vector(31 downto 0);
		WrtReg:in std_logic;
		RD1:out std_logic_vector(31 downto 0);
        RD2:out std_logic_vector(31 downto 0)
        );
end Registers;

architecture Behavioral of Registers is
	type registers is array (0 to 31) of std_logic_vector(31 downto 0);
	signal regs:registers:= (others=> (others => '0'));
	signal delayclk: std_logic;
begin

--process(Rs,Rt)
--begin
    RD1 <= regs(to_integer(unsigned(Rs)));
    RD2 <= regs(to_integer(unsigned(Rt)));
--end process;

    delayclk <=transport clk after 2 ns;

    process(delayclk)
    begin
        if(rising_edge(delayclk)) then
            if(WrtReg = '1' and done = '1') then
                regs(to_integer(unsigned(Rd))) <= data;
                if(alu_op = "101") then
                    regs(to_integer(unsigned(Rd_2))) <= data2;
                end if;
            end if;
        end if;
    end process;
    

        

end Behavioral;
