
package I_Type_functions is
use work.cpu_defs_pack.all;
use work.register_init.all;

procedure LW(
    rs: in reg_addr_type;
    rd: out reg_addr_type;
    imm: in bit_vector
);
procedure LH(
    rs: in reg_addr_type;
    rd: out reg_addr_type;
    imm: in bit_vector
);
procedure LB(
    rs: in reg_addr_type;
    rd: out reg_addr_type;
    imm: in bit_vector
);
procedure LBU(
    rs: in reg_addr_type;
    rd: out reg_addr_type;
    imm: in bit_vector
);
procedure LHU(
    rs: in reg_addr_type;
    rd: out reg_addr_type;
    imm: in bit_vector
);
end I_Type_functions;

package body I_Type_functions is
procedure LB(
    rs: in reg_addr_type;
    rd: out reg_addr_type;
    imm: in bit_vector)is

begin


end LB;



end I_Type_functions;