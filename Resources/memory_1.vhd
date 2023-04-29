----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.04.2023 20:28:19
-- Design Name: 
-- Module Name: memory_1 - Behavioral
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

entity memory_1 is
    Port ( w_en : in STD_LOGIC;
           data_in : in STD_LOGIC_VECTOR (0 downto 0);
           addr : in STD_LOGIC_VECTOR (0 downto 0);
           data_out : out STD_LOGIC_VECTOR (0 downto 0));
end memory_1;

architecture Behavioral of memory_1 is

begin


end Behavioral;
