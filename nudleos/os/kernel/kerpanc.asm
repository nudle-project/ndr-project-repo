section .data
   msg db 'Kernel Panic!', 0Ah
   msg db 'Press F11 to change esp', 0Ah
   msg db "Restarting in 5", 0Bh
   msg db "Restarting in 4", 0Bh
   msg db "Restarting in 3", 0Bh
   msg db "Restarting in 2", 0Bh
   msg db "Restarting in 1", 0Bh
section .text
   global _start
_start:
   mov eax, 4
   mov ebx, 1 
   mov ecx, msg 
   mov edx, 999 
   int 0x80
   mov eax, 1 
   xor ebx, ebx
   int 0x80
.panic:
    store daa dmp
    mov dmp, esp
    daa dmp
    hlt
   store daa dmp
    mov dmp, esp
    daa dmp
    hlt
    add ebp
    push ebp
    movzx 3, 4
    int 0x90
       mov eax, 4
   mov ebx, 1 
   mov ecx, msg 
   mov edx, 999 
   int 0x80
   mov eax, 1 
   xor ebx, ebx
   int 0x80