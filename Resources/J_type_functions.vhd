--begin section by Jiayi Ma
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use WORK.bitvec_support_pack.ALL;
use WORK.cpu_defs_pack.all;
use WORK.register_init.all;
use WORK.extension_pack.all;

package J_type_functions is


procedure J_slice(
Instr: in InstrType;
rd: out RegAddrType;
Imm: out bit_vector(19 downto 0)
);

procedure JAL(
PC: inout integer;
rd: in RegAddrType; --store return address
Imm: in bit_vector(19 downto 0) --20 bit signed immediate value
);

end J_type_functions;







package body J_type_functions is

procedure J_slice(
Instr: in InstrType;
rd: out RegAddrType;
Imm: out bit_vector(19 downto 0)
) is 
variable part1, part3: bit;
variable part2, part4: bit_vector;

begin
rd := Instr(11 downto 7);
part1 := Instr(31); part3 := Instr(20);
part2 := Instr(30 downto 21); part4 := Instr(19 downto 12);
Imm := part4 & part3 & part2 & part1;

end J_slice;



procedure JAL(
    PC: inout integer;
    rd: in RegAddrType; --store return address
    Imm: in bit_vector(19 downto 0) --20 bit signed immediate value
) is
    variable regAddr: integer := to_integer(UNSIGNED(rd));
begin
    --store PC+4 into register rd as instruction following JAL
    Reg(regAddr) := nat2bit_vec(PC + 4, 32);
    --Imm specifies the offsets of targeted address relative to current instruction
    PC := PC + to_integer(SIGNED(Imm)) - 1;
end JAL;


end J_type_functions;
--end section by Jiayi Ma