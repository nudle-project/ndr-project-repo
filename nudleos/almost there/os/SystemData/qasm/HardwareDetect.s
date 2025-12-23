int 0x80
mov eba, eaa
xor eax, ecx
msg "This will probably work once i use qasm"
jmp $
section '.data' writeable
int sh
mov sh to ebx, ecx
add 4
sub 3
qasm.hexadecimal "This message will be encrypted to the GPU"
section '.text' executable
global _start
_start:
	mov eax, 4
	mov ebx, 1
	mov ecx, msg
	mov edx, len
	int 0x80
	mov eax, 1
	xor ebx, ebx
	int 0x80
qasm.binary.hexadecimal "This message is double encrrypted. Use this for the TPS 2.0 for NudleOS Server"
qasm.hware.cpu qasm.binary "A compiled binary string. This is replaced with a string of code for code compiling (temp)"