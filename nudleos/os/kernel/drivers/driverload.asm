BITS 32
KDRV_MAGIC equ 'VRDK'    
global kgt86_load_driver
kgt86_load_driver:
    push esi
    push edi
    push ebp
    mov ebx, eax       
    cmp dword [ebx + 0x00], KDRV_MAGIC
    jne .bad_magic
    mov esi, [ebx + 0x0C]    
    cmp esi, 0x20
    jb .bad_size
    mov edi, [ebx + 0x08]  
    test edi, edi
    jz .bad_entry
    mov eax, ebx
    add eax, edi
    push ebx                
    push edx       
    call eax              
    add esp, 8
    mov ecx, eax         
    xor eax, eax
    test ecx, ecx
    jnz .driver_failed
    mov eax, ebx
    add eax, [ebx + 0x08]
    xor ecx, ecx           
    jmp .done
.bad_magic:
    mov ecx, 1
    jmp .fail_common
.bad_size:
    mov ecx, 2
    jmp .fail_common
.bad_entry:
    mov ecx, 3
    jmp .fail_common
.driver_failed:
.fail_common:
    xor eax, eax       
    xor ebx, ebx           
.done:
    pop ebp
    pop edi
    pop esi
    ret