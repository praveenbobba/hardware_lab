section .text

global _start:
  _start:


push eax
  push ebx
  push ecx
  push edx

    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, msglen1
    int 80h
  pop edx
  pop ecx
  pop ebx
  pop eax

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

; MAIN PROCESS		


mov al, 0
mov al, byte[string_len]
mov byte[temp4], al
mov eax, 0
mov edx, 0

; FINDING LARGEST AND SMALLEST WORD IN A STRING

first_round:

   mov ebx, string1
   movzx eax, byte[index]
   cmp byte[ebx + eax], 0
   je just_print

cmp byte[ebx + eax], 32
je firstrou_i
mov cl, byte[ebx + eax]
mov ebx, dum
mov byte[ebx + edx], cl 
inc byte[dum_len]
inc eax
inc edx
inc byte[index]
jmp first_round

just_print:

mov al, 0
mov al, byte[string_len]
mov byte[temp4], al
mov ebx, 0
mov ebx, string1

print_char4:

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

jmp print_char4










firstrou_i:

mov cl, byte[dum_len]
mov byte[lengthl], cl

mov cl, byte[dum_len]
mov byte[lengths], cl

mov esi, zero_array
   mov edi, dum
   mov ecx, 100
   REP MOVSB

   mov byte[dum_len], 0
   mov edx, 0
   pop eax
   inc eax
   inc byte[index]

L1:

   mov ebx, string1
   movzx eax, byte[index]
   cmp byte[ebx + eax], 0
   je final_check

cmp byte[ebx + eax], 32
je L2
mov cl, byte[ebx + eax]
mov ebx, dum
movzx edx, byte[dum_len]
mov byte[ebx + edx], cl 
inc byte[dum_len]
inc eax
inc byte[index]
inc edx

jmp L1

final_check:

mov cl, byte[dum_len]
cmp cl, byte[lengthl]
ja Lfinal
    cmp cl, byte[lengths]
    jb Lfinal2
   mov esi, zero_array
   mov edi, dum
   mov ecx, 100
   REP MOVSB

   mov byte[dum_len], 0
   mov edx, 0
   jmp Ld

Lfinal:

mov cl, byte[dum_len]
mov byte[lengthl], cl

mov esi, zero_array
   mov edi, dum
   mov ecx, 100
   REP MOVSB

   mov byte[dum_len], 0
   mov edx, 0
   jmp Ld

Lfinal2:

mov cl, byte[dum_len]
mov byte[lengths], cl

mov esi, zero_array
   mov edi, dum
   mov ecx, 100
   REP MOVSB

   mov byte[dum_len], 0
   mov edx, 0
jmp Ld


Ld:

CLD

mov esi, zero_array
   mov edi, dum
   mov ecx, 100
   REP MOVSB

   mov byte[dum_len], 0

mov al, 0
mov al, byte[string_len]
mov byte[temp4], al
mov eax, 0
mov edx, 0

for1:

   mov ebx, string1
   movzx eax, byte[index2]
   cmp byte[ebx + eax], 0
   je final_check_string

cmp byte[ebx + eax], 32
je Ls2
mov cl, byte[ebx + eax]
mov ebx, dum
mov byte[ebx + edx], cl 
inc byte[dum_len]
inc eax
inc byte[index2]
inc edx

jmp for1


final_check_string:

mov cl, byte[dum_len]
cmp byte[lengthl], cl
je insert_largest1
   cmp byte[lengths], cl
   je insert_smallest1
      jmp printing_string

insert_smallest1:

call put_word_smallest
jmp printing_string

insert_largest1:

call put_word_largest
jmp printing_string

Ls2:

push eax
mov cl, byte[dum_len]
cmp byte[lengthl], cl
je insert_largest
   cmp byte[lengths], cl
   je insert_smallest

   mov esi, zero_array
   mov edi, dum
   mov ecx, 100
   REP MOVSB

   mov byte[dum_len], 0
   mov edx, 0
   pop eax
   inc eax
   inc byte[index2]
   jmp for1

insert_smallest:

call put_word_smallest

mov esi, zero_array
   mov edi, dum
   mov ecx, 100
   REP MOVSB

   mov byte[dum_len], 0
   mov edx, 0
   pop eax
   inc eax
   inc byte[index2]
   jmp for1


insert_largest:

call put_word_largest

mov esi, zero_array
   mov edi, dum
   mov ecx, 100
   REP MOVSB

   mov byte[dum_len], 0
   mov edx, 0
   pop eax
   inc eax
   inc byte[index2]
   jmp for1


L2:

push eax

mov cl, byte[dum_len]
cmp cl, byte[lengthl]
ja L3
    cmp cl, byte[lengths]
    jb L4
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


; PUTTING THE LARGEST WORD IN THE LARGEST STRING

L3:

mov cl, byte[dum_len]
mov byte[lengthl], cl

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

L4:

mov cl, byte[dum_len]
mov byte[lengths], cl

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


put_word_largest:

push eax
push ebx
push ecx
push edx

mov ebx, largest
mov al, byte[dum_len]
mov byte[temp4], al
mov eax, 0
movzx edx, byte[index_largest]


put_char1:

cmp byte[temp4], 0
je end_char1
dec byte[temp4]
mov ebx, dum
mov cl, byte[ebx + eax]
mov ebx, largest
mov byte[ebx + edx], cl
inc edx
inc eax
inc byte[index_largest]
jmp put_char1 

end_char1:

mov al, 0
mov al, 32
mov ebx, largest
mov byte[ebx + edx], al
inc byte[index_largest]

pop eax
pop ebx
pop ecx
pop edx

ret


put_word_smallest:

push eax
push ebx
push ecx
push edx

mov ebx, smallest
mov al, byte[dum_len]
mov byte[temp4], al
mov eax, 0
movzx edx, byte[index_smallest]


put_char2:

cmp byte[temp4], 0
je end_char2
dec byte[temp4]
mov ebx, dum
mov cl, byte[ebx + eax]
mov ebx, smallest
mov byte[ebx + edx], cl
inc edx
inc eax
inc byte[index_smallest]
jmp put_char2 

end_char2:

mov al, 0
mov al, 32
mov ebx, smallest
mov byte[ebx + edx], al
inc byte[index_smallest]

pop eax
pop ebx
pop ecx
pop edx

ret


printing_string:
mov al, 0
mov al, byte[index_largest]
mov byte[temp4], al
mov ebx, 0
mov ebx, largest

print_char:
cmp byte[temp4], 0
je print_string2
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
print_string2:
  pusha
    mov eax, 4
    mov ebx, 1
    mov ecx, line
    mov edx, 1
    int 80h
  popa
mov al, 0
mov al, byte[index_smallest]
mov byte[temp4], al
mov ebx, 0
mov ebx, smallest
print_char1:
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
jmp print_char1
exit:
    mov eax, 4
    mov ebx, 1
    mov ecx, line
    mov edx, 1
    int 80h
mov eax, 1
mov ebx, 0
int 80h
section .data
string_len: db 0
msg1: db "string: "
msglen1: equ $-msg1

line: db 10
lengths: db 0
lengthl: db 0
index_largest: db 0
zero_array: TIMES 100 db 0
index_smallest: db 0
index: db 0
dum_len: db 0
index2: db 0

section .bss

string1: resb 100
string2: resb 100
smallest: resb 100
largest: resb 100
dum: resb 100
temp: resb 2
temp4: resb 1
