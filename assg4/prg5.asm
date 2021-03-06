section .text
global _start:
  _start:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, msglen1
    int 80h
mov ebx, string1
reading_string:
push ebx
    mov eax, 3
    mov ebx, 0
    mov ecx, temp
    mov edx, 1
    int 80h
pop ebx
cmp byte[temp], 10
je end_reading
   inc byte[string_len]
   mov al, byte[temp]
   mov byte[ebx], al
   inc ebx
   jmp reading_string
end_reading:
mov byte[ebx], 0
pusha
    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, msglen2
    int 80h
popa

mov ebx, string2
reading_string1:
push ebx
    mov eax, 3
    mov ebx, 0
    mov ecx, temp
    mov edx, 1
    int 80h
pop ebx
cmp byte[temp], 10
je end_reading1
   inc byte[string_len2]
   mov al, byte[temp]
   mov byte[ebx], al
   inc ebx
   jmp reading_string1
end_reading1:
mov byte[ebx], 0
pusha
    mov eax, 4
    mov ebx, 1
    mov ecx, msg3
    mov edx, msglen3
    int 80h
popa
mov ebx, string_given
reading_string2:
push ebx
    mov eax, 3
    mov ebx, 0
    mov ecx, temp
    mov edx, 1
    int 80h
pop ebx
cmp byte[temp], 10
je end_reading2
   inc byte[string_given_len]
   mov al, byte[temp]
   mov byte[ebx], al
   inc ebx
   jmp reading_string2

end_reading2:

mov byte[ebx], 0


; MAIN PROCESS


mov al, 0
mov al, byte[string_len]
mov byte[temp4], al
mov ebx, string1
mov eax, 0
mov edx, 0

L1:
   movzx eax, byte[index]
   mov ebx, string1
   cmp byte[ebx + eax], 0
   je printing_string

cmp byte[ebx + eax], 32
je L2
mov cl, byte[ebx + eax]
mov ebx, dum
mov byte[ebx + edx], cl 
inc byte[dum_len]
inc byte[index]
inc edx

jmp L1


L2:

push eax

mov al, 0

mov al, byte[dum_len]
mov byte[temp4], al

mov al, byte[string_len2]

cmp al, byte[dum_len]
je check_char
   call put_word
   mov esi, zero_array
   mov edi, dum
   mov ecx, 100
   REP MOVSB

   mov byte[dum_len], 0
   mov edx, 0
   pop eax
   inc eax
   inc byte[index]
   jmp L1


put_word:
pusha

mov ebx, string_final
mov eax, 0
movzx edx, byte[index_final]

put_char:

cmp byte[temp4], 0
je end_char
dec byte[temp4]
mov ebx, dum
mov cl, byte[ebx + eax]
mov ebx, string_final
mov byte[ebx + edx], cl
inc edx
inc eax
inc byte[index_final]
jmp put_char 

end_char:

mov al, 0
mov al, 32
mov ebx, string_final
mov byte[ebx + edx], al
inc byte[index_final]
popa
ret
check_char:
mov edx, 0
L4:
cmp byte[dum_len], 0
je found
dec byte[dum_len]
mov ebx, dum
mov cl, byte[ebx + edx]
mov byte[dummy1], cl
mov ebx, string2
mov cl, byte[ebx + edx]
mov byte[dummy2], cl
cmp byte[dummy1], cl
je L5
   call put_word
   mov esi, zero_array
   mov edi, dum
   mov ecx, 100
   REP MOVSB
   mov byte[dum_len], 0
   mov edx, 0
   pop eax
   inc eax
   inc byte[index]
   jmp L1
L5:
inc edx
jmp L4
found:
mov esi, zero_array
   mov edi, dum
   mov ecx, 100
   REP MOVSB
CLD
mov esi, string_given
   mov edi, dum
   movzx ecx, byte[string_given_len]
   REP MOVSB
mov al, byte[string_given_len]
mov byte[temp4], al
call put_word
CLD
mov esi, zero_array
   mov edi, dum
   mov ecx, 100
   REP MOVSB
   mov byte[dum_len], 0
   mov edx, 0
   pop eax
   inc eax
   inc byte[index]
   jmp L1
printing_string:
mov al, byte[string_len2]
cmp al, byte[dum_len]
je check_char1
   mov cl, byte[dum_len]
   mov byte[temp4], cl
   call put_word
   jmp print_string_final

; strt frm
check_char1:
mov edx, 0
mov al, byte[dum_len]
mov byte[temp4], al
L41:
cmp byte[dum_len], 0
je found1
dec byte[dum_len]
mov ebx, dum
mov cl, byte[ebx + edx]
mov byte[dummy1], cl
mov ebx, string2
mov cl, byte[ebx + edx]
mov byte[dummy2], cl
cmp byte[dummy1], cl
je L51
   call put_word
   jmp print_string_final
L51:
inc edx
jmp L41
found1:
mov esi, zero_array
   mov edi, dum
   mov ecx, 100
   REP MOVSB
CLD
mov esi, string_given
   mov edi, dum
   movzx ecx, byte[string_given_len]
   REP MOVSB
mov al, byte[string_given_len]
mov byte[temp4], al
call put_word
   jmp print_string_final
print_string_final:
mov al, 0
mov al, byte[index_final]
mov byte[temp4], al
mov ebx, 0
mov ebx, string_final
print_char:
cmp byte[temp4], 0
je exit
   dec byte[temp4]
mov byte[temp], 0
mov al, byte[ebx]
mov byte[temp], al
push ebx
    mov eax, 4
    mov ebx, 1
    mov ecx, temp
    mov edx, 1
    int 80h
pop ebx
inc ebx
jmp print_char
exit:
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 80h
mov eax, 1
mov ebx, 0
int 80h
section .data

string_len: db 0
string_len2: db 0
count: db 0
dum_len: db 0
index_final: db 0
string_given_len: db 0
zero_array: TIMES 100 db 0
msg1: db "string: "
msglen1: equ $-msg1
msg2: db "find: "
msglen2: equ $-msg2
msg3: db "replace: "
msglen3: equ $-msg3 
newline: db 10
index: db 0

section .bss

string1: resb 100
string2: resb 100
string_final: resb 100
string_given: resb 100
dum: resb 100
temp: resb 2
temp4: resb 1
dummy1: resb 1
dummy2: resb 1
