----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2020/12/10 01:59:12
-- Design Name: 
-- Module Name: division - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity division is
    Port ( 
        start,rst,clk: in std_logic;
        n,d: in std_logic_vector(31 downto 0);
        q,r: out std_logic_vector(31 downto 0);
        done: out std_logic;
        ready: out std_logic
    );
end division;

architecture Behavioral of division is
begin
process(clk)
variable q_temp:std_logic_vector(31 downto 0);
variable r_temp:std_logic_vector(31 downto 0);
variable i:unsigned(4 downto 0);
variable done_temp:std_logic:= '0';
variable ready_temp:std_logic:='1';
begin
    
    if rising_edge(clk) then
        done_temp := '0';
        if rst = '1' then
            q_temp:= (others => '0');
            r_temp:= (others => '0');
            i:= to_unsigned(31,5);
            done_temp:= '0';
            ready_temp:='1';
        elsif(start = '1' and ready_temp = '1') then
            ready_temp:= '0';
            i:= to_unsigned(31,5);
            q_temp:=(others => '0');
            r_temp:= (others => '0');
        elsif ready_temp = '0' then
            r_temp:= r_temp(30 downto 0)&n(to_integer(i));
            if unsigned(r_temp) >= unsigned(d) then
                r_temp:= std_logic_vector(unsigned(r_temp) - unsigned(d));
                q_temp(to_integer(i)) := '1';
            end if;
        end if;
        if (to_integer(i)/= 0) then
            i:= i - to_unsigned(1,5);
        else
            ready_temp:='1';
            done_temp:= '1';
        end if;
    end if;
    q <= q_temp;
    r <= r_temp;
    done <= done_temp;
    ready <= ready_temp;
end process;

end Behavioral;
