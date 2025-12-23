mov rcl, 0x00012
add 4
sub 4
$int %ebx %ecx %edx 
mov 9, efx
section .%macro  
    add 4
    sub 4
    mov 0x00012
    jmp 0x004C, 0x001248D
%endmacro