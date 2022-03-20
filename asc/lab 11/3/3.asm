bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    s1 db "a53^21aps", 0
    len1 equ ($-s1)
    s2 db "21nc*5al2", 0
    len2 equ ($-s2)
    sf times len1+len2 db 0

; our code starts here
segment code use32 class=code
    start:
        ;Two strings containing characters are given. Calculate and display the result of the concatenation of all characters of type decimal number from the second string, and then followed by those from the first string, and vice versa, the result of concatenating the characters from the first string after those from the second string.
        mov esi, 0
        mov edi, 0
        add_dec_2:
            mov al, [s2+esi]
            cmp al, '0'
            jb redo1
            cmp al, '9'
            ja redo1
            mov [sf+edi], al
            inc edi
            redo1:
                inc esi
                cmp esi, len2-1
                jz cont1
            jmp add_dec_2
        cont1:
        mov esi, 0
        add_dec_1:
            mov al, [s1+esi]
            cmp al, '0'
            jb redo2
            cmp al, '9'
            ja redo2
            mov [sf+edi], al
            inc edi
            redo2:
                inc esi
                cmp esi, len1-1
                jz cont2
            jmp add_dec_1
        cont2:
        mov esi, 0
        add_ch_1:
            mov al, [s1+esi]
            cmp al, '0'   
            je redo3
            cmp al, '1'   
            je redo3
            cmp al, '2'   
            je redo3
            cmp al, '3'   
            je redo3
            cmp al, '4'   
            je redo3
            cmp al, '5'   
            je redo3
            cmp al, '6'   
            je redo3
            cmp al, '7'   
            je redo3
            cmp al, '8'   
            je redo3
            cmp al, '9'   
            je redo3
            mov [sf+edi], al
            inc edi
            redo3:
                inc esi
                cmp esi, len1-1
                jz cont3
            jmp add_ch_1
        cont3:
        mov esi, 0
        add_ch_2:
            mov al, [s2+esi]
            cmp al, '0'   
            je redo4
            cmp al, '1'   
            je redo4
            cmp al, '2'   
            je redo4
            cmp al, '3'   
            je redo4
            cmp al, '4'   
            je redo4
            cmp al, '5'   
            je redo4
            cmp al, '6'   
            je redo4
            cmp al, '7'   
            je redo4
            cmp al, '8'   
            je redo4
            cmp al, '9'   
            je redo4
            mov [sf+edi], al
            inc edi
            redo4:
                inc esi
                cmp esi, len2-1
                jz fin
            jmp add_ch_2
        fin:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
