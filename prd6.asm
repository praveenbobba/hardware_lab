section .data
message: db "enter string",10

section .bss
count: resw 1
printnum: resw 1
temp: resw 1
array: resb 100
temp1: resw 1
count1: resw 1
section .text
global _start:
_start:
mov eax,4
mov ebx,1
mov ecx,message
mov edx,13
int 80h
mov word[count1],0
mov edi,array
call read
mov ax,word[count1]
mov word[printnum],ax
call print
mov eax,1
mov ebx,0
int 80h
read:
	mov eax,3
		mov ebx,0
		mov ecx,temp1
		mov edx,1
		int 80h
		mov ax,word[temp1]
		cmp word[temp1],10
		je exit
		;push ecx
		stosw
		inc word[count1]
		call read
	exit:
		ret
print:
	mov byte[count],0
	lo1:
	cmp word[printnum],0
	je zero
	mov dx,0
	mov ax,word[printnum]
	mov bx,10
	div bx
	mov word[printnum],ax
	push dx
	inc byte[count]
	jmp lo1
zero:
	mov ax,0
	push ax
	inc byte[count]
	jmp pri
pri:
	cmp byte[count],0
	je returnprint
	pop ax
	mov word[temp1],ax
	add word[temp1],30h
	mov eax,4
	mov ebx,1
	mov ecx,temp1
	mov edx,1
	int 80h
	dec byte[count]
	jmp pri
returnprint:
	ret
