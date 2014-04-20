section .text
global main
extern scanf
extern printf

main:

mov eax,4
mov ebx,1
mov ecx,m1
mov edx,l1
int 80h
call read
FSTP qword[n1]

mov eax,4
mov ebx,1
mov ecx,m2
mov edx,l2
int 80h
call read
FST qword[n2]

FADD qword[n1]
call addprint

FLD qword[n1]
FSUB qword[n2]
call subprint

FLD qword[n1]
FMUL qword[n2]
call mulprint
;call mulprint
exit:
	mov eax,1
	mov ebx,0
	int 80h

addprint:
	push ebp
	mov ebp, esp
	sub esp, 8
	fst qword[ebp-8]
	push addin
	call printf
	mov esp, ebp
	pop ebp
	ret

subprint:
	push ebp
	mov ebp, esp
	sub esp, 8
	fst qword[ebp-8]
	push difff
	call printf
	mov esp, ebp
	pop ebp
	ret

mulprint:
	push ebp
	mov ebp, esp
	sub esp, 8
	fst qword[ebp-8]
	push mul
	call printf
	mov esp, ebp
	pop ebp
	ret
	
read:
	push ebp
	mov ebp,esp
	sub esp,8
	lea eax,[esp]
	push eax
	push f1
	call scanf
	fld qword[ebp-8]
	mov esp,ebp
	pop ebp
	ret
section .data

m1: db "n1 : "
l1: equ $-m1
m2: db "n2 : "
l2: equ $-m2

f1: db "%lf",0
addin: db 10,"sum : %lf",0
difff: db 10,"difference: %lf",0
mul: db 10,"multiplication : %lf",10

section .bss

n1: resq 1
n2: resq 1

