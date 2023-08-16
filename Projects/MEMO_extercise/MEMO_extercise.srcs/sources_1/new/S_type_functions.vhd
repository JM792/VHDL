
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_bit.all;
--begin sectoin by Jiayi Ma


package S_type_functions is 

procedure S_slice(

);
-- end section by Jiayi Ma

--begin section by Mostafa Deyab
function StoreInstruction(opcode : string;
                          rs1    : RegAddrType;
                          rs2    : RegAddrType;
                          imm    : signed) return std_logic_vector;
--end sectio nby Mostafa Deyab
end S_type_functions;

package body S_type_functions is
--begin section by Jiayi Ma



--end section by Jiayi Ma

--begin section by Mostafa Deyab
function StoreInstruction(opcode : string;
                          rs1    : RegAddrType;
                          rs2    : RegAddrType;
                          imm    : signed) return std_logic_vector is
begin
    if opcode = "SW" then
        -- Store Word (SW)
         mem(to_integer(unsigned(rs1)) + to_integer(imm(ADDR_WIDTH-1 downto 2))) <= rs2;
        return rs2;
    elsif opcode = "SH" then
        -- Store Half Word (SH)
         mem(to_integer(unsigned(rs1)) + to_integer(imm(ADDR_WIDTH-1 downto 1)))(15 downto 0) <= rs2(15 downto 0);
        return rs2(15 downto 0);
    elsif opcode = "SB" then
        -- Store Byte (SB)
         mem(to_integer(unsigned(rs1)) + to_integer(imm(ADDR_WIDTH-1 downto 0)))(7 downto 0) <= rs2(7 downto 0);
        return rs2(7 downto 0);
    else
        -- Invalid opcode
        return (others => '0');
    end if;
end function;


--end section by Mostafa Deyab

end S_type_functions;
