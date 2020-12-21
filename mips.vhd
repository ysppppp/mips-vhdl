----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2020/12/11 05:50:14
-- Design Name: 
-- Module Name: mips - Behavioral
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
use ieee.numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mips is
    Port ( 
        r_o:out std_logic_vector(31 downto 0);
        rd_2: out std_logic_vector(4 downto 0);
        clk: in std_logic;
        rs_o,rt_o,rd_o:out std_logic_vector(4 downto 0);
        ins_o:out std_logic_vector(31 downto 0);
        read1,read2:out std_logic_vector(31 downto 0);
        wb: out std_logic_vector(31 downto 0); --writeback value of the processor
        aluresult: out std_logic_vector(31 downto 0);
        clr: in std_logic;
        halt: inout std_logic;
        pc_current:out std_logic_vector(31 downto 0);
        pc_nextt:out std_logic_vector(31 downto 0)
        
    );
end mips;

architecture Behavioral of mips is
-- MUX32
component mux32
     Port (a,b:in STD_LOGIC_VECTOR(31 downto 0) ;
          sel:in STD_LOGIC;
          o:out STD_LOGIC_VECTOR(31 downto 0));
end component;

-- MUX5
component mux5
     Port (a,b:in STD_LOGIC_VECTOR(4 downto 0) ;
          sel:in STD_LOGIC;
          o:out STD_LOGIC_VECTOR(4 downto 0));
end component;

--PCreg
component PCreg
     port(
        halt: in std_logic;
        done: in std_logic;
        clk,clr: in std_logic;
        PCin: in std_logic_vector(31 downto 0);
        PCout: out std_logic_vector(31 downto 0)
    );
end component;

--adder
component adder
    port(
        a,b:in std_logic_vector(31 downto 0);
        o:out std_logic_vector(31 downto 0)
    );
end component;

--decoder
component Decoder
    port(
        op:in std_logic_vector(5 downto 0);
        funct: in std_logic_vector(5 downto 0);
        MemtoReg,WrtMem,Branch,ALUsrc,RegDst,WrtReg:out std_logic:='0';
        ALUop: out std_logic_vector(2 downto 0):="000";
        opR,resR: out std_logic:='0';--operand rotation or result rotation;
        dir:out std_logic:='0';--rotation direction;
        BLT,BEQ,BNE:out std_logic:= '0'; --branch type indicator
        halt:out std_logic:='0'; --halt
        J:out std_logic:='0'; --jump
        --for division block
        div_start:out std_logic;
        div_rst:out std_logic;
        div_alu:out std_logic
    );    
end component;

--InsMEM
component InsMem
    port (  
		pc:in std_logic_vector(31 downto 0);
        ins:out std_logic_vector(31 downto 0)
        );
end component;

--RF
component Registers
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
end component;

--SignExtend
component SignExtend
    port (
		i:in  std_logic_vector(15 downto 0);
		o:out std_logic_vector(31 downto 0));
end component;

--division
component division
    Port ( 
        start,rst,clk: in std_logic;
        n,d: in std_logic_vector(31 downto 0);
        q,r: out std_logic_vector(31 downto 0);
        done: out std_logic;
        ready: out std_logic
    );
end component;

--DataMem
component DataMem
    port (
        clk:in std_logic;
        Add:in std_logic_vector(31 downto 0);
        WrtData:in std_logic_vector(31 downto 0);
        WrtEn:in std_logic;
        RD:out std_logic_vector(31 downto 0)
        );
end component;

--rotation block
component rotation
     port(
        a: in std_logic_vector(31 downto 0);
        dir: in std_logic;
        rot_amt:in std_logic_vector(2 downto 0);
        b: out std_logic_vector(31 downto 0)
    );
end component;

--ALU
component ALU
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
end component;

--signals between blocks
signal Rs,Rt:std_logic_vector(4 downto 0);
--operand Rotation MUX out
signal SrcA:std_logic_vector(31 downto 0);
--SrcB MUX
signal SrcB:std_logic_vector(31 downto 0);
signal ALUop:std_logic_vector(2 downto 0);
--RF out
signal RD1:std_logic_vector(31 downto 0);
signal RD2:std_logic_vector(31 downto 0);
--destination register out
signal Rd:std_logic_vector(4 downto 0);
--writeback mux out
signal wbdata: std_logic_vector(31 downto 0);
--Insmem out
signal instr:std_logic_vector(31 downto 0);
--opcode funct
signal op:std_logic_vector(5 downto 0);
signal funct:std_logic_vector(5 downto 0);
--decoder out
signal MemtoReg,WrtMem,Branch,ALUsrc,RegDst,WrtReg: std_logic;

signal four:std_logic_vector(31 downto 0);
signal done:std_logic;
signal pcsrc:std_logic;
signal shiftImm:std_logic_vector(31 downto 0);
signal jumpImm:std_logic_vector(31 downto 0);



signal opR,resR:std_logic;--operand rotation or result rotation;
signal  dir:std_logic;--rotation direction;
signal  BLT,BEQ,BNE:std_logic; --branch type indicator
--signal  alu_halt:std_logic; --halt
signal  J:std_logic; --jump
    --for division block
signal  div_start:std_logic;
signal  div_rst:std_logic;
signal  div_alu: std_logic;

--division out
signal q:std_logic_vector(31 downto 0);
signal r:std_logic_vector(31 downto 0);
signal div_done:std_logic;
signal ready:std_logic;
--ALU out
signal alu_done:std_logic;
signal alu_res:std_logic_vector(31 downto 0);
signal zero:std_logic;

