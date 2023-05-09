

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity memory_2_TEST is
end memory_2_TEST;

architecture TB of memory_2_TEST is
component RAM2
port(
       w_en : in boolean;
       data_in : in integer range 4095 downto 0;
       addr : in integer range 4095 downto 0;
       data_out : out integer range 4095 downto 0);
end component;

signal w_en_s: boolean := false;
signal addr_s, data_to_memo, data_from_memo: integer range 4095 downto 0;

begin
UUT2: RAM2
port map(
    w_en => w_en_s,
    data_in => data_to_memo,
    addr => addr_s,
    data_out => data_from_memo);
    process
--reset all memory to 0
    begin
    for addr_v in 0 to 4095 loop
        addr_s <= addr_v;
        data_to_memo <= 0;
        w_en_s <= true; wait for 1 ns;
        w_en_s <= false; wait for 1 ns;
        assert data_from_memo = 0 report "memory not erased" severity warning;
    end loop;

--set data same as address
    for data_num in 0 to 4095 loop
        addr_s <= data_num;
        data_to_memo <= data_num;
        w_en_s <= true; wait for 1 ns;
        w_en_s <= false; wait for 1 ns;
     
    end loop;

--check data are same
    for addr_index in 0 to 4095 loop
        addr_s <= addr_index;
        w_en_s <= false; wait for 1 ns;
        assert data_from_memo = addr_index report "wrong output signal" severity warning ;
    end loop;   

    wait;
    end process;
    
end TB;
