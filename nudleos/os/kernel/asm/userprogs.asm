; user_program.asm
BITS 32
GLOBAL _start

section .data
path db "/home/user", 0
device db "/dev/sda1", 0

section .text
_start:
    ; Call list()
    mov eax, 0          ; SYS_LIST
    mov ebx, 0          ; No args
    int 0x80

    mov eax, 1
    mov ebx, path
    int 0x80

    mov eax, 2      
    mov ebx, 0
    int 0x80

    mov eax, 3     
    mov ebx, device
    int 0x80

    hlt