library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.bit_vec_nat_pack.all;
use IEEE.numeric_bit.ALL;
use work.bitvec_support_pack.ALL;
package cpu_defs_pack is

    constant BusDataSize: natural := 32;
    --constant data_width: natural := 32;
    constant AddrSize: natural := 16;
    constant InstrSize: natural := 32;
    constant RegDataSize: natural := 32;
    constant RegisterAddrSize: natural := 5;
    constant opcode_width: natural := 7;
    constant func3_width: natural:= 3;
    constant func7_width: natural := 7;
    
    subtype BusDataType is bit_vector(BusDataSize -1 downto 0);
    --subtype data_type is  bit_vector(data_width -1 downto 0);
    --subtype RegDataType is bit_vector(RegDataSize - 1 downto 0);
    subtype InstrType is bit_vector(InstrSize - 1 downto 0);
    subtype AddrType is bit_vector(AddrSize downto 0);
    subtype RegAddrType is bit_vector(RegisterAddrSize-1 downto 0);
    subtype opcode_type is bit_vector(opcode_width-1 downto 0);
    subtype func3_type is bit_vector(func3_width-1 downto 0);
    subtype func7_type is bit_vector(func7_width-1 downto 0);
    type MemType is array (4095 downto 0) of bit_vector(BusDataSize - 1 downto 0);
    type RegType is array (2 ** RegisterAddrSize - 1 downto 0) of bit_vector(RegDataSize-1 downto 0) ;
    
    type cmd_MemType is array (2 ** opcode_width - 1 downto 0) of string (1 to 4);
    
    --op_code
    constant code_nop: opcode_type := nat2bit_vec(0, opcode_width); --nat2bit_vec returns 12 bits bit_vector
    constant code_stop: opcode_type := nat2bit_vec(1, opcode_width);
    constant I_Type: opcode_type := "0000011";
    constant I_Type_COMP: opcode_type := "0010011"; --XORI, ANDI, ORI
    constant R_Type: opcode_type := "0110011";
    constant J_type: opcode_type := "1101111";
    constant B_type: opcode_type := "1100011";
    
    constant op_LB, op_BEQ: func3_type := "000";
    constant op_LH, op_SLL, op_SLLI, op_BNE: func3_type := "001";
    constant op_LW: func3_type := "010";
    constant op_LBU, op_XORI, op_XOR, op_BLT: func3_type := "100";
    constant op_LHU, op_SRL, op_SRLI, op_SRA, op_SRAI, op_BGE: func3_type := "101";
    constant op_ORI, op_OR, op_BLTU: func3_type := "110";
    constant op_ANDI, op_AND, op_BGEU: func3_type := "111";
    
    constant op_allZero: func7_type := "0000000"; --XRO, AND, OR, SLL(I), SRL(I)
    constant op_7SRA, op_7SRAI: func7_type := "010000";
    constant op_SLT: func3_type := "";
    constant op_SLTU: func3_type := "";
    

    --command string output
    constant cmd_mem_lookup_table: cmd_MemType := (
        0 => "NOP",
        1 => "STOP",
        others => " "
    );


end cpu_defs_pack;
