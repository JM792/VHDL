
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_bit.all;


package bit_vec_nat_pack is
    subtype number_range is natural range 0 to 4095;
    function nat2bit_vec (nat: number_range)
        return bit_vector; 
end bit_vec_nat_pack;


package body bit_vec_nat_pack is 
    function nat2bit_vec (nat: number_range) return bit_vector is
    variable tmp: natural := nat;
    variable result: bit_vector(12 downto 0);
    begin
        for i in 0 to 11 loop
            result(i) := bit'val(tmp mod 2);
            tmp := tmp/2;
            end loop;
            assert tmp = 0;
         
    return result;
    end nat2bit_vec;
end bit_vec_nat_pack;

entity memory_1_TEST is 
end memory_1_TEST;

architecture TB of memory_1_TEST is
component MEM1 is
    Port ( 
    w_en_C: in bit;
    addr_C: in bit_vector(11 downto 0);
    data_in_C: in bit_vector(11 downto 0);
    data_out_C: out bit_vector(11 downto 0) 
    );
    end component;
   
subtype constrained_bit_vec is bit_vector(11 downto 0);
signal w_en_s: bit := '0';
signal addr_s, data_to_memo, data_from_memo: constrained_bit_vec;

begin
UUT1: MEM1
port map (w_en_s, addr_s, data_to_memo, data_from_memo);

process
    use WORK.bit_vec_nat_pack.all;
    type mem_type is array(natural range 0 to 4095) of constrained_bit_vec;
    variable Mem: mem_type; 
     
begin
--reset memo
for addr_index in 0 to 4095 loop
    addr_s <= nat2bit_vec(addr_index);
    data_to_memo <= (others => '0');
    w_en_s <= '1'; wait for 5 ns;
    w_en_s <= '0'; wait for 5 ns;
end loop;

for data_num in 0 to 4095 loop
    for addr_index in 0 to 4095 loop    
        if addr_index = data_num then
            addr_s <= nat2bit_vec(addr_index);
            data_to_memo <= nat2bit_vec(data_num);
            w_en_s <= '1'; wait for 5 ns;
            w_en_s <= '0'; wait for 5 ns;  
        for r_addr_index in 0 to 4095 loop
            if r_addr_index /= addr_index then
                addr_s <= nat2bit_vec(r_addr_index);
                w_en_s <= '0'; wait for 5 ns;
                assert data_from_memo = X"000";
            else 
                addr_s <= nat2bit_vec(r_addr_index);
                w_en_s <= '0'; wait for 5 ns;
                assert data_from_memo = nat2bit_vec(data_num);
            end if;
        
        end loop;          
        end if;
    end loop;
end loop;

end process;
end TB;


