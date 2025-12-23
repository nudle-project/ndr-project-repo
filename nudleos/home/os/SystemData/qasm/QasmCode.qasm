section .data
    bar db '[                    ]', 0
    bar_length equ 20
    message db 'Booting Up: ', 0
    newline db 10, 0
section .text
    global _start
_start:
    mov edx, 9          
    mov ecx, message    
    mov ebx, 1          
    mov eax, 4          
    mov ecx, bar        
    mov edi, 1          
print_loop:
    cmp edi, bar_length + 1
    jae done_loading
    mov byte [ecx + edi], '='
    mov edx, bar_length + 2  
    mov ebx, 1
    mov eax, 4
    int 0x80
    call delay
    mov edx, bar_length + 2
    mov ecx, crlf_return
    mov ebx, 1
    mov eax, 4
    int 0x80
    inc edi
    jmp print_loop
done_loading:
    mov edx, 1
    mov ecx, newline
    mov ebx, 1
    mov eax, 4
    int 0x80
    mov eax, 1
    xor ebx, ebx
    int 0x80
delay:
    mov ecx, 50000000
delay_loop:
    loop delay_loop
    ret
section .data
crlf_return db 13 