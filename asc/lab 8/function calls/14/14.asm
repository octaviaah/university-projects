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
    a dd 0
    b dd 0
    xformat db "%x", 0
    message_a db "a=", 0
    message_b db "b=", 0
    message_a_b db "a+b=%d", 0

; our code starts here
segment code use32 class=code
    start:
        ;Read two numbers a and b (in base 16) from the keyboard and calculate a+b. Display the result in base 10
        push dword message_a
        call [printf]
        add esp, 4
        
        push dword a
        push dword xformat
        call [scanf]
        add esp, 8
        
        push dword message_b
        call [printf]
        add esp, 4
        
        push dword b
        push dword xformat
        call [scanf]
        add esp, 8
        
        xor eax, eax
        mov eax, [a]
        add eax, [b]
        
        push eax
        push dword message_a_b
        call [printf]
        add esp, 8
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
