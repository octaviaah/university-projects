bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, scanf, printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a resb 4
    b resw 2
    dformat db "%d", 0
    message_a db "a=", 0
    message_b db "b=", 0
    message_no db "NO", 0
    message_yes db "YES", 0

; our code starts here
segment code use32 class=code
    start:
        ;Read one byte and one word from the keyboard. Print on the screen "YES" if the bits of the byte read are found consecutively among the bits of the word and "NO" otherwise. Example: a = 10 = 0000 1010b
        ;b = 256 = 0000 0001 0000 0000b
        ;The value printed on the screen will be NO.
        ;a = 0Ah = 0000 1010b
        ;b = 6151h = 0110 0001 0101 0001b
        ;The value printed on the screen will be YES (you can find the bits on positions 5-12).
        
        push dword message_a
        call [printf]
        add esp, 4
        
        push dword a
        push dword dformat
        call [scanf]
        add esp, 8
        
        push dword message_b
        call [printf]
        add esp, 4
        
        push dword b
        push dword dformat
        call [scanf]
        add esp, 8
        
        mov ecx, 13
        mov ax, [b]
        
        verify_bits:
            cmp al, [a]
            jz print_yes
            ror ax, 1
            dec ecx
            jnz verify_bits
            jz print_no
            
        print_yes:
            push dword message_yes
            call [printf]
            add esp, 4
            jmp fin
            
        print_no:
            push dword message_no
            call [printf]
            add esp, 4
            jmp fin
        fin:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
