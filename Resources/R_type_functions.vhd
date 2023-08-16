library IEEE;
use IEEE.numeric_bit.all;


package R_type_functions is
use WORK.cpu_defs_pack.all;
use WORK.register_init.all;
    procedure R_slice(
        Instr: in InstrType;
        rs1: out RegAddrType;
        rs2: out RegAddrType;
        rd: out RegAddrType;
        func3: out func3_type;
        func7: out func7_type
    );
    
    
    procedure SLT(
    rs1: in RegAddrType;
    rs2: in RegAddrType;
    rd: in RegAddrType
    );
    
    procedure SLTU( 
    --set rd to 1 if rs2 is not equal to 0, otherwise sets rd to 0
    rs1: in RegAddrType;
    rs2: in RegAddrType;
    rd: in RegAddrType
    );

    procedure SLL_Instr (
    --shift left logical
    rs1: in RegAddrType;
    rs2: in RegAddrType;
    rd: in RegAddrType
    );

    procedure SRL_Instr(
    rs1: in RegAddrType;
    rs2: in RegAddrType;
    rd: in RegAddrType
    );

    procedure OR_Instr(
    rs1: in RegAddrType;
    rs2: in RegAddrType;
    rd: in RegAddrType
    );
    
end R_type_functions;




package body R_type_functions is
    procedure R_slice(
        Instr: in InstrType;
        rs1: out RegAddrType;
        rs2: out RegAddrType;
        rd: out RegAddrType;
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
    
    procedure SLT( --SIGNED comparison between 2 reg, if rs1 < rs2, rd set to 1
        rs1: in RegAddrType;
        rs2: in RegAddrType;
        rd: in RegAddrType
    ) is
    variable sRegValue1: integer := to_integer(SIGNED(Reg(to_integer(UNSIGNED(rs1)))));
    variable sRegValue2: integer := to_integer(SIGNED(Reg(to_integer(UNSIGNED(rs2)))));
    variable addr_num: integer := to_integer(UNSIGNED(rd));
    begin
    if sRegValue1 < sRegValue2 then
        Reg(addr_num)(0):= '1';
        Reg(addr_num) := (others => '0');
        
    else 
        Reg(addr_num) := (others => '0');
    end if;
    
    end SLT;
    
    procedure SLTU(
        rs1: in RegAddrType;
        rs2: in RegAddrType;
        rd: in RegAddrType
    ) is
    variable sRegValue1: integer := to_integer(UNSIGNED(Reg(to_integer(UNSIGNED(rs1)))));
    variable sRegValue2: integer := to_integer(UNSIGNED(Reg(to_integer(UNSIGNED(rs2)))));
    variable addr_num: integer := to_integer(UNSIGNED(rd));
    begin
        if sRegValue1 < sRegValue2
        and sRegValue2 /= 0 then        
        Reg(addr_num)(0):= '1';
        Reg(addr_num) := (others => '0');
        
    else 
        Reg(addr_num) := (others => '0');
    end if;
    end SLTU;
    
    
    
    procedure SLL_Instr (
    --rs2 marks how many positions need to be shifted, consider the number storedd in rs2 to be UNSIGNED
    rs1: in RegAddrType;
    rs2: in RegAddrType;
    rd: in RegAddrType
    ) is 
    variable shiftPos: integer := to_integer(UNSIGNED(Reg(to_integer(UNSIGNED(rs2)))));
    variable operand: BusDataType := Reg(to_integer(UNSIGNED(rs1)));
    variable result: BusDatatype;
    variable addr_num: integer := to_integer(UNSIGNED(rd));
    begin
        result(BusDataSize - 1 downto shiftPos) := operand(BusDataSize - 1 - shiftPos downto 0);
        result := (others => '0') ;
    end SLL_Instr;
    

    procedure SRL_Instr(
    rs1: in RegAddrType;
    rs2: in RegAddrType;
    rd: in RegAddrType
    )is 
    variable shiftPos: integer := to_integer(UNSIGNED(Reg(to_integer(UNSIGNED(rs2)))));
    variable operand: BusDataType := Reg(to_integer(UNSIGNED(rs1)));
    variable result: BusDatatype;
    variable addr_num: integer := to_integer(UNSIGNED(rd));
    begin
        result(BusDataSize - 1 - shiftPos downto 0) := operand(BusDataSize - 1 downto shiftPos);
        result := (others => '0') ;
    end SRL_Instr;


    procedure OR_Instr(
    rs1: in RegAddrType;
    rs2: in RegAddrType;
    rd: in RegAddrType
    );

end R_type_functions;
