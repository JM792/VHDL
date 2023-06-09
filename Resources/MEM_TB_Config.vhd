
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use work.all;
configuration MEM1_TB_Config of memory_1_TEST is
for TB
end for;
end MEM1_TB_Config;


configuration MEM1_TB_Config of memory_1_TEST is 
for TB
    for 
    UUT1: MEM1
        use entity work.memory_1(Behavioral)
    port map(
    w_en => w_en_C,
    data_in => data_in_C,
    data_out => data_out_C,
    addr => addr_C
   
    );
    end for;
end for;
end MEM1_TB_Config;


--configuration MEM2_TB_Config of memory_2_TEST is
--for TB
--    for 
--    UUT2: RAM2
--    use entity work.memory_2(Behavioral)
--    port map(
--    w_en => w_en,
--    data_in => data_in,
--    data_out => data_out,
--    addr => addr
    
--    );
--    end for;
--end for;

--end MEM2_TB_Config;

