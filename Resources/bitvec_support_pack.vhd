library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package bitvec_support_pack is
--natural to bit_vector conversion of arbituaty length
    subtype number_range is natural range 0 to 4095;
    subtype length is natural range 0 to 32;
    function nat2bit_vec (nat: number_range; len: length)
        return bit_vector; 
        
--shifting 


--rotation




end bitvec_support_pack;


package body bitvec_support_pack is 

function nat2bit_vec (nat: number_range; len: length) return bit_vector is
    variable tmp: natural := nat;
    variable result: bit_vector(2 ** len - 1 downto 0);
    begin
        for i in 0 to 2 ** len - 1 loop
            result(i) := bit'val(tmp mod 2);
            tmp := tmp/2;
            end loop;
            assert tmp = 0;
    return result;
    end nat2bit_vec;

end bitvec_support_pack;
