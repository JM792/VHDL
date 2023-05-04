----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.04.2023 23:58:23
-- Design Name: 
-- Module Name: memory_2 - Behavioral
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

entity memory_2 is
    Port ( w_en : in boolean;
           data_in : in integer range 4095 downto 0;
           addr : in integer range 4095 downto 0;
           data_out : out integer range 4095 downto 0);
end memory_2;

architecture Behavioral of memory_2 is
begin
process(addr, data_in, w_en)
    type memo_type is array (integer range 4095 downto 0) of integer range 4095 downto 0;
    variable Mem: memo_type;
    
    
begin
    if w_en then --if true then assign data to the address
        Mem(addr) := data_in;
    end if;
    data_out <= Mem(addr);
    
end process;
end Behavioral;
