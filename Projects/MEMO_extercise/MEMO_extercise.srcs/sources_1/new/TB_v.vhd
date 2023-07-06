library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_bit.all;

--create function (make the function general)
package bit_vec_nat_pack is
    subtype number_range is natural range 0 to 4095;
    function nat2bit_vec (nat: number_range)
        return bit_vector; 
end bit_vec_nat_pack;


package body bit_vec_nat_pack is 
    function nat2bit_vec (nat: number_range) return bit_vector is
    variable tmp: natural := nat;
    variable result: bit_vector(11 downto 0);
    begin
        for i in 0 to 11 loop
            result(i) := bit'val(tmp mod 2);
            tmp := tmp/2;
            end loop;
            assert tmp = 0;
    return result;
    end nat2bit_vec;
end bit_vec_nat_pack;
--end function


--start test
entity TB_v is

end TB_v;

architecture TEST of TB_v is
component memory_1 is
    Port ( 
    w_en: in bit;
    addr: in bit_vector(11 downto 0);
    data_in: in bit_vector(11 downto 0);
    data_out: out bit_vector(11 downto 0) 
    );
    end component;
component memory_2 is
port(
    w_en: in bit;
    addr: in bit_vector(11 downto 0);
    data_in: in bit_vector(11 downto 0);
    data_out: out bit_vector(11 downto 0));
end component;

signal w_en: bit;
signal addr_s, data_to_memo, data_from_memoA, data_from_memoB: bit_vector(11 downto 0);

begin
TEST1: memory_1
port map(
w_en => w_en, 
addr => addr_s, 
data_in => data_to_memo, 
data_out => data_from_memoA);

TEST2: memory_2
port map(w_en => w_en, 
addr => addr_s, 
data_in => data_to_memo,
data_out => data_from_memoB);

process is
use work.bit_vec_nat_pack.all; 

begin    
--remove memo from both memory blocks
for number in 0 to 4095 loop
    addr_s <= nat2bit_vec(number);
    data_to_memo <= X"000"; -- reset all memo to 0
    w_en <= '1'; wait for 1 ns;
    w_en <= '0'; wait for 1 ns;
end loop;

--write memory 1 and 2
for data_num in 0 to 4095 loop
        addr_s <= nat2bit_vec(data_num);
        data_to_memo <= nat2bit_vec(data_num);
        w_en <= '1'; wait for 1 ns;
        w_en <= '0'; wait for 1 ns; 
end loop;

--check data
for addr_index in 0 to 4095 loop
        addr_s <= nat2bit_vec(addr_index);     
        w_en <= '0'; wait for 1 ns;
        assert data_from_memoA = nat2bit_vec(addr_index) report "memory wrong in RAM1" severity warning;
        assert data_from_memoB = addr_s report "memory wrong in RAM2" severity warning;
        assert data_from_memoB = data_from_memoA report "memory not the same" severity warning;
end loop;
wait;
end process;
end TEST;
