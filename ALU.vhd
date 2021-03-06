library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE. NUMERIC_STD.ALL;
-- 000 nop
-- 001 and
-- 010 or
-- 011 nor
-- 100 add
-- 101 div
-- 110 xor
-- 111 sub
entity ALU is
    port(
        div_done: in std_logic; -- if division is done
        BLT,BEQ,BNE:in std_logic; -- branch type
        ALUop: in std_logic_vector(2 downto 0);
        a,b: in std_logic_vector(31 downto 0);
        -- u: in std_logic; -- unsgined
        res: out std_logic_vector(31 downto 0);
        zero: out std_logic:='0'; -- branch take or not
        done: out std_logic
    );
end ALU;

architecture Behavioral of ALU is
signal a_comp:unsigned(31 downto 0);
signal b_comp:unsigned(31 downto 0);
begin

process(a,b,ALUop,BLT,BEQ,BNE,div_done)
begin
    done <= '1';
    
    a_comp <= unsigned(not a) + to_unsigned(1,32);
    b_comp <= unsigned(not b) + to_unsigned(1,32);

    if ALUop = "001" then
        res <= a AND b;
        
    elsif ALUop = "010" then
        res <= a OR b;
        
    elsif ALUop = "011" then
        res <= a NOR b;
        
    elsif ALUop = "100" then
        res <= std_logic_vector(unsigned(a)+unsigned(b));
    elsif ALUop = "101" then
        done <= '0';
        
    elsif ALUop = "110" then
        res <= a XOR b;
        
    elsif ALUop = "111" then-- sub
        res <= std_logic_vector(signed(a) - signed(b));
        
    else
        res <= (others => '0');
        
    end if;

    if BLT = '1' and unsigned(a) < unsigned(b) then
        zero <= '1';
        
    elsif BEQ = '1' and unsigned(a) = unsigned(b) then
        zero <= '1';
        
    elsif BNE = '1' and unsigned(a) /= unsigned(b) then
        zero <= '1';
        
    else
        zero <= '0';
    end if;
    if(rising_edge(div_done)) then
        done <= '1';
    end if;
end process;

--process(div_done)
--begin
--    if(rising_edge(div_done)) then
--        done <= '1';
--    end if;
--end process;

end Behavioral;