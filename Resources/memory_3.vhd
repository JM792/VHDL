
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_bit.all;

entity memory_3 is
    Port ( w_en : in bit;
           data_in : in bit_vector (11 downto 0);
           addr : in bit_vector (11 downto 0);
           data_out : out bit_vector (11 downto 0)
           );
end memory_3;

architecture Behavioral of memory_3 is

begin
process(w_en, data_in, addr)
type memo_type is array (natural range 0 to 4095) of natural range 0 to 4095;
variable Mem: memo_type;
variable addr_nat, data_in_nat: natural;
    use work.bit_vec_nat_pack.all; 
begin 
    addr_nat := to_integer(UNSIGNED(addr));
    data_in_nat := to_integer(UNSIGNED(data_in));
    if w_en = '1' then
    Mem(addr_nat) := data_in_nat;
    end if;
    data_out <= nat2bit_vec(Mem(addr_nat));


end process;

end Behavioral;
