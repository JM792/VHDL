--begin section by Jiayi Ma
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_bit.all;
use WORK.cpu_defs_pack.ALL;
use WORK.register_init.ALL;
use WORK.extension_pack.ALL;


package S_type_functions is 

subtype immType1 is bit_vector(6 downto 0);
subtype immType2 is bit_vector(4 downto 0);
subtype ImmType is bit_vector(11 downto 0);

procedure S_slice(
    Instr: in Instrtype;
    imm1: out immType1;
    imm2: out immType2;
    rs1: out RegAddrType;
    rs2: out RegAddrType;
    func3: out func3_type
);

procedure Imm_concat(
    imm1: in immType1;
    imm2: in immType2;
    Imm: out Immtype
);

procedure SW (
    Imm: in ImmType;
    rs1: in RegAddrType;
    rs2: in RegAddrType;
    Memory: inout MemType
);

procedure SH (
    Imm: in ImmType;
    rs1: in RegAddrType;
    rs2: in RegAddrType;
    Memory: inout MemType
);

procedure SB (
    Imm: in ImmType;
    rs1: in RegAddrType;
    rs2: in RegAddrType;
    Memory: inout MemType
);

end S_type_functions;





package body S_type_functions is

procedure S_slice(
    Instr: in Instrtype;
    imm1: out immType1;
    imm2: out immType2;
    rs1: out RegAddrType;
    rs2: out RegAddrType;
    func3: out func3_type
) is
begin
    imm1 := Instr(31 downto 25);
    imm2 := Instr(11 downto 7);
    rs1 := Instr(19 downto 15);
    rs2 := Instr(24 downto 20);
    func3 := Instr(14 downto 12);
end S_slice;

procedure Imm_concat(
    imm1: in immType1;
    imm2: in immType2;
    Imm: out ImmType
) is
begin
    Imm := imm1 & imm2;
end IMM_concat;

procedure SW (
    Imm: in ImmType;
    rs1: in RegAddrType;
    rs2: in RegAddrType;
    Memory: inout MemType
) is
    variable mem_addr: integer := to_integer(UNSIGNED(Reg(to_integer(UNSIGNED(rs1))))) + to_integer(SIGNED(Imm));
    variable RegValue: BusDataType := Reg(to_integer(UNSIGNED(rs2)));
begin
    Memory(mem_addr) := RegValue;
end SW;

procedure SH (
    Imm: in ImmType;
    rs1: in RegAddrType;
    rs2: in RegAddrType;
    Memory: inout MemType
)is 
    variable mem_addr: integer := to_integer(UNSIGNED(Reg(to_integer(UNSIGNED(rs1))))) + to_integer(SIGNED(Imm));
    variable RegValue: bit_vector(BusDataSize/2 - 1 downto 0) := Reg(to_integer(UNSIGNED(rs2)))(BusDataSize/2 - 1 downto 0);
begin
    
    Memory(mem_addr)(BusDataSize/2 - 1 downto 0) := RegValue;
end SH;

procedure SB (
    Imm: in ImmType;
    rs1: in RegAddrType;
    rs2: in RegAddrType;
    Memory: inout MemType
)is
    variable mem_addr: integer := to_integer(UNSIGNED(Reg(to_integer(UNSIGNED(rs1))))) + to_integer(SIGNED(Imm));
    variable RegValue: bit_vector(BusDataSize/4 - 1 downto 0) := Reg(to_integer(UNSIGNED(rs2)))(BusDataSize/4 - 1 downto 0);
begin
    Memory(mem_addr)(BusDataSize/4 - 1 downto 0) := RegValue;
end SB;

end S_type_functions;
--end section by Jiayi Ma