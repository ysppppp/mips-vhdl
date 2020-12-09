library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE. NUMERIC_STD.ALL;
entity Decoder is
    port(
        op:in std_logic_vector(5 downto 0);
        funct: in std_logic_vector(5 downto 0);
        MemtoReg,WrtMem,Branch,ALUsrc,RegDst,WrtReg:out std_logic:='0';
        ALUop: out std_logic_vector(2 downto 0):="000";
        opR,resR: out std_logic:='0';--operand rotation or result rotation;
        dir:out std_logic:='0';--rotation direction;
        BLT,BEQ,BNE:out std_logic:= '0'; --branch type indicator
        halt:out std_logic:='0'; --halt
        J:out std_logic:='0' --jump
    );
end Decoder;
architecture Behavioral of Decoder is

begin
process(op,funct)
begin
    MemtoReg <= '0';
    WrtMem <= '0';
    Branch <= '0';
    ALUsrc <= '0';
    RegDst <= '0';
    WrtReg <= '0';
    ALUop <= "000";
    opR <= '0';
    resR <= '0';
    dir <= '0';
    BLT <= '0';
    BEQ <= '0';
    BNE <= '0';
    halt <= '0';
    J <= '0';
    if op = "000000" then
        MemtoReg <= '0';--select alu result to write
        ALUsrc <= '0';--Rt is the second operand
        RegDst <= '1';--Rd is the destination
        WrtReg <= '1'; --enable register write
        case funct is
            when "010010" => 
                ALUop <= "001"; --AND
            when "010011" => 
                ALUop <= "010"; --OR
            when "010100" => 
                ALUop <= "011"; -- NOR
            when "100000" => 
                ALUop <= "100"; -- ADD
            When "100001" => 
                ALUop <= "100"; -- ADDU
            when "101010" => 
                ALUop <= "101"; -- DIVU
            when "010000" => 
                ALUop <= "110"; -- XRLR xor
                resR <= '1';
                dir <= '0'; --left rotate
            when "010001" => 
                ALUop <= "110"; -- RRXR xor
                opR <= '1';
                dir <= '1'; --right rotate
            when "010101" => 
                ALUop <= "100"; -- LRAD add
                opR <= '1';
                dir <= '0'; --left rotate
            when "010110" => 
                ALUop <= "111"; -- SBRR sub
                resR <= '1';
                dir <= '1'; --right rotate
            when others =>
                ALUop <= "000";
        end case;
        --when not J type and not R type
    elsif op /= "111111" and op /= "001100" then 
        ALUsrc <= '1'; --select extended imm to be operand
        RegDst <= '0'; --destination reg is Rt
        case op is
            when "000011" => -- ANDI
                ALUop <= "001"; -- AND
                WrtReg <= '1';
            when "000100" => -- ORI
                ALUop <= "010"; -- OR
                WrtReg <= '1';
            when "000111" => -- LW
                MemtoReg <= '1'; -- select data from mem to write
                ALUop <= "100"; -- ADD
                WrtReg <= '1';
            when "101011" => --SW
                ALUop <= "100"; -- ADD
                WrtMem <= '1';
            when "001001" => --BLT
                ALUop <= "000"; -- ALU nop
                Branch <= '1';
                BLT <= '1';
            when "001010" => -- BEQ
                ALUop <= "000"; -- ALU nop
                Branch <= '1';
                BEQ <= '1';
            when "001011" => --BNE
                ALUop <= "000"; -- ALU nop
                Branch <= '1';
                BNE <= '1';
            when others =>
                ALUop <= "000";
        end case;
    else
        case op is
            when "001100" => --jump
                J <= '1'; --PCsrc1
            when "111111" => --halt
                halt <= '1';
            when others =>
                ALUop <= "000";
        end case;
    end if;
end process;
end Behavioral;