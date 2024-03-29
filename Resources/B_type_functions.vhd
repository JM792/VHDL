--begin section by Jiayi Ma
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_bit.ALL;
use WORK.register_init.ALL;
use WORK.cpu_defs_pack.ALL;
use WORK.extension_pack.ALL;

package B_type_functions is
subtype immType1 is bit_vector(6 downto 0);
subtype immType2 is bit_vector(4 downto 0);

procedure B_slice(
        Instr: in InstrType;
        rs1: out RegAddrType;
        rs2: out RegAddrType;
        imm1: out immType1;
        imm2: out immType2;
        func3: out func3_type
);

procedure BEQ(
    rs1: in RegAddrType;
    rs2: in RegAddrType;
    imm1: in immType1;
    imm2: in immType2;
    PC: inout integer
);

procedure BNE( --branch if not equal
    rs1: in RegAddrType;
    rs2: in RegAddrType;
    imm1: in immType1;
    imm2: in immType2;
    PC: inout integer
);

procedure BLT( --branch if not equal
    rs1: in RegAddrType;
    rs2: in RegAddrType;
    imm1: in immType1;
    imm2: in immType2;
    PC: inout integer
);

procedure BGE( --branch if not equal
    rs1: in RegAddrType;
    rs2: in RegAddrType;
    imm1: in immType1;
    imm2: in immType2;
    PC: inout integer
);

procedure BLTU( --branch if not equal
    rs1: in RegAddrType;
    rs2: in RegAddrType;
    imm1: in immType1;
    imm2: in immType2;
    PC: inout integer
);

procedure BGEU( --branch if not equal
    rs1: in RegAddrType;
    rs2: in RegAddrType;
    imm1: in immType1;
    imm2: in immType2;
    PC: inout integer
);

end B_type_functions;


package body B_type_functions is

procedure B_slice(
        Instr: in InstrType;
        rs1: out RegAddrType;
        rs2: out RegAddrType;
        imm1: out immType1;
        imm2: out immType2;
        func3: out func3_type
) is
begin
    rs1 := Instr(19 downto 15);
    rs2 := Instr(24 downto 20);
    imm1 := Instr(31 downto 25);
    imm2 := Instr(11 downto 7);
    func3 := Instr(14 downto 12);
end B_slice;

procedure BEQ( 
    rs1: in RegAddrType; --bit_vecctor stored in rs1, and rs2 are SIGNED
    rs2: in RegAddrType;
    imm1: in immType1;
    imm2: in immType2;
    PC: inout integer
) is --immediate first get extended, then shifted left for 1 position, concatinated with 0, then translated and added to the PC
variable Imm: bit_vector(11 downto 0) := imm1(imm1'HIGH) & imm2(imm2'LOW) & imm1(5 downto 0) & imm2(4 downto 1);
--immediate treated as signed value
variable sig_out: BusDataType;
variable branch: integer;
variable Reg1Value: integer := to_integer(SIGNED(Reg(to_integer(UNSIGNED(rs1)))));
variable Reg2Value: integer := to_integer(SIGNED(Reg(to_integer(UNSIGNED(rs2)))));
begin
    signed_extend(Imm, sig_out);
    sig_out := sig_out(BusDataSize - 2 downto 0) & '0';
    branch := to_integer(SIGNED(sig_out));
    if Reg1Value = Reg2Value then
        PC := PC + branch;
    else
        PC := PC + 4;
    end if;
end BEQ;

procedure BNE( --branch if not equal
    rs1: in RegAddrType;
    rs2: in RegAddrType;
    imm1: in immType1;
    imm2: in immType2;
    PC: inout integer
) is 
variable Imm: bit_vector(11 downto 0) := imm1(imm1'HIGH) & imm2(imm2'LOW) & imm1(5 downto 0) & imm2(4 downto 1);
variable sig_out: BusDataType;
variable branch: integer;
variable Reg1Value: integer := to_integer(SIGNED(Reg(to_integer(UNSIGNED(rs1)))));
variable Reg2Value: integer := to_integer(SIGNED(Reg(to_integer(UNSIGNED(rs2)))));
begin
    signed_extend(Imm, sig_out);
    sig_out := sig_out(BusDataSize - 2 downto 0) & '0';
    branch := to_integer(SIGNED(sig_out));
    if Reg1Value /= Reg2Value then
        PC := PC + branch;
    else
        PC := PC + 4;
    end if;
