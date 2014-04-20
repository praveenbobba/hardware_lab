section .text
global main
extern scanf
extern printf


main:
fldz

call read
call read
call read

mov dword[four],4

fldz
FADD ST2 
FMUL ST0
FILD dword[four]
FMUL ST4
FMUL ST2
FXCH ST1
FSUB ST1 
FIST dword[dis]

cmp dword[dis],0
jl img

FSQRT
FDIV ST4
mov dword[four],2
FIDIV dword[four]
FXCH ST3
FCHS
FDIV ST4
mov dword[four],2
FIDIV dword[four]
FLDZ
FADD ST1
FADD ST4
call root1

FSUB ST4
FSUB ST4
call root2
exit:
	mov eax,1
	mov ebx,0
	int 80h

img:
	mov eax, 4
	mov ebx, 1
	mov ecx, msg3
	mov edx, len3
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, new
	mov edx, len2
	int 80h
	jmp exit

root1:

 push ebp
 mov ebp, esp
 sub esp, 8
 fst qword[ebp-8]
 push format1
 call printf
 mov esp, ebp
 pop ebp
 ret

root2:

 push ebp
 mov ebp, esp
 sub esp, 8
 fst qword[ebp-8]
 push format2
 call printf
 mov esp, ebp
 pop ebp
 ret

read:
	push ebp
	mov ebp, esp
	sub esp, 8
	lea eax, [esp]
	push eax
	push format1
	call scanf
	fld qword[ebp-8]
	mov esp, ebp
	pop ebp
	ret
section .data
new: db 0Ah
len2: equ $-new
msg3: db "Imagin"
len3: equ $-msg3
format1: db "%lf",0
format2: db "%lf",10

section .bss

four: resd 1
dis: resd 1

