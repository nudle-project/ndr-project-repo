mov eax, ebx
mov rax, rsi
mov db 0x0, mem
mov rax, 0x0
mov eax, 0x0
mov ebx, 0x0
mov rsi, 0x0
mov do 0x0
mov idtr rax
do mov idtr rax
idtr 0x0
mov seg, 0x0
seg 0x0, mem
mov mem, 0x0
dmp db 0x0, mem
_start:
    mov eax, 0
    xor eax, eax
    lea rax, 0
    mov ebx, 1
    mov dump, mem, 0x0
    xor ebx, ebx
    lea rax, 0
    ret