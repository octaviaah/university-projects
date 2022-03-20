bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 2;
    b dw 5;
    c dd 25;
    d dq 74;

; our code starts here
segment code use32 class=code
    start:
    ;(a+d+d)-c+(b+b)
        mov eax, dword [d]; the lower part of d in eax
        mov edx, dword [d+4]; the upper part of d in edx
        add eax, eax; add the lower parts
        adc edx, edx; add the upper parts -> d+data
        add al, [a]; d+d+ad
        sub eax, [c]; (a+d+d)-c
        mov bx, [b];
        add bx, [b]; b+b
        add ax, bx; (a+d+d)-c+(b+b)
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
