section .data
message: db "enter string",10
eq: db 49
no: db 48

section .bss
array: resb 100
array1: resb 100
temp: resb 1
count: resb 1
count1: resb 1
section .text
global _start:
_start:
mov eax,4
mov ebx,1
mov ecx,message
mov edx,13
int 80h

call read

mov eax,4
mov ebx,1
mov ecx,message
mov edx,13
int 80h

call read1
call strr

mov eax,1
mov ebx,0
int 80h
strr:
	mov edi,array
	mov esi,array1
	mov cl,byte[count]
	cmp cl,byte[count1]
	jne not
	lo1:
	cmp byte[count],0
	je equal
	mov bl,byte[edi]
	cmp bl,byte[esi]
	je in
	jmp not
	

	
in:
	inc edi
	inc esi
	dec byte[count]
	dec byte[count1]
	jmp lo1
not:
	mov eax,4
	mov ebx,1
	mov ecx,no
	mov edx,1
	int 80h
	ret
equal:
	mov eax,4
	mov ebx,1
	mov ecx,eq
	mov edx,1
	int 80h	
ex:
	ret

	
read:
	mov byte[count1],0
	mov edi,array
	loo1:
		mov eax,3
		mov ebx,0
		mov ecx,temp
		mov edx,1
		int 80h
		mov al,byte[temp]
		;cmp byte[temp],32
		;je l1
		cmp byte[temp],10
		je exit
		;push ecx
		stosb
		inc byte[count1]
		jmp loo1
	exit:
		ret
read1:
	mov byte[count],0
	mov edi,array1
	l1:
		mov eax,3
		mov ebx,0
		mov ecx,temp
		mov edx,1
		int 80h
		mov al,byte[temp]
		;cmp byte[temp],32
		;je l1
		cmp byte[temp],10
		je eit
		;push ecx
		stosb
		inc byte[count]
		jmp l1
	eit:
		ret
