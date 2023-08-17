--begin section Jiayi Ma
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use std.textio.ALL;
use IEEE.numeric_bit.ALL;

--memory initialization
--memory getter and setter


package mem_pack is
use WORK.cpu_defs_pack.all;


function init_memory return MemType;

function get( --read memory from addr, get data
    constant Memory: in MemType;
    constant addr: in AddrType
) return BusDataType;

--initialize  memory using fileIO (procedure)
procedure mem_init(
variable f: in text;
variable mem: out MemType
);

procedure set(
    variable Memory: inout MemType;
    constant addr: in AddrType;
    constant data: in BusDataType
);



end mem_pack;





package body mem_pack is
    function init_memory return MemType is
begin
    return
        ( -- instruction code
        0 => X"00000000",
        1 => X"00000001", 
        others => X"00000000");
end init_memory;

procedure mem_init(
variable f: in text;
variable mem: out MemType
) is
begin

end mem_init;


function get( --read memory from addr, get data
    constant Memory: in MemType;
    constant addr: in AddrType
) return BusDataType is
begin
    return Memory(to_integer(UNSIGNED(addr)));
end get; 

procedure set(
    variable Memory: inout MemType;
    constant addr: in AddrType;
    constant data: in BusDataType
) is 
begin
    Memory(to_integer(UNSIGNED(addr))) := data;
end set;



end mem_pack;
--end section Jiayi Ma