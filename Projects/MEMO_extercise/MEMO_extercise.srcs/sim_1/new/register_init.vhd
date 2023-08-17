--begin section Jiayi Ma
package register_init is
use WORK.cpu_defs_pack.all;
    shared variable Reg: RegType := 
        ( -- register data
       
        0 => X"00000000", 
        1 => X"00000000", 
        others => X"00000000");

end register_init;
--end section Jiayi Ma
