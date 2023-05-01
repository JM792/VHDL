----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.04.2023 12:42:34
-- Design Name: 
-- Module Name: MEM_TB_Config - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
configuration MEM1_TB_Config of memory_1_TEST is 
for TB
    for 
    UUT1: MEM1
        use entity WORK.memory_1(Behavioral)
    port map(
    w_en => w_en_C,
    data_in => data_in_C,
    data_out => data_out_C,
    addr => addr_C
   
    );
    end for;
end for;
end MEM1_TB_Config;

configuration MEM2_TB_Config of memory_2_TEST is
    for TB
        for 
        UUT2: RAM2
        use entity WORK.memory_2(Behavioral)
        port map(
        addr => addr,
        data_in => data_in,
        data_out => data_out,
        w_en => w_en
        
        );
        end for;
    end for;
end MEM2_TB_Config;
