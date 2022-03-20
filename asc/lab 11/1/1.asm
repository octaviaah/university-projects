bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, rotate              ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dd 36258
    xformat db "%x", 0
; our code starts here
segment code use32 class=code
    start:
    ;An unsigned number a on 32 bits is given. Print the hexadecimal representation of a, but also the results of the circular permutations of its hex digits.
        mov eax, [a]
        push eax
        push dword xformat
        call [printf]
        add esp, 4*2
        
        mov eax, [a]
        
        push eax
        call rotate
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
