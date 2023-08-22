# File IO
file <file_handler>: <file_type> is <file_direction> <file_name_as_string>    
`use std.textio.ALL;`
- Tracefile
- Dumpefile
- Memoryfile
- IOInputFile
- IOOutputFile

## file declaration
`file f: Text is in filename;`(file opened)    
- inside subprograms (in such case `filename: string` is needed as function/procedure input, `variable file: text is filename` declared inside subprogram) if subprogramms are closed, file closed  (or at the end of the simulation)    
- inside entity/architecture interface, could use `variable f: in text` as input of procedure/function

## write a file   
1. `writeline`: write single line
2. `write`: write a value included in the line    
`write(l, value, left, 3)`  (left, 3) describe the format used for writig such value to the line


e.g. for LDC R0 2:    
```
{
write(l, string'(LDC));
write(l, string'(R0));
write(l, string'(2));
writeline(f, l);
}
```    
stacking all values in line_pointer, passing values stored to the file_handler


## read a file
1. `readline`: reads line from a file
2. `read`: read value from line (separated by spaces, if one line possesses different values separated by spaces, multiple `read` procedure is needed, same for the `write` procedure)

`readline(filehandler, line)`     
`read(line, value)`   
`read(l, v, boolean)` --> boolean returns if the value inside of the line is read successfully 
3 variables needed, file_handler, line, value_read_from_filex

## end file
`endfile` (function)

### dumpfile 
for `STOP` command or after the `process` is over (before `wait`), all processed memory are stored in the dumpfile
### memoryfile 
resource file storing all the instructions which are going to be processed by the system      
`init_memory(Memory_file, Memory)` --> initialize 'Memory' through reading the memory file     
`init_memory` as procedure    
Instruction memory as strings (command lines):    
<commandn_name> <register_1> <register_2> <register_3> <parameter>    
different important strings include (CPU needs to be able to recognize): labels(jump instructions), comments marks, hex  values     

# Access Type
## declaration
`type line/ integer_ptr/ bit_vector_ptr is access string/ integer/ bit_vecctor`    
`.all` for accessig the object referred by the pointer  

## default value
`type line is access string`    
`varibale l: line := new(string'("Hallo"))`(pointer pointing to value "Hallo")   
reasignment of value must match the size: `l.all := string'("Juhu ")` (.all used for tshe object that is referred by the poiner)
reassignmnet of another reference doesn't need to match size: `l := new(string'("Hallo!!!"))`

## deallocate
`deallocate (bvr_ptr);`   
 
# Record Type
organize the data that belongs to each other    
  
```
{
type list_element is record    
    value: integer;
    next: list_element_ptr;
end record list_element;
}
```


