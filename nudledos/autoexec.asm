.function
ct all
add 4
sub 4
CTP_autoexed db "Return NudleDOS Autoexecutable File"
msg_prompt db "autoexec>"
msg_files "C:"
mov 0x0ABCD
%macro  
    .function
    ct delete
    mov 0x0012
    int x = 7
    x
    add 4
    sub 5
    mul 7 8
    $int %eax %ebx
    mov edx
%endmacro
mov db
mov aaa
gs global int CONST = 7
[BITS 64]