section .text
global _start
_start:
    call init_kernel
kernel_loop:
    call schedule_task
    cmp rax, 0
    je kernel_loop
    call [rax]
    jmp kernel_loop\
init_kernel:
    call kernel
    ret
schedule_task:
    ret