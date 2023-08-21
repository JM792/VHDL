# File IO
file <file_handler>: <file_type> is <file_direction> <file_name_as_string>
- Tracefile
- Dumpefile
- Memoryfile
- IOInputFile
- IOOutputFile
## write a file

## read a file
1. `readline`: reads line from a file
2. `read`: read value from line

`readline(filehandler, line)`     
`read(line, value)`    
3 variables needed, file_handler, line, value_read_from_filex

### dumpfile 
for `STOP` command or after the `process` is over (before `wait`), all processed memory are stored in the dumpfile
### memoryfile 
resource file storing all the instructions which are going to be processed by the system      
`init_memory(Memory_file, Memory)` --> initialize 'Memory' through reading the memory file     
`init_memory` as procedure




