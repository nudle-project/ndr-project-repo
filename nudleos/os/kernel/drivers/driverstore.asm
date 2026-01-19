BITS 32
KDRV_MAGIC      equ 'VRDK'    
HDR_ENTRY_OFF   equ 0x08
HDR_REGINIT_OFF equ 0x14
extern kgt86_load_driver
section .data
global g_kctx
g_kctx: dd 0
global g_driver_table
g_driver_table:
    dd driver0_image_base
    dd driver1_image_base
    dd 0         
extern driver0_image_base
extern driver1_image_base
section .bss
global g_driverstore_last_error
g_driverstore_last_error: resd 1
section .text
global driverstore_run
driverstore_run:
    push ebp
    mov  ebp, esp
    push esi
    push edi
    push ebx
    xor eax, eax
    mov [g_driverstore_last_error], eax
    mov esi, g_driver_table  
.next_driver:
    mov eax, [esi]     
    test eax, eax
    jz .done                 
    mov edx, [g_kctx]
    call kgt86_load_driver
    test ecx, ecx
    jnz .driver_load_failed
    mov edi, ebx       
    cmp dword [edi + 0x00], KDRV_MAGIC
    jne .driver_bad_magic
    mov edx, [edi + HDR_REGINIT_OFF]
    test edx, edx
    jz .skip_reg_init    
    mov eax, edi
    add eax, edx           
    push edi            
    mov edx, [g_kctx]
    push edx                
    call eax
    add esp, 8
    test eax, eax
    jnz .reg_init_failed
.skip_reg_init:
    add esi, 4
    jmp .next_driver
.driver_load_failed:
    mov [g_driverstore_last_error], ecx
    add esi, 4
    jmp .next_driver
.driver_bad_magic:
    mov dword [g_driverstore_last_error], 0x100
    add esi, 4
    jmp .next_driver
.reg_init_failed:
    mov [g_driverstore_last_error], eax
    add esi, 4
    jmp .next_driver
.done:
    pop ebx
    pop edi
    pop esi
    mov esp, ebp
    pop ebp
    ret