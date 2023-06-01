library IEEE;
use IEEE.numeric_bit.all;


package R_type_functions is
use WORK.cpu_defs_pack.all;
use WORK.register_init.all;
    procedure R_slice(
        Instr: in data_type;
        rs1: out reg_addr_type;
        rs2: out reg_addr_type;
        rd: out reg_addr_type;
        func3: out func3_type;
        func7: out func7_type
    );
    procedure SLT(
    rs1: in reg_addr_type;
    rs2: in reg_addr_type;
    rd: in reg_addr_type
    );
    
    procedure SLTU( 
    --set rd to 1 if rs2 is not equal to 0, otherwise sets rd to 0
    rs1: in reg_addr_type;
    rs2: in reg_addr_type;
    rd: in reg_addr_type
    );

end R_type_functions;

package body R_type_functions is
    procedure R_slice(
        Instr: in data_type;
        rs1: out reg_addr_type;
        rs2: out reg_addr_type;
        rd: out reg_addr_type;
        func3: out func3_type;
        func7: out func7_type
    ) is
    
    begin
        rs1 := Instr(19 downto 15);
        rs2 := Instr(24 downto 20);
        rd := Instr(11 downto 7);
        func3 := Instr(14 downto 12);
        func7 := Instr(31 downto 25);
    end R_slice;
    
    procedure SLT(
        rs1: in reg_addr_type;
        rs2: in reg_addr_type;
        rd: in reg_addr_type
    ) is
    variable addr_num: integer := to_integer(UNSIGNED(rd));
    begin
    if SIGNED(Reg(to_integer(UNSIGNED(rs1)))) < SIGNED(Reg(to_integer(UNSIGNED(rs2)))) then
        Reg(addr_num)(0):= '1';
        Reg(addr_num) := (others => '0');
        
    else 
        Reg(addr_num) := (others => '0');
    end if;
    
    end SLT;
    
    procedure SLTU(
        rs1: in reg_addr_type;
        rs2: in reg_addr_type;
        rd: in reg_addr_type
    ) is
     variable addr_num: integer := to_integer(UNSIGNED(rd));
    begin
        if UNSIGNED(Reg(to_integer(UNSIGNED(rs1)))) < UNSIGNED(Reg(to_integer(UNSIGNED(rs2))))
        and UNSIGNED(Reg(to_integer(UNSIGNED(rs2)))) /= 0 then        
        Reg(addr_num)(0):= '1';
        Reg(addr_num) := (others => '0');
        
    else 
        Reg(addr_num) := (others => '0');
    end if;
    
    
    end SLTU;    


end R_type_functions;
