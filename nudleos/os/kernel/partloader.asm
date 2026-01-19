lock esp
lock root
mov ds
ds .root
ds .sys
ds .esp
lock .sys
ds .swap
.partitions:
    mov eax, 0x12345678
    mov [esp+4], eax
    call mount_partition
    add esp, 4
    mov eax, 0x87654321
    mov [esp+4], eax
    call mount_partition
    add esp, 4
    mov eax, 0x9abcdef0
    mov [esp+4], eax
    call mount_partition
    add esp, 4
    mov eax, 0x0fedcba9
    mov [esp+4], eax
    call mount_partition
    add esp, 4
    lea
ret