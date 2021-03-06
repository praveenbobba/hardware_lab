section .text
global _start:
_start:
	mov eax,4
	mov ebx,1
	mov ecx,msg
	mov edx,18
	int 80h
	call read
	mov ax,word[num]
	mov word[num1],ax
	call read
	mov ax,word[num]
	mov word[num2],ax
	pusha
	mov ax,word[num1]
	mov bx,word[num2]
	call add
	mov word[printnum],ax
	call print
	mov eax,1
	mov ebx,0
	int 80h
add:
	add ax,bx
	ret

read:
	mov word[num],0
	l1:
		mov eax,3
		mov ebx,0
		mov ecx,temp
		mov edx,1
		int 80h
		cmp byte[temp],10
		je return
		sub byte[temp],30h
		mov bl,10
		mov ax,word[num]
		mul bl
		mov word[num],ax
		movzx ax,byte[temp]
		add word[num],ax
		jmp l1
	return:
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
section .data
msg: db "enter the numbers",10
section .bss
count resb 1
temp: resb 1
temp1: resw 1
num: resw 1
num1: resw 1
num2: resw 1
printnum: resw 1
