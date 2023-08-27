--begin section Jiayi Ma
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use std.textio.ALL;
use IEEE.numeric_bit.ALL;

--memory initialization
--memory getter and setter
use WORK.cpu_defs_pack.all;

package mem_pack is



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

use WORK.cpu_defs_pack.all;
package mem_rw_package is

procedure memory_write( --pass signal changes to the components
    constant Td: in time;
    constant w_addr: in AddrType;
    constant w_data: in BusDataType;
    signal w_en: out boolean;
    signal addr: out AddrType;
    signal data_to_memo: out BusDataType
);


procedure memory_read(
    constant Td: in time;
    constant r_addr: in AddrType;
    variable r_data: out BusDataType;
    signal w_en: out boolean;
    signal addr: out AddrType;
    signal data_from_memo: in BusDataType
);
end mem_rw_package;

package body mem_rw_package is

procedure memory_write(
    constant Td: in time;
    constant w_addr: in AddrType;
    constant w_data: in BusDataType;
    signal w_en: out boolean;
    signal addr: out AddrType;
    signal data_to_memo: out BusDataType
) is
begin
    assert Td > 0 ns;
    addr <= w_addr;
    data_to_memo <= w_data;
    w_en <= TRUE;
    wait for Td;
    w_en <= FALSE;
    wait for Td;
end memory_write;

procedure memory_read(
    constant Td: in time;
    constant r_addr: in AddrType;
    variable r_data: out BusDataType;
    signal w_en: out boolean;
    signal addr: out AddrType;
    signal data_from_memo: in BusDataType
) is 
begin
    assert Td > 0 ns;
    addr <= r_addr;
    w_en <= FALSE;
    wait for Td;
    r_data := data_from_memo;
    wait for Td;
end memory_read;


end mem_rw_package;




--end section Jiayi Ma