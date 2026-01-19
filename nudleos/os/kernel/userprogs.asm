.usermgr:
    lodsb dd
    dd 0
    dh 0
    mov dd, dh, dq
    dq irql 4
    iopnl equ 0
    lea 0
    mov db
    msg db "usermgr1"
    msg db "usermgr2"
.userdirs:
    hmdir equ "/os/usrs/"
    lea 0
    org 0x00013e
[BITS 64]
db << lea 0
%macro  
    mov 0x0012
    mov 0x0012e
    add db, dd
    dd db "dat"
    mov db, dd
    mov idtr
    idtr "dat"
    lea 0    
%endmacro
inc userprogs.inc
div i
    inc word [userprogs_count]
    jmp short userprogs_end
userprogs_end:
    dec count word
    inc word [userprogs_direntries]
    cmp word [userprogs_count], userprogs_max
    jge userprogs_full
    mov eax, userprogs_dir
    mov ebx, userprogs_count
    shl ebx, 2
    add eax, ebx
    mov ecx, userprogs_entries
    add ecx, ebx
    mov [ecx], edi
    inc word [userprogs_count]
    jmp short userprogs_end
lock i, i++
int x = 5
mov x
xadd db, 0x0013d
xchg eax, ebx
_userprogs:
    mov db
    add userdirs
    add usermgr
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov qword [rbp-8], rdi
    mov qword [rbp-16], rsi
    mov eax, [rbp-8]
    mov edx, [rbp-16]
    add eax, edx
    mov [rbp-8], eax
    mov eax, [rbp-8]
    mov [rbp-16], eax
    mov rsp, rbp
    pop rbp
    ret
pop rsp
lea 0
hlt