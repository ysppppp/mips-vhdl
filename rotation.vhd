library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity rotation is
    port(
        a: in std_logic_vector(31 downto 0);
        dir: in std_logic;
        rot_amt:in std_logic_vector(2 downto 0);
        b: out std_logic_vector(31 downto 0)
    );
end rotation;

architecture Behavioral of rotation is
begin
process(a,dir,rot_amt)
begin
    if dir = '0' then
        case rot_amt is
            when "000" =>
                b <= a;
            when "001" =>
                b <= a(30 downto 0)&a(31);
            when "010" =>
                b <= a(29 downto 0)&a(31 downto 30);
            when "011" =>
                b <= a(28 downto 0)&a(31 downto 29);
            when "100" =>
                b <= a(27 downto 0)&a(31 downto 28);
            when "101" =>
                b <= a(26 downto 0)&a(31 downto 27);
            when "110" =>
                b <= a(25 downto 0)&a(31 downto 26);
            when "111" =>
                b <= a(24 downto 0)&a(31 downto 25);
            when others =>
                b <= x"00000000";
        end case;
    elsif dir = '1' then
        case rot_amt is
            when "000" =>
                b <= a;
            when "001" =>
                b <= a(0)&a(31 downto 1);
            when "010" =>
                b <= a(1 downto 0)&a(31 downto 2);
            when "011" =>
                b <= a(2 downto 0)&a(31 downto 3);
            when "100" =>
                b <= a(3 downto 0)&a(31 downto 4);
            when "101" =>
                b <= a(4 downto 0)&a(31 downto 5);
            when "110" =>
                b <= a(5 downto 0)&a(31 downto 6);
            when "111" =>
                b <= a(6 downto 0)&a(31 downto 7);
             when others =>
                b <= x"00000000";
        end case;
    end if;        
end process;
end Behavioral;