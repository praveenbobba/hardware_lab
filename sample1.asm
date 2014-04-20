section .data

message: db "enter the length of the array",10

section .bss

array: resw 10
num: resw 1
temp: resb 1
length: resw 1
count: resw 1
count1: resw 1
num1: resw 1
num2: resw 1
second: resw 1

section .text

global _start:
_start:
	mov eax,4
	mov ebx,1
	mov ecx,message
	mov edx,30
	int 80h
	call read
	;mov ax,word[num]
	;mov word[length],ax
	;call read_array
	;call second_large
	add word[num],30h
	mov eax,4
	mov ebx,1
	mov edx,num
	mov edx,1
	int 80h
	mov eax,1
	mov ebx,0
	int 80h

second_large:
	mov word[count],0
	sub word[length],1
	l3:
		cmp word[count],2
		je ident
		mov word[count1],0
		mov ebp,array
		inc word[count]
		l4:
			mov ax,word[length]
			cmp word[count1],ax
			je l3
			movzx edx,word[count1]
			mov ax, word[ebp+2*edx]
			cmp word[ebp+2*edx+2],ax
			jl swap
			inc word[count1]
			jmp l4
		swap:
			movzx edx,word[count1]
			mov bx,word[ebp+2*edx+2]
			mov word[ebp+2*edx+2],ax
			mov word[ebp+2*edx],bx
			inc word[count1]
			jmp l4		
	ident:
		movzx ebx,word[length]
		sub ebx,1
		mov ax, word[ebp+2*ebx]
		mov word[second],ax
ret

read:
	mov word[num],0
	l1:
		mov eax,3
		mov ebx,0
		mov ecx,temp
		mov edx,1
		int 80x
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
read_array:
	mov word[count],0
	mov ebp,array
	l2:
		mov ax,word[length]		
		cmp word[count],ax
		je return1
		call read
		mov ax,word[num]
		movzx ebx,word[count]
		mov word[ebp+2*ebx],ax
		inc word[count]
		jmp l2
	return1:
	ret	

