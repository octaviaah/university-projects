bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, scanf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    string db "amsnhdksltjfhnc*******jjak", 0
    len equ $-string
    chr db 0
    cformat db "%c", 0
    message_chr db "character=", 0
    occ dd 0
    message_fin db "it appears %d times", 0

; our code starts here
segment code use32 class=code
    start:
        ;A character string is given (defined in the data segment). Read one character from the keyboard, then count the number of occurences of that character in the given string and display the character along with its number of occurences.
        push dword message_chr
        call [printf]
        add esp, 4
        
        push dword chr
        push dword cformat
        call [scanf]
        add esp, 8
        
        mov esi, 0
        mov ecx, len-1
        the_loop:
            mov al, [string+esi]
            cmp al, byte [chr]
            jnz cont
            add dword [occ], 1
            cont:
                inc esi
                dec ecx
                jnz the_loop
                
        push dword [occ]
        push dword message_fin
        call [printf]
        add esp, 8
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
