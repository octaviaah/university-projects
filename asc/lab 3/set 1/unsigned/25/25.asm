bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 5;
    b dw 23;
    c dd 100;
    d dq 47;

; our code starts here
segment code use32 class=code
    start:
    ;(a + b + c) - (d + d) + (b + c)
        mov ax, word [c]; lower part of c in ax
        mov dx, word [c+2]; upper part of c in dx
        mov bx, [b]; b in bx
        add bl, [a]; a+b
        mov cx, 0;
        add ax, bx; add the lower parts
        adc dx, cx; add the upper parts -> a+b+call
        push dx;
        push ax;
        pop ebx; a+b+c in ebx
        mov eax, dword [d]; lower part of d in eax
        mov edx, dword [d+4]; upper part of d in edx
        add eax, eax; add the lower parts
        adc edx, edx; add the upper parts -> d+d
        mov ecx, 0;
        sub ebx, eax; sub the lower parts
        sbb ecx, edx; sub the upper parts -> (a+b+c)-(d+d)
        mov eax, [c]; c in eax
        add ax, [b]; b+c
        mov edx, 0;
        add eax, ebx; add the lower parts
        adc edx, ecx; add the upper parts -> (a+b+c)-(d+d)+(b+c)
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
