

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

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

signal w_en_s: boolean;
signal addr_s, data_to_memo, data_from_memo: integer range 4095 downto 0;

begin
UUT2: RAM2
port map(w_en_s, data_to_memo, addr_s);
    process
--reset all memory to 0
    begin
    for addr_v in 0 to 4095 loop
        addr_s <= addr_v;
        data_to_memo <= 0;
        w_en_s <= true; wait for 5 ns;
        w_en_s <= false; wait for 5 ns;
    end loop;
    
    
    for data_s in 0 to 4095 loop
        for addr_index in 0 to 4095 loop
            
                addr_s <= addr_index;
                data_to_memo <= data_s;
                w_en_s <= true; wait for 5 ns;
                w_en_s <= false; wait for 5 ns;
           
            
            for addr_v in 0 to 4095 loop
            --if the address is not the correct address, data_from_memo should be 0
                if addr_v /= addr_index then
                    addr_s <= addr_v;
                    w_en_s <= false;  wait for 5ns;
                    assert data_from_memo = 0;
                    
                else 
                    addr_s <= addr_v;
                    w_en_s <= false; wait for 5 ns;
                    assert data_from_memo = data_s;
                end if;
                addr_s <= addr_v;
        data_to_memo <= 0;
        w_en_s <= true; wait for 5 ns;
        w_en_s <= false; wait for 5 ns;
                end loop;      
            end loop;   
        end loop;
    end process;
end TB;
