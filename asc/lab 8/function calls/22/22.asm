bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, scanf              ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dd 0
    b dd 0
    k dd 6
    dformat db "%d", 0
    message_a db "a=", 0
    message_b db "b=", 0
    message_fin db "result=%d", 0
    result resd 2

; our code starts here
segment code use32 class=code
    start:
        ;Two numbers a and b are given. Compute the expression value: (a+b)*k, where k is a constant value defined in data segment. Display the expression value (in base 10).
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
        mov eax, [a]
        add eax, [b]
        
        xor ebx, ebx
        mov ebx, [k]
        imul ebx
        
        mov dword [result], eax
        mov dword [result+4], edx
        
        push dword [result]
        push dword message_fin
        call [printf]
        add esp, 8
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
