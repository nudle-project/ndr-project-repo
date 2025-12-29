BITS 16
ORG 0x1000
stage2_start:
    mov ax, 0x0013
    int 0x10
    call draw_desktop
    jmp dos_shell
draw_desktop:
    mov ah, 0x0C
    mov al, 0x01
    xor cx, cx
    xor dx, dx
.bg_loop:
    int 0x10
    inc cx
    cmp cx, 320
    jne .bg_loop
    xor cx, cx
    inc dx
    cmp dx, 200
    jne .bg_loop
    mov al, 0x0F
    xor dx, dx
.title_loop_y:
    xor cx, cx
.title_loop_x:
    int 0x10
    inc cx
    cmp cx, 320
    jne .title_loop_x
    inc dx
    cmp dx, 12
    jne .title_loop_y
    mov dh, 0
    mov dl, 1
    call set_cursor
    mov si, msg_title
    call print_string_gfx
    mov al, 0x0F
    mov dx, 20
.win_y:
    mov cx, 10
.win_x:
    int 0x10
    inc cx
    cmp cx, 160
    jne .win_x
    inc dx
    cmp dx, 170
    jne .win_y
    mov dh, 3
    mov dl, 2
    call set_cursor
    mov si, msg_dir_header
    call print_string_gfx
    ret
dos_shell:
    mov dh, 22
    mov dl, 1
    call set_cursor
    mov si, msg_prompt
    call print_string_gfx
    mov di, buffer
    xor cx, cx
get_char:
    mov ah, 0x00
    int 0x16
    cmp al, 0x0D
    je execute_dos_cmd
    cmp al, 0x08
    je handle_backspace
    cmp cx, 30
    je get_char
    mov ah, 0x0E
    int 0x10
    stosb
    inc cx
    jmp get_char
handle_backspace:
    cmp cx, 0
    je get_char
    mov ah, 0x0E
    mov al, 0x08
    int 0x10
    mov al, ' '
    int 0x10
    mov al, 0x08
    int 0x10
    dec di
    dec cx
    jmp get_char
execute_dos_cmd:
    mov al, 0
    stosb
    mov si, buffer
    mov di, cmd_run
    call strcmp
    jc enter_program_mode
    mov si, buffer
    mov di, cmd_exec
    call strcmp
    jc run_interpreter
    mov si, buffer
    mov di, cmd_gfx
    call strcmp
    jc do_gfx
    mov si, buffer
    mov di, cmd_txt
    call strcmp
    jc do_txt
    mov si, buffer
    mov di, cmd_cls_alt
    call strcmp
    jc do_cls
    mov si, buffer
    mov di, cmd_ver
    call strcmp
    jc do_ver
    mov si, buffer
    mov di, cmd_dir
    call strcmp
    jc do_dir
    mov si, buffer
    mov di, cmd_date
    call strcmp
    jc do_date
    mov si, buffer
    mov di, cmd_reboot
    call strcmp
    jc do_reboot
    call clear_prompt_line
    jmp dos_shell
enter_program_mode:
    call clear_prompt_line
    mov si, msg_prog_mode
    call print_string_gfx
    mov di, prog_space
    xor dx, dx
.prog_loop:
    mov ah, 0x00
    int 0x16
    cmp al, 27
    je .done
    mov ah, 0x0E
    int 0x10
    stosb
    inc dx
    cmp dx, 500
    je .done
    jmp .prog_loop
.done:
    call clear_prompt_line
    jmp dos_shell
run_interpreter:
    mov si, prog_space
    mov bx, 0
.exec_loop:
    lodsb
    test al, al
    jz .finish
    cmp al, 'G'
    je .set_gfx
    cmp al, 'T'
    je .set_txt
    cmp al, 'P'
    je .plot
    cmp al, '_'
    je .cls_gfx
    cmp al, '!'
    je .move_obj
    cmp al, 'D'
    je .delay
    cmp al, 'H'
    je .finish
    jmp .exec_loop
.set_gfx:
    mov ax, 0x0013
    int 0x10
    jmp .exec_loop
.set_txt:
    mov ax, 0x0003
    int 0x10
    jmp .exec_loop
.cls_gfx:
    mov ax, 0x0013
    int 0x10
    jmp .exec_loop
.plot:
    lodsb
    mov cx, ax
    lodsb
    mov dx, ax
    lodsb
    mov ah, 0x0C
    int 0x10
    jmp .exec_loop
.move_obj:
    lodsb
    mov cx, ax
    lodsb
    mov dx, ax
    mov al, 0
    mov ah, 0x0C
    int 0x10
    lodsb
    mov cx, ax
    lodsb
    mov dx, ax
    lodsb
    mov ah, 0x0C
    int 0x10
    jmp .exec_loop
.delay:
    lodsb
    mov ah, 0x86
    mov cx, 0x0001
    mov dx, ax
    int 0x15
    jmp .exec_loop
.finish:
    call draw_desktop
    jmp dos_shell
do_gfx:
    mov ax, 0x0013
    int 0x10
    jmp dos_shell
do_txt:
    mov ax, 0x0003
    int 0x10
    jmp dos_shell
do_ver:
    call clear_prompt_line
    mov si, msg_ver_text
    call print_string_gfx
    jmp dos_shell
do_dir:
    mov dh, 5
    mov dl, 2
    call set_cursor
    mov si, msg_files
    call print_string_gfx
    jmp dos_shell
do_cls:
    call draw_desktop
    jmp dos_shell
do_date:
    call clear_prompt_line
    mov ah, 0x04
    int 0x1Ah
    mov si, msg_date_stub
    call print_string_gfx
    jmp dos_shell
do_reboot:
    db 0xEA
    dw 0x0000
    dw 0xFFFF
set_cursor:
    mov ah, 0x02
    mov bh, 0
    int 0x10
    ret
print_string_gfx:
    mov ah, 0x0E
    mov bl, 0x00
.next:
    lodsb
    test al, al
    jz .exit
    int 0x10
    jmp .next
.exit:
    ret
clear_prompt_line:
    mov dh, 22
    mov dl, 1
    call set_cursor
    mov si, msg_clear_line
    call print_string_gfx
    mov dh, 22
    mov dl, 1
    call set_cursor
    mov si, msg_prompt
    call print_string_gfx
    ret
strcmp:
    pusha
.loop:
    mov al, [si]
    mov bl, [di]
    cmp al, bl
    jne .not_equal
    cmp al, 0
    je .equal
    inc si
    inc di
    jmp .loop
.not_equal:
    popa
    clc
    ret
.equal:
    popa
    stc
    ret
msg_title db "NudleDOS 1.5.6", 0
msg_dir_header db " Volume in drive C is SYSTEM", 0x0D, 0x0A, " Directory of C:\", 0
msg_files db " COMMAND  COM", 0x0D, 0x0A, " KERNEL   SYS", 0x0D, 0x0A, " SNAKE    EXE", 0x0D, 0x0A, " README   TXT", 0
msg_prompt db "C:\> ", 0
msg_clear_line db "                                     ", 0
msg_ver_text db "NudleDOS 1.5.6", 0
msg_date_stub db "Current date is Mon 12-29-2025", 0
msg_prog_mode db "ASM-EDIT: ", 0
cmd_run db "run", 0
cmd_exec db "exec", 0
cmd_gfx db "gfx", 0
cmd_txt db "txt", 0
cmd_ver db "ver", 0
cmd_dir db "dir", 0
cmd_cls_alt db "cls", 0
cmd_date db "date", 0
cmd_reboot db "reboot", 0
buffer times 64 db 0
prog_space times 500 db 0