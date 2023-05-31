library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



package mem_instruction is
use WORK.cpu_defs_pack.all;
function init_memory return mem_type;
end mem_instruction;

package body mem_instruction is
    function init_memory return mem_type is
begin
    return
        ( -- instruction code
        0 => X"00000000",
        1 => X"00000001", 
        others => X"00000000");
end init_memory;


end mem_instruction;