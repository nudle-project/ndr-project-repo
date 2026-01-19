BITS 32
%include "desktop.inc"
%include "taskbar.inc"
%include "icons.inc"
%include "gui.inc"
%include "bitcounter.inc"
%include "filesystem.inc"
%include "shell86.inc"
extern g_kctx
extern driverstore_run
extern xtm_in_init
global kgt86_main
kgt86_main:
push ebp
mov ebp,esp
call xtm_in_init
call driverstore_run
call fs_init
call bitcounter_start
call desktop_init
call taskbar_init
call icons_init
call gui_init
.idle:
hlt
jmp .idle
mov esp,ebp
pop ebp
ret
.kernel:
    mov db, sm
    xor esp, ebp
    add esp
    nop esp, ebp
    mov 0x012, 0x012b
    jmp .kernel
    store eax, ebx
    mov rax, rbx
    mov les
    lea 0
    lev 0
    hlt
    extern kernel
    push kernel
    lds 4, eax
    lock ebx
    stos ecx
    lock ecx
    mov edi
    lea