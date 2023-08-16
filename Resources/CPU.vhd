
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

--initialization
variable execute: boolean := true;
variable Memory: MemType := init_memory;
variable OP: opcode_type;
variable Imm: bit_vector;
variable Instr: bit_vector;
variable func3: func3_type;
variable func7: func7_type;
variable PC: integer := 0;
variable rd, rs, rs1, rs2: RegAddrType;


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
                when op_LB => LB(Memory,rs,rd,Imm);
                when op_LH => LH(Memory,rs,rd,Imm);
                when op_LW => LW(Memory,rs,rd,Imm);
                when op_LBU => LBU(Memory,rs,rd,Imm);
                when op_LHU => LHU(Memory,rs,rd,Imm);
            end case;            
        when I_Type_COMP =>
            I_slice(Instr, rs, rd, Imm, func3);
            case func3 is
                when op_XORI => 
                when op_ORI =>
                when op_ANDI => 
        when R_Type =>
            R_slice(Instr, rs1, rs2, rd, func3, func7);
            case func7 is
                when op_allZero => --do compare and arithmetic operations
                    case func3 is
                        when op_SLT => SLT(rs1, rs2, rd);
                        when op_SLTU => SLTU(rs1, rs2, rd);
                        when op_SLL => 
                        when op_SRL =>                  
                        when op_OR => 
                        when op_AND =>
                        when op_XOR =>
                    end case;
                when op_7SRA | op_7SRAI =>
                    case func3 is
                        when op_SRA =>
                        when op_SRAI =>
                     
                    end case;
            end case;
        when S_Type => 
            S_slice();
        when J_Type =>
            J_slice();
        when B_Type =>
            B_slice();
            case func3 is
                when op_BEQ =>
                when op_BNE =>
                when op_BLT =>
                when op_BGE =>
                when op_BLTU =>
                when op_BGEU =>
            
            end case;
    --in case of overflow (at the last address)
    when others => assert  False report "Illegal Operation" severity Error;
    PC := (PC + 1) mod 2 ** AddrSize; --replace by function call INC(PC)
    end case;
end loop;

wait;
end process;

end Behavioral;
