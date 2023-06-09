
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity CPU is
--  Port ( );
end CPU;

architecture Behavioral of CPU is

begin



process
use std.textio.all;
use work.cpu_defs_pack.all;
use work.mem_pack.all;
use work.register_init.all;
use work.I_Type_functions.all;
use work.R_Type_functions.all;
variable execute: boolean := true;
variable Mem_Instr: mem_type := init_memory;
variable OP: bit_vector;
variable Imm: bit_vector;
variable Instr: bit_vector;
variable func3: func3_type;
variable func7: func7_type;
variable PC: integer := 0;
variable rd, rs, rs1, rs2: reg_addr_type;


begin

Instr := Memory(PC); --replace by function call get(Memory, PC) with fileio
OP := Instr(opcode_width-1 downto 0);

while execute loop
--cmd fetch and decode


--TODO: AND and NOT operator redefine
--set flag function
    case OP is
        when code_stop => execute := false;
        when code_nop => null; --nothing has to be done
        when I_Type => 
            I_slice(Instr, rs, rd, Imm, func3);
            case func3 is
                when op_LB => LB(rs,rd,Imm);
                when op_LH => LH(rs,rd,Imm);
                when op_LW => LW(rs,rd,Imm);
                when op_LBU => LBU(rs,rd,Imm);
                when op_LHU => LHU(rs,rd,Imm);
            end case;
        when R_Type =>
            R_slice(Instr, rs1, rs2, rd, func3, func7);
            case func7 is
                when op_COMP => --do compare and arithmetic operations
                    case func3 is
                        when op_SLT => SLT(rs1, rs2, rd);
                        when op_SLTU => SLTU(rs1, rs2, rd);
                    end case;
            end case;
    --in case of overflow (at the last address)
    when others => assert  False report "Illegal Operation" severity Error;
    PC := (PC + 1) mod 2 ** addr_width; --replace by function call INC(PC)
    end case;
end loop;

wait;
end process;

end Behavioral;
