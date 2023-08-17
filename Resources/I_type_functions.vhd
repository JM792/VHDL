--begin section by Jiayi Ma

--extend package for imcomplete size LOAD, extend outptu are bit_vector
--I type functions


library IEEE;
use IEEE.numeric_bit.all;

--package for extending signed and unsigned halfword and byte values
package extension_pack is
use work.cpu_defs_pack.all;

procedure signed_extend(
sig_in: in bit_vector; 
sig_out: out BusDataType
);

procedure unsigned_extend(
sig_in: in bit_vector;
sig_out: out BusDataType
);
end extension_pack;

package body extension_pack is

procedure signed_extend(
sig_in: in bit_vector; 
sig_out: out BusDataType
) is
begin
    sig_out := (others => sig_in(sig_in'HIGH)); 
    sig_out(sig_in'LENGTH -1 downto 0) := sig_in;
     
end signed_extend;


procedure unsigned_extend(
sig_in: in bit_vector;
sig_out: out BusDataType
) is
begin
    sig_out := (others => '0');
    sig_out(sig_in'LENGTH -1 downto 0) := sig_in;
    
end unsigned_extend;

end extension_pack;







--for LW, LH, LB the immediate values are signed, for LHU, LBU the immediate are unsigned

library IEEE;
use IEEE.numeric_bit.all;

package I_Type_functions is

use work.cpu_defs_pack.all;
use work.register_init.all;
use work.mem_pack.all;
use work.extension_pack.all;
subtype imm_type_I is bit_vector(11 downto 0); --immediate size in i type

procedure I_slice( 
--I-type slicing/decoding
    Instr: in bit_vector(InstrSize - 1 downto 0);
    rs: out RegAddrType;
    rd: out RegAddrType;
    imm: out imm_type_I; 
    func3: out func3_type
);

procedure LW(
    Memory: in MemType;
    rs: in RegAddrType;
    rd: in RegAddrType;
    imm: in imm_type_I
);

procedure LH(
    Memory: in MemType;
    rs: in RegAddrType;
    rd: in RegAddrType;
    imm: in imm_type_I
);
procedure LB(
    Memory: in MemType;
    rs: in RegAddrType;
    rd: in RegAddrType;
    imm: in imm_type_I
);
procedure LBU(
    Memory: in MemType;
    rs: in RegAddrType;
    rd: in RegAddrType;
    imm: in imm_type_I
);
procedure LHU(
    Memory: in MemType;
    rs: in RegAddrType;
    rd: in RegAddrType;
    imm: in imm_type_I
);
end I_Type_functions;



package body I_Type_functions is

procedure I_slice(
    Instr: in bit_vector(InstrSize-1 downto 0);
    rs: out RegAddrType;
    rd: out RegAddrType;
    imm: out imm_type_I; --immediate size in i type
    func3: out func3_type
) is
begin

rs := Instr(19 downto 15);
rd := Instr(11 downto 7);
imm := Instr(31 downto 20);
func3 := Instr(14 downto 12);

end I_slice;


procedure LW(
    Memory: in MemType;
    rs: in RegAddrType;
    rd: in RegAddrType;
    imm: in imm_type_I) 
is    
    variable sRegValue: integer := to_integer(UNSIGNED(Reg(to_integer(UNSIGNED(rs)))));
begin
    Reg(to_integer(UNSIGNED(rd))) := Memory(sRegValue + to_integer(SIGNED(imm)));
end LW;

procedure LH( --load halfword signed value from memo to reg
    Memory: in MemType;
    rs: in RegAddrType;
    rd: in RegAddrType;
    imm: in imm_type_I
) is
variable half_word: bit_vector((BusDataSize/2)-1 downto 0);
variable sRegValue: integer := to_integer(UNSIGNED(Reg(to_integer(UNSIGNED(rs)))));
variable extended: BusDataType;
begin
    
    half_word := Memory(sRegValue + to_integer(SIGNED(imm)))(BusDataSize/2 - 1 downto 0);
    signed_extend(half_word, extended);
    Reg(to_integer(UNSIGNED(rd))) := extended;
end LH;

procedure LB(
    Memory: in MemType;
    rs: in RegAddrType;
    rd: in RegAddrType;
    imm: in imm_type_I
) is
variable Byte: bit_vector((BusDataSize/4)-1 downto 0);
variable extended: BusDataType;
variable sRegValue: integer := to_integer(UNSIGNED(Reg(to_integer(UNSIGNED(rs)))));
begin
    Byte := Memory(sRegValue + to_integer(UNSIGNED(imm)))(7 downto 0);
    signed_extend(Byte, extended);
    Reg(to_integer(UNSIGNED(rd))) := extended;
end LB;

procedure LHU(
    Memory: in MemType;
    rs: in RegAddrType;
    rd: in RegAddrType;
    imm: in imm_type_I
) is
variable half_word: bit_vector((BusDataSize/2)-1 downto 0);
variable extended: BusDataType;
variable sRegValue: integer := to_integer(UNSIGNED(Reg(to_integer(UNSIGNED(rs)))));
begin 
    half_word := Memory(sRegValue + to_integer(SIGNED(imm)))(15 downto 0);
    unsigned_extend(half_word, extended);
    Reg(to_integer(UNSIGNED(rd))) := extended;

end LHU;

procedure LBU(
    Memory: in MemType;
    rs: in RegAddrType;
    rd: in RegAddrType;
    imm: in imm_type_I
) is
variable Byte: bit_vector((BusDataSize/4)-1 downto 0);
variable extended: BusDataType;
variable sRegValue: integer := to_integer(UNSIGNED(Reg(to_integer(UNSIGNED(rs)))));
begin
    Byte := Memory(sRegValue + to_integer(SIGNED(imm)))(7 downto 0);
    unsigned_extend(Byte, extended);
    Reg(to_integer(UNSIGNED(rd))) := extended;

end LBU;

end I_Type_functions;


--end section by Jiayi Ma