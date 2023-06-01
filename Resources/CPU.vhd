
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity CPU is
--  Port ( );
end CPU;

architecture Behavioral of CPU is

begin



process
use work.cpu_defs_pack.all;
use work.mem_pack.all;
use work.register_init.all;
use work.I_Type_functions.all;
variable execute: boolean := true;
variable Mem_Instr: mem_type := init_memory;
variable OP: bit_vector;
variable Imm: bit_vector;
variable Instr: bit_vector;
variable func3: func3_type := Instr(14 downto 12);
variable PC: integer := 0;
variable rd, rs: reg_addr_type;


begin
while execute loop
--cmd fetch and decode
Instr := Memory(PC);
OP := Instr(opcode_width-1 downto 0);

    case OP is
        when code_stop => execute := false;
        when code_nop => null;
        when I_Type => 
            I_slice(Instr, rs, rd, Imm, func3);
            case func3 is
                when op_LB => LB(rs,rd,Imm);
                when op_LH => LH(rs,rd,Imm);
                when op_LW => LW(rs,rd,Imm);
                when op_LBU => LBU(rs,rd,Imm);
                when op_LHU => LHU(rs,rd,Imm);
            end case;
    PC := PC + 1;
    end case;
end loop;

wait;
end process;

end Behavioral;
