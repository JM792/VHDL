library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use std.textio.ALL;
use IEEE.numeric_bit.ALL;

--memory initialization
--memory getter and setter


package mem_pack is
use WORK.cpu_defs_pack.all;
function init_memory return mem_type;
shared variable Memory: mem_type := (
0 => X"00000000",
1 => X"00000000"

);

function get( --read memory from addr, get data
    constant Memory: in mem_type;
    constant addr: in addr_type
) return data_type;

--initialize  memory using fileIO (procedure)
procedure mem_init(
variable f: in text;
variable mem: out mem_type
);

procedure set(
    variable Memory: inout mem_type;
    constant addr: in addr_type;
    constant data: in data_type
);



end mem_pack;





package body mem_pack is
    function init_memory return mem_type is
begin
    return
        ( -- instruction code
        0 => X"00000000",
        1 => X"00000001", 
        others => X"00000000");
end init_memory;

procedure mem_init(
variable f: in text;
variable mem: out mem_type
) is
begin

end mem_init;


function get( --read memory from addr, get data
    constant Memory: in mem_type;
    constant addr: in addr_type
) return data_type is
begin
    return Memory(to_integer(UNSIGNED(addr)));
end get; 

procedure set(
    variable Memory: inout mem_type;
    constant addr: in addr_type;
    constant data: in data_type
) is 
begin
    Memory(to_integer(UNSIGNED(addr))) := data;
end set;



end mem_pack;