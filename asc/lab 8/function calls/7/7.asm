bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dd 23
    b dd 8
    message db "%d mod %d = %d", 0
; our code starts here
segment code use32 class=code
    start:
        ;Two natural numbers a and b (a: dword, b: dword, defined in the data segment) are given. Calculate a/b and display the remainder in the following format: "<a> mod <b> = <remainder>". Example: for a = 23, b = 5 it will display: "23 mod 5 = 3".
        ;The values will be displayed in decimal format (base 10) with sign.
        
        xor eax, eax
        xor ebx, ebx
        mov eax, [a]
        mov ebx, [b]
        cdq
        idiv ebx
        
        push edx
        push dword [b]
        push dword [a]
        push dword message
        call [printf]
        add esp, 4*4
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program