end BNE;

procedure BLT( --branch if not equal
    rs1: in RegAddrType;
    rs2: in RegAddrType;
    imm1: in immType1;
    imm2: in immType2;
    PC: inout integer
) is
variable Imm: bit_vector(11 downto 0) := imm1(imm1'HIGH) & imm2(imm2'LOW) & imm1(5 downto 0) & imm2(4 downto 1);
variable sig_out: BusDataType;
variable branch: integer;
variable Reg1Value: integer := to_integer(SIGNED(Reg(to_integer(UNSIGNED(rs1)))));
variable Reg2Value: integer := to_integer(SIGNED(Reg(to_integer(UNSIGNED(rs2)))));
begin
    signed_extend(Imm, sig_out);
    sig_out := sig_out(BusDataSize - 2 downto 0) & '0';
    branch := to_integer(SIGNED(sig_out));
    if Reg1Value < Reg2Value then
        PC := PC + branch;
    else
        PC := PC + 4;
    end if;
end BLT;

procedure BGE( --branch if not equal
    rs1: in RegAddrType;
    rs2: in RegAddrType;
    imm1: in immType1;
    imm2: in immType2;
    PC: inout integer
) is
variable Imm: bit_vector(11 downto 0) := imm1(imm1'HIGH) & imm2(imm2'LOW) & imm1(5 downto 0) & imm2(4 downto 1);
variable sig_out: BusDataType;
variable branch: integer;
variable Reg1Value: integer := to_integer(SIGNED(Reg(to_integer(UNSIGNED(rs1)))));
variable Reg2Value: integer := to_integer(SIGNED(Reg(to_integer(UNSIGNED(rs2)))));
begin
    signed_extend(Imm, sig_out);
    sig_out := sig_out(BusDataSize - 2 downto 0) & '0';
    branch := to_integer(SIGNED(sig_out));
    if Reg1Value > Reg2Value then
        PC := PC + branch;
    else
        PC := PC + 4;
    end if;
end BGE;

procedure BLTU( --branch if not equal
    rs1: in RegAddrType;
    rs2: in RegAddrType;
    imm1: in immType1;
    imm2: in immType2;
    PC: inout integer
) is
variable Imm: bit_vector(11 downto 0) := imm1(imm1'HIGH) & imm2(imm2'LOW) & imm1(5 downto 0) & imm2(4 downto 1);
variable sig_out: BusDataType;
variable branch: integer;
variable Reg1Value: integer := to_integer(UNSIGNED(Reg(to_integer(UNSIGNED(rs1)))));
variable Reg2Value: integer := to_integer(UNSIGNED(Reg(to_integer(UNSIGNED(rs2)))));
begin
    signed_extend(Imm, sig_out);
    sig_out := sig_out(BusDataSize - 2 downto 0) & '0';
    branch := to_integer(SIGNED(sig_out));
    if Reg1Value < Reg2Value then
        PC := PC + branch;
    else
        PC := PC + 4;
    end if;
end BLTU;


procedure BGEU( --branch if not equal
    rs1: in RegAddrType;
    rs2: in RegAddrType;
    imm1: in immType1;
    imm2: in immType2;
    PC: inout integer
) is
variable Imm: bit_vector(11 downto 0) := imm1(imm1'HIGH) & imm2(imm2'LOW) & imm1(5 downto 0) & imm2(4 downto 1);
variable sig_out: BusDataType;
variable branch: integer;
variable Reg1Value: integer := to_integer(UNSIGNED(Reg(to_integer(UNSIGNED(rs1)))));
variable Reg2Value: integer := to_integer(UNSIGNED(Reg(to_integer(UNSIGNED(rs2)))));
begin
    signed_extend(Imm, sig_out);
    sig_out := sig_out(BusDataSize - 2 downto 0) & '0';
    branch := to_integer(SIGNED(sig_out));
    if Reg1Value > Reg2Value then
        PC := PC + branch;
    else
        PC := PC + 4;
    end if;

end BGEU;


end B_type_functions;
--end section by Jiayi Ma