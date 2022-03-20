bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 7;
    b dw 25;
    c dd 68;
    d dq 147;
    

; our code starts here
segment code use32 class=code
    start:
    ;(c-b+a)-(d+a)
        mov ax, word [c]; lower part of c in ax
        mov dx, word [c+2]; upper part of c in dx
        mov cx, 0; upper part of b is 0
        sub ax, [b]; sub the lower parts
        sbb dx, cx; sub the upper parts -> c-b
        mov bx, 0;
        mov bl, [a];
        add ax, bx; -> c-b+a
        push dx;
        push ax;
        pop eax; -> c-b+a is now in eax
        mov ebx, dword [d]; lower part of d in ebx
        mov ecx, dword [d+4]; upper part of d in ecx
        mov edx, 0;
        mov dl, [a];
        add ebx, edx; d+a
        mov edx, 0;
        sub eax, ebx;
        sbb edx, ecx;
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
