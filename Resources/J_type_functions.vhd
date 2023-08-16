
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

package J_type_functions is
use WORK.cpu_defs_pack.all;
use WORK.register_init.all;
use WORK.extension_pack.all;

procedure J_slice(
Instr: in InstrType;
rd: out RegAddrType;
Imm: out std_logic_vector(19 downto 0)
);

procedure JAL(
PC: in integer;
rd: in RegAddrType;
Imm: in std_logic_vector;
t_addr: out natural
);



end J_type_functions;


package body J_type_functions is

procedure J_slice(
Instr: in InstrType;
rd: out RegAddrType;
Imm: out std_logic_vector(19 downto 0)
) is 
variable part1, part3: std_logic;
variable part2, part4: std_logic_vector;

begin
rd := Instr(11 downto 7);
part1 := Instr(31); part3 := Instr(20);
part2 := Instr(30 downto 21); part4 := Instr(19 downto 12);
Imm := part4 & part3 & part2 & part1;

end J_slice;

procedure JAL(
PC: in integer;
rd: in RegAddrType;
Imm: in std_logic_vector;
t_addr: out natural
) is
begin

--store PC+4 into register rd as instruction following JAL
Reg(to_integer(UNSIGNED(rd))) := std_logic_vector(to_unsigned(PC + 4, 32));
--Imm specifies the offsets of targeted address relative to current instruction
t_addr := PC + to_integer(SIGNED(Imm)) - 1;
end JAL;



end J_type_functions;