--operand Rotation block
signal rot_RD1:std_logic_vector(31 downto 0);
--alu divison mux out
signal wrtData1:std_logic_vector(31 downto 0);
--alu res rot block out
signal alu_rot:std_logic_vector(31 downto 0);
--alu rot MUX out
signal alu_res_rot:std_logic_vector(31 downto 0);

--datamem out
signal wrtData2:std_logic_vector(31 downto 0);

--pc adder out
signal pcplus4:std_logic_vector(31 downto 0);
--jump address adder
signal jumpadd:std_logic_vector(31 downto 0);
--branch address adder
signal branchadd:std_logic_vector(31 downto 0);
--branch mux
signal branchedadd:std_logic_vector(31 downto 0);
--jump mux
signal pc_next:std_logic_vector(31 downto 0);
--pc reg
signal pc_cur:std_logic_vector(31 downto 0);

--sign extension
signal SignImm:std_logic_vector(31 downto 0);

signal R31:std_logic_vector(4 downto 0);
begin
four <= std_logic_vector(to_unsigned(4,32));
PCadder: adder port map(
    a => pc_cur,
    b => four,
    o => pcplus4
);

done <= alu_done;
PCregister: PCreg port map(
    halt => halt,
    done => done,
    clk => clk,
    clr => clr,
    PCin => pc_next,
    PCout => pc_cur
);
BranchMUX:mux32 port map(
    a => pcplus4,
    b => branchadd,
    sel => pcsrc,
    o => branchedadd
);

JumpMUX: mux32 port map(
    a => branchedadd,
    b => jumpadd,
    sel => J,
    o => pc_next
);

InstrMem: InsMem port map(
    pc => pc_cur,
    ins => instr
);
jumpImm <= "0000"&instr(25 downto 0)&"00";

Jumpadder: adder port map(
    a => pcplus4,
    b => jumpImm,
    o => jumpadd
);
op <= instr(31 downto 26);
funct <= instr(5 downto 0);
Dec:Decoder port map(
    op => op,
    funct => funct,
    MemtoReg => MemtoReg,
    WrtMem => WrtMem,
    Branch => Branch,
    ALUsrc => ALUsrc,
    RegDst => RegDst,
    WrtReg => WrtReg,
    ALUop => ALUop,
    opR => opR,
    resR => resR,
    dir => dir,
    BLT => BLT,
    BEQ => BEQ,
    BNE => BNE,
    halt => halt,
    J => J,
    div_start => div_start,
    div_rst => div_rst,
    div_alu => div_alu
);
DstReg: mux5 port map(
    a => instr(20 downto 16),
    b => instr(15 downto 11),
    sel => RegDst,
    o => Rd
);
Rs <= instr(25 downto 21);
Rt <= instr(20 downto 16);
R31 <= "11111";
RF: Registers port map(
    alu_op => ALUop,
    Rd_2 => R31,
    data2 => r,
    clk => clk,
    done => done,
    Rs => Rs,
    Rt => Rt,
    Rd => Rd,
    data => wbdata,
    WrtReg => WrtReg,
    RD1 => RD1,
    RD2 => RD2
);
SignExtension:SignExtend port map(
    i => instr(15 downto 0),
    o => SignImm
);
shiftImm <= SignImm(29 downto 0)&"00";
branchadder: adder port map(
    a => shiftImm,
    b => pcplus4,
    o => branchadd    
);
RD1rot: rotation port map(
    a => RD1,
    dir => dir,
    rot_amt => instr(8 downto 6),
    b => rot_RD1
);
Src1MUX: mux32 port map(
    a => RD1,
    b => rot_RD1,
    sel => opR,
    o => SrcA
);
Src2MUX: mux32 port map(
    a => RD2,
    b => SignImm,
    sel => ALUsrc,
    o => SrcB
);
ALUblock: ALU port map(
    div_done => div_done,
    BLT => BLT,
    BEQ => BEQ,
    BNE => BNE,
    a => SrcA,
    b => Srcb,
    ALUop => ALUop,
    res => alu_res,
    zero => zero,
    done => alu_done
);
pcsrc <= zero and Branch;
divblock:division port map(
    start => div_start,
    rst => div_rst,
    clk => clk,
    n => SrcA,
    d => SrcB,
    q => q,
    r => r,
    done => div_done,
    ready => ready
);
alurotblock: rotation port map(
    a => alu_res,
    dir => dir,
    rot_amt => instr(8 downto 6),
    b => alu_rot
);
alurotMUX: mux32 port map(
    a => alu_res,
    b => alu_rot,
    sel => resR,
    o => alu_res_rot
);
divaluMUX: mux32 port map(
    a => q,
    b => alu_res_rot,
    sel => div_alu,
    o => wrtData1
);
Datamemo: DataMem port map(
    clk => clk,
    add => alu_res,
    WrtData => RD2,
    WrtEn => WrtMem,
    RD => wrtData2
);
WBMUX: mux32 port map(
    a => wrtData1,
    b => wrtData2,
    sel => MemtoReg,
    o => wbdata
);
rs_o <= Rs;
rt_o <= Rt;
rd_o <= Rd;
r_o <= r;
rd_2 <= R31;
ins_o <= instr;
read1 <= SrcA;
read2 <= SrcB;
aluresult <= alu_res_rot;
wb <= wbdata;
pc_current <= pc_cur;
pc_nextt <= pc_next;
end Behavioral;
