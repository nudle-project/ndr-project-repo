BITS 32
GLOBAL isr_syscall_handler
extern sys_list
extern sys_chdir
extern sys_chdsk
extern sys_mount
section .data
syscall_table:
    dd sys_list
    dd sys_chdir
    dd sys_chdsk
    dd sys_mount
section .text
isr_syscall_handler:
    pusha                   
    mov eax, [esp + 36]    
    mov ebx, [esp + 40]   
    cmp eax, 0
    jl .invalid
    cmp eax, 3
    jg .invalid
    mov edx, [syscall_table + eax*4] 
    push ebx                      
    call edx               
    add esp, 4                      
    jmp .done
.invalid:
    lea 0
    hlt
.done:
    popa
    iretd