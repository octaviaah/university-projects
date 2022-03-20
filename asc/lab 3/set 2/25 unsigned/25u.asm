bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dw 23;
    b db 4;
    c dd 45;
    x dq 78;

; our code starts here
segment code use32 class=code
    start:
    ;(a*a+b+x)/(b+b)+c*c;
        mov ax, [a]; a in ax
        mul ax; ax*ax=dx:ax -> a*a
        add al, [b]; a*a+b
        push dx;
        push ax;
        pop ebx;
        mov ecx, 0;
        mov eax, dword [x]; lower part of x in eax
        mov edx, dword [x+4]; upper part of x in edx
        add eax, ebx; add the lower parts
        adc edx, ecx; add the upper parts
        mov bl, [b]; b in bl
        add bl, bl; b+b
        mov bh, 0;
        mov cx, 0;
        push cx;
        push bx;
        pop ebx; b+b in ebx
        div ebx; edx:eax/ebx = quotient in eax, remainder in edx ->  (a*a+b+x)/(b+b)
        mov ebx, eax;
        mov ecx, 0;
        mov eax, [c]; c in eax
        mul eax; eax*eax=edx:eax -> c*c
        add eax, ebx; add the lower parts
        adc edx, ecx; add the upper parts -> (a*a+b+x)/(b+b)+c*c
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
