--begin section by Jiayi Ma

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use WORK.cpu_defs_pack.ALL;
use std.textio.ALL;
use IEEE.numeric_bit.all;
--offering support while formulating the output file


package fileio_support_pack is

function to_hex(d: integer) return string; --convert PC to 3 digit number
function to_cmd(o: bit_vector) return string; --convert OP to operation string
function bool_char(d: boolean) return character;


procedure write_PC_CMD (
     variable l: inout line;
     constant PC: in integer;
     constant OP: in bit_vector;
     constant X, Y, Z: in reg_addr_type
);
   

end fileio_support_pack;



package body fileio_support_pack is 

function to_hex(d: integer) -- PC value natural type
        return string is
        constant hex_table: string(1 to 16) :=  "0123456789ABCDEF";
        variable result: string(1 to 3);
    begin
        result(3) := hex_table(d mod 16 + 1);
        result(2) := hex_table((d / 16) mod 16 + 1);
        result(1) := hex_table ((d / 256) mod 16 + 1);
        return result;
end to_hex;


function to_cmd(o: bit_vector)
    return string is
begin 
    case o is
    when code_nop => return cmd_mem_lookup_table(to_integer(UNSIGNED(code_nop)));
    when code_stop => return cmd_mem_lookup_table(to_integer(UNSIGNEd(code_stop)));
    
    when others =>  
        assert False
        report "Illegal Operation"
        severity Waring;
        return "";
    end case;
end to_cmd;

function bool_char(d: boolean) 
    return character is
begin 
    if d then return 'T';
    else return 'F';
    end if;
end bool_char;

procedure write_PC_CMD (
     variable l: inout line;
     constant PC: in integer;
     constant OP: in bit_vector;
     constant X, Y, Z: in reg_addr_type
) is 

    begin
         write(l, to_hex(PC), left, 3);
         write(l, string'("|"));
         write(l, to_cmd(OP), left, 4);
         write(l, string'("|"));
     --register values
         --in case of registers not being used:

         write(l, string'("|"));
         write(l, Y, left, 3);
         write(l, string'("|"));
         write(l, Z, left, 3);
         write(l, string'("|"));
end write_PC_CMD;


end fileio_support_pack;

--end section by Jiayi Ma