
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_bit.all;

entity memory_1 is
    Port ( w_en : in bit;
           data_in : in bit_vector (11 downto 0);
           addr : in bit_vector (11 downto 0);
           data_out : out bit_vector (11 downto 0));
end memory_1;

architecture Behavioral of memory_1 is
begin 
process(w_en, data_in, addr)
    type memo_type is array (integer range 0 to 4065) of bit_vector(11 downto 0);
    variable Mem: memo_type;
begin
--convert memory address from 12 bit_vector to integer
    if w_en = '1' then
    Mem(to_integer(UNSIGNED(addr))) := data_in;
    end if;
    data_out <= Mem(to_integer(UNSIGNED(addr)));
end process;

end Behavioral;
