--begin section by Jiayi Ma
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.cpu_defs_pack.ALL;


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


end B_type_functions;





--end section by Jiayi Ma