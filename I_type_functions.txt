library IEEE;
use IEEE.numeric_bit.all;

--package for extending signed and unsigned halfword and byte values
package extension_pack is
use work.cpu_defs_pack.all;

procedure signed_extend(
sig_in: in bit_vector; 
sig_out: out data_type
);

procedure unsigned_extend(
sig_in: in bit_vector;
sig_out: out data_type
);
end extension_pack;

package body extension_pack is

procedure signed_extend(
sig_in: in bit_vector; 
sig_out: out data_type
) is
begin
    sig_out := (others => sig_in(sig_in'HIGH)); 
    sig_out(sig_in'LENGTH -1 downto 0) := sig_in;
     
end signed_extend;


procedure unsigned_extend(
sig_in: in bit_vector;
sig_out: out data_type
) is
begin
    sig_out := (others => '0');
    sig_out(sig_in'LENGTH -1 downto 0) := sig_in;
    
end unsigned_extend;

end extension_pack;





library IEEE;
use IEEE.numeric_bit.all;
--for LW, LH, LB the immediate values are signed, for LHU, LBU the immediate are unsigned

package I_Type_functions is

use work.cpu_defs_pack.all;
use work.register_init.all;
use work.mem_pack.all;
use work.extension_pack.all;
subtype imm_type_I is bit_vector(11 downto 0); --immediate size in i type

procedure I_slice( 
--I-type slicing/decoding
    Instr: in bit_vector(instr_width-1 downto 0);
    rs: out reg_addr_type;
    rd: out reg_addr_type;
    imm: out imm_type_I; 
    func3: out func3_type
);

procedure LW(
    rs: in reg_addr_type;
    rd: in reg_addr_type;
    imm: in imm_type_I
);

procedure LH(
    rs: in reg_addr_type;
    rd: in reg_addr_type;
    imm: in imm_type_I
);
procedure LB(
    rs: in reg_addr_type;
    rd: in reg_addr_type;
    imm: in imm_type_I
);
procedure LBU(
    rs: in reg_addr_type;
    rd: in reg_addr_type;
    imm: in imm_type_I
);
procedure LHU(
    rs: in reg_addr_type;
    rd: in reg_addr_type;
    imm: in imm_type_I
);
end I_Type_functions;



package body I_Type_functions is

procedure I_slice(
    Instr: in bit_vector(instr_width-1 downto 0);
    rs: out reg_addr_type;
    rd: out reg_addr_type;
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
    rs: in reg_addr_type;
    rd: in reg_addr_type;
    imm: in imm_type_I)is
begin
    Reg(to_integer(UNSIGNED(rd))) := Memory(to_integer(UNSIGNED(rs)) + to_integer(SIGNED(imm)));
    --address of rd register is unsigned
end LW;

procedure LH(
    rs: in reg_addr_type;
    rd: in reg_addr_type;
    imm: in imm_type_I
) is
variable half_word: bit_vector((data_width/2)-1 downto 0);
variable extended: data_type;
begin
    half_word := Memory(to_integer(UNSIGNED(rs)) + to_integer(UNSIGNED(imm)))(15 downto 0);
    signed_extend(half_word, extended);
    Reg(to_integer(UNSIGNED(rd))) := extended;
end LH;

procedure LB(
    rs: in reg_addr_type;
    rd: in reg_addr_type;
    imm: in imm_type_I
) is
variable Byte: bit_vector((data_width/4)-1 downto 0);
variable extended: data_type;
begin
    Byte := Memory(to_integer(UNSIGNED(rs)) + to_integer(UNSIGNED(imm)))(7 downto 0);
    signed_extend(Byte, extended);
    Reg(to_integer(UNSIGNED(rd))) := extended;
end LB;

procedure LHU(
    rs: in reg_addr_type;
    rd: in reg_addr_type;
    imm: in imm_type_I
) is
variable half_word: bit_vector((data_width/2)-1 downto 0);
variable extended: data_type;
begin 
    half_word := Memory(to_integer(UNSIGNED(rs)) + to_integer(UNSIGNED(imm)))(15 downto 0);
    unsigned_extend(half_word, extended);
    Reg(to_integer(UNSIGNED(rd))) := extended;

end LHU;

procedure LBU(
    rs: in reg_addr_type;
    rd: in reg_addr_type;
    imm: in imm_type_I
) is
variable Byte: bit_vector((data_width/4)-1 downto 0);
variable extended: data_type;
begin
    Byte := Memory(to_integer(UNSIGNED(rs)) + to_integer(UNSIGNED(imm)))(7 downto 0);
    unsigned_extend(Byte, extended);
    Reg(to_integer(UNSIGNED(rd))) := extended;

end LBU;

end I_Type_functions;


