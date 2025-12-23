org 0x7C00

start:
    ; Set text mode 80x25
    mov ah, 0x00
    mov al, 0x03
    int 0x10

    mov cx, 50          ; ~50 frames for 5s
frame_loop:
    ; Draw circle points
    call draw_circle

    call delay
    loop frame_loop

hang:
    jmp hang

; ------------------------
; Draw circle approximation
; ------------------------
draw_circle:
    ; Attribute: bright white on blue
    mov bl, 0x1F
    mov bh, 0

    ; Coordinates for circle (row, col)
    ; Top
    mov dh, 5
    mov dl, 40
    call put_space

    ; Upper left/right
    mov dh, 7
    mov dl, 35
    call put_space
    mov dh, 7
    mov dl, 45
    call put_space

    ; Middle left/right
    mov dh, 10
    mov dl, 32
    call put_space
    mov dh, 10
    mov dl, 48
    call put_space

    ; Lower left/right
    mov dh, 13
    mov dl, 35
    call put_space
    mov dh, 13
    mov dl, 45
    call put_space

    ; Bottom
    mov dh, 15
    mov dl, 40
    call put_space
    ret

; ------------------------
; Print colored space at (dh=row, dl=col)
; ------------------------
put_space:
    mov ah, 0x02        ; set cursor
    int 0x10

    mov ah, 0x09        ; write char/attribute
    mov al, ' '
    mov cx, 1
    int 0x10
    ret

; ------------------------
; Delay routine (~100ms)
; ------------------------
delay:
    mov cx, 0xFFFF
delay_loop:
    nop
    loop delay_loop
    ret

times 510-($-$$) db 0
dw 0xAA55
