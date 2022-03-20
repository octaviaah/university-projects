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
    dformat db "%d", 0
    message_a db "a=", 0
    xformat db "%x", 0
; our code starts here
segment code use32 class=code
    start:
        ;Read a number in base 10 from the keyboard and display the value of that number in base 16
        push dword message_a
        call [printf]
        add esp, 4
        
        push dword a
        push dword dformat
        call [scanf]
        add esp, 4*2
        
        push dword [a]
        push dword xformat
        call [printf]
        add esp, 8
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
