--begin section by Jiayi Ma
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use WORK.cpu_defs_pack.ALL;
use std.textio.ALL;
use IEEE.numeric_bit.all;



package fileio_support_pack is

function to_hex(d: integer) return string; --convert PC to 3 digit number
function to_cmd(o: bit_vector) return string; --convert OP to operation string
function bool_char(d: boolean) return character;


procedure write_PC_CMD (
     variable l: inout line;
     constant PC: in integer;
     constant OP: in bit_vector;
     constant X, Y, Z: in RegAddrType --5 bit
);
   
procedure print_tail (
    variable f: out text
);

procedure print_head(
    variable f: out text
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

function bool_char(d: boolean) return character is
begin
    if d then return 'T';
    else return 'F';
    end if;
end bool_char;

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

procedure write_PC_CMD (
     variable l: inout line;
     constant PC: in integer;
     constant OP: in bit_vector;
     constant X, Y, Z: in RegAddrType
) is 

    begin
         write(l, to_hex(PC), left, 3); --represent 12 bit PC
         write(l, string'("|"));
         write(l, to_cmd(OP), left, 4);
         write(l, string'("|"));
     --register values
         --in case of registers not being used:
         write(l, X, left, 5);
         write(l, string'("|"));
         write(l, Y, left, 5);
         write(l, string'("|"));
         write(l, Z, left, 5);
         write(l, string'("|"));
end write_PC_CMD;


procedure print_tail (
    variable f: out text --f as pointer to the file (file handle)
) is 
    variable l: line;
begin
    write(l, string'("----------------------------------------------"));
    writeline(f, l); --write line l to file f, auto add newline character in the end of line

end print_tail;

procedure print_head(
    variable f: out text
) is 
    variable l: line;
begin

    write(l, string'("PC"), left, 3);
    write(l, string'("|"));
    write(l, string'("OP"), left, 4);
    write(l, string'("|"));
    write(l, string'("X"), left, 5);
    write(l, string'("|"));
    write(l, string'("Y"), left, 5);
    write(l, string'("|"));
    write(l, string'("Z"), left, 5);
    writeline(f, l);
    write(l, string'("----------------------------------------------"));
    writeline(f, l);
   
end print_head;


end fileio_support_pack;
--end section by Jiayi Ma