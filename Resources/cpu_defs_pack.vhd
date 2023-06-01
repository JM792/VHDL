library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.bit_vec_nat_pack.all;

package cpu_defs_pack is

constant bus_width: natural := 32;
constant data_width: natural := 32;
constant addr_width: natural := 12;
constant instr_width: natural := 32;
constant regData_width: natural := 32;
constant reg_width: natural := 5;
constant opcode_width: natural := 7;
constant func3_width: natural:= 3;
constant func7_width: natural := 7;

subtype bus_type is bit_vector(bus_width -1 downto 0);
subtype data_type is  bit_vector(data_width -1 downto 0);
subtype addr_type is bit_vector(addr_width downto 0);
subtype reg_addr_type is bit_vector(reg_width-1 downto 0);
subtype opcode_type is bit_vector(opcode_width-1 downto 0);
subtype func3_type is bit_vector(func3_width-1 downto 0);
subtype func7_type is bit_vector(func7_width-1 downto 0);
type mem_type is array (4095 downto 0) of bit_vector(data_width-1 downto 0);
type reg_type is array (reg_width**2-1 downto 0) of bit_vector(regData_width-1 downto 0) ;

--op_code
constant code_nop: opcode_type := nat2bit_vec(0)(opcode_width-1 downto 0) ; --nat2bit_vec returns 12 bits bit_vector
constant code_stop: opcode_type := nat2bit_vec(1)(opcode_width-1 downto 0) ;
constant I_Type: opcode_type := "0000011";
constant R_Type: opcode_type := "0110011";

constant op_LB: func3_type := "000";
constant op_LH: func3_type := "001";
constant op_LW: func3_type := "010";
constant op_LBU: func3_type := "100";
constant op_LHU: func3_type := "101";

constant op_COMP: func7_type := "0000000";
constant op_SLT: func3_type := "";
constant op_SLTU: func3_type := "";
end cpu_defs_pack;
