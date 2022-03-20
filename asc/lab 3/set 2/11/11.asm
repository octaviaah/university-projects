bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dd 128;
    b db 2;
    c db 3;
    x dq 14;

; our code starts here
segment code use32 class=code
    start:
    ;(a+b)/(2-b*b+b/c)-x; a-doubleword; b,c-byte; x-qword
        mov al, [b]; b is in al
        cbw; al->ax
        idiv byte [c]; quotient of b/c is in al, remainder is in ah
        mov bl, al; b/c from al to bl
        mov al, [b]; b is in al
        cbw; al->ax
        imul byte [b]; b*b in ax
        mov cx, ax; b*b from ax to cx
        mov ax, 2;
        sub ax, cx; 2-b*b
        add al, bl; 2-b*b+b/c
        mov bx, ax; ax is in bx -> 2-b*b+b/c
        mov ax, word [a]; lower part of a in ax
        mov dx, word [a+2]; upper part of a in dx
        add al, [b]; a+b
        idiv bx; quotient of (a+b)/(2-b*b+b/c) is in ax, remainder in dx
        cwde; ax->eax
        cdq; eax->edx:eax
        mov ebx, dword [x]; lower part of x in ebx
        mov ecx, dword [x+4]; upper part of x in ecx
        sub eax, ebx; sub the lower parts
        sbb edx, ecx; sub the upper parts -> (a+b)/(2-b*b+b/c)-x
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
