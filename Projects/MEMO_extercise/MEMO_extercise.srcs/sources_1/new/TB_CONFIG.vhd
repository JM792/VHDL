----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.05.2023 22:22:49
-- Design Name: 
-- Module Name: TB_CONFIG - Behavioral
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
use work.all;



configuration TB_CONFIG of memory_v_TEST is
for TB_v
    for 
    TEST1: RAMa
    use entity work.memory_1(Behavioral);
    end for;
    
    for 
    TEST2: RAMb
    use entity work.memory_3(Behavioral);

    end for;
end for;
end TB_CONFIG;

