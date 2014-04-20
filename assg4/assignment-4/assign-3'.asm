section .data
msg1: db "Enter str1: ", 0Ah
len1: equ $-msg1
msg2: db "Enter str2: ", 0Ah
len2: equ $-msg2
msg3: db "Circular permutation.", 0Ah
len3: equ $-msg3
msg4: db "Not a circular permutation. ", 0Ah
len4: equ $-msg4
newl: db 10

section .bss
string1: resb 50
string2: resb 50
string3: resb 50
temp: resb 1
looper: resb 1

section .text
global _start
_start:

mov eax, 4
mov ebx, 1
mov ecx, msg1
mov edx, len1
int 80h

mov ebx, string1
read1:
push ebx

mov eax, 3
mov ebx, 0
mov ecx, temp
mov edx, 1
int 80h

pop ebx

cmp byte[temp], 10
je end_read1
mov al, byte[temp]
mov byte[ebx], al
inc ebx
jmp read1

end_read1:

mov byte[ebx], 0

mov eax, 4
mov ebx, 1
mov ecx, msg2
mov edx, len2
int 80h
mov ebx, string2
read2:
push ebx

mov eax, 3
mov ebx, 0
mov ecx, temp
mov edx, 1
int 80h

pop ebx
cmp byte[temp], 10
je end_read2
mov al, byte[temp]
mov byte[ebx], al
inc ebx
jmp read2

end_read2:
mov byte[ebx], 0

mov ebx, string1
mov ecx, string3
mov byte[looper], 0

concatenate:
cmp byte[looper], 2
je exit_concatenate
mov al, byte[ebx]
cmp byte[ebx], 0
je re_init_str1
mov byte[ecx], al
inc ebx
re_init_loop_ret:
inc ecx
jmp concatenate

re_init_str1:
mov ebx, string1
inc byte[looper]
jmp re_init_loop_ret

exit_concatenate:

mov byte[ecx], 0
mov ebx, string2
mov ecx, string3

check_for_start:
cmp byte[ecx], 0
je print_no
mov al, byte[ebx]
cmp byte[ecx], al
je check_remain
check_remain_ret:
inc ecx
jmp check_for_start

check_remain:
cmp byte[ebx], 0
je print_yes
mov al, byte[ebx]
cmp byte[ecx], al
jne check_remain_ret
inc ecx
inc ebx
jmp check_remain

print_yes:

mov eax, 4
mov ebx, 1
mov ecx, msg3
mov edx, len3
int 80h
jmp exit

print_no:
mov eax, 4
mov ebx, 1
mov ecx, msg4
mov edx, len4
int 80h

exit:
mov eax, 1
mov ebx, 0
int 80h
