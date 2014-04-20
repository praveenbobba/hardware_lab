section .data
	msg1: db "Enter a string:",10
	len1: equ $-msg1
	msg2: db "Enter another string:",10
	len2: equ $-msg2
	msg3: db "The sorted strings are",10
	len3: equ $-msg3
	
section .bss

temp: resb 1
arr:  resb 1500
str: resb 35
num: resw 1
size: resw 1
add1: resd 1
add2: resd 1
flag: resb 1
i:  resb 1
j: resb 1



section .text

global _start

_start:

mov eax, 4
mov ebx, 1
mov ecx, msg1
mov edx, len1
int 80h




mov word[size],0



mov ecx,0
;reading the strings
mov byte[i],0

read_input:
mov edi,arr
movzx eax,word[size]
mov bx,30
mul bx
movzx eax,ax
add edi,eax
 
 str_read:
 mov eax, 3
	mov ebx, 0
	mov ecx, temp
	mov edx, 1
	int 80h
	
        cmp byte[temp], ' '
	 je end_read
        
	cmp byte[temp], 10
	 je end_read
	 
	 mov al, byte[temp]
	 stosb
    jmp str_read
    
  end_read:
     mov al,0
     stosb
     inc word[size]
     cmp byte[temp],' '
     je read_input
     cmp byte[temp],10
      je line

     line:
         inc byte[i]
         cmp byte[i],1
         je next_string
         jmp out
       
        next_string:
         mov eax, 4
         mov ebx, 1
         mov ecx, msg2
         mov edx, len2
         int 80h
        jmp read_input


    
     
  out: 
   mov byte[i],0
   
   
   
   outer_loop:
       mov byte[j],0
   inner_loop:
    mov ebx, arr
    movzx eax, byte[j]
    mov ecx,30
    mul cx
    add ebx, eax
    mov eax, ebx
    add eax, 30
    mov dword[add1],ebx
    mov dword[add2],eax
    call compare
    cmp byte[flag],1
    je swap
    jmp no_swap
    
    swap:
    mov esi,ebx
    mov edi,str
    mov ecx,30
    rep movsb
    ;cpy ebx to str
    mov esi,eax
    mov edi,ebx
    mov ecx,30
    rep movsb
    ;copy eax to ebx
    mov esi,str
    mov edi,eax
    mov ecx,30
    rep movsb
    ;copy str to eax
    
     no_swap:
     inc byte[j]
    mov ax, word[size]
    sub al, byte[i]
    sub al, 1
    cmp byte[j], al
    jl inner_loop

  inc byte[i]
  mov ax, word[size]
  cmp byte[i], al
jl outer_loop

mov eax, 4
mov ebx, 1
mov ecx, msg3
mov edx, len3
int 80h
   mov ecx,0
  
  
     
  print:
  mov esi,arr
mov eax,ecx
mov bx,30
mul bx
movzx eax,ax
add esi,eax
push ecx
 
print_str:
  lodsb
  mov byte[temp],al
  cmp al,0
  je end_print
  
mov eax, 4
mov ebx, 1
mov ecx, temp
mov edx, 1
int 80h
jmp print_str

end_print:
mov byte[temp],' '
mov eax, 4
mov ebx, 1
mov ecx, temp
mov edx, 1
int 80h

pop ecx
 add ecx,1
     cmp cx,word[size]
     jb print
     
exit:
     mov eax, 1
     mov ebx, 0
     int 80h




  
compare:
pusha
mov eax,dword[add1]
mov ebx,dword[add2]
mov byte[flag],0

check:
mov cl,byte[eax]
cmp cl,byte[ebx]
jg set
jl end_cmp
cmp cl,0
je end_cmp

inc eax
inc ebx

jmp check

set:
mov byte[flag],1

end_cmp:
popa
ret


