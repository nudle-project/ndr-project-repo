[org 0x7c00]
KERNEL_OFFSET equ 0x1000
mov [BOOT_DRIVE], dl
mov bx, KERNEL_OFFSET
mov dh, 2            
mov dl, [BOOT_DRIVE]
call disk_load
jmp KERNEL_OFFSET
jmp $                  
%include "disk_load.asm"
BOOT_DRIVE db 0
times 510-($-$$) db 0
dw 0xaa55