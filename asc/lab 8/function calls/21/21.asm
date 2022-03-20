bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, scanf, printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a resw 2
    b resw 2
    c dd 0
    dformat db "%d", 0
    xformat db "%x", 0
    message_a db "a=", 0
    message_b db "b=", 0
    message_c db "c=%x", 0

; our code starts here
segment code use32 class=code
    start:
        ;Read two words a and b in base 10 from the keyboard. Determine the doubleword c such that the low word of c is given by the sum of the a and b and the high word of c is given by the difference between a and b. Display the result in base 16 Example:
        ;a = 574, b = 136
        ;c = 01B602C6h
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
        
        xor eax, eax
        mov ax, [a]
        mov bx, [b]
        add ax, bx
        mov word [c], ax
        
        xor eax, eax
        mov ax, [a]
        mov bx, [b]
        sub ax, bx
        mov word [c+2], ax
        
        push dword [c]
        push dword message_c
        call [printf]
        add esp, 8
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
