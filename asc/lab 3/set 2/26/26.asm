bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dw 14;
    b db 4;
    c dw 25;
    d dd 28;
    x dq 32;

; our code starts here
segment code use32 class=code
    start:
    ;(a*a+b/c-1)/(b+c)+d-x; a-word; b-byte; c-word; d-doubleword; x-qword
        mov ax, [a]; a in ax
        imul word [a]; a*a in dx:ax
        mov cx, dx;
        mov bx, ax; a*a in cx:bx
        mov al, [b]; b in al
        cbw; al->ax
        cwd; ax->dx:ax
        idiv word [c]; quotient of b/c in ax, remainder in dx
        add bx, ax; a*a+b/c
        mov dl, 1;
        sub bl, dl; a*a+b/c-1
        mov ax, bx; lower part of a*a+b/c-1 in ax
        mov dx, cx; upper part of a*a+b/c-1 in dx
        mov cx, [c]; c is in cx
        add cl, [b]; c+b
        idiv cx; quotient of (a*a+b/c-1)/(b+c) in ax, remainder in dx
        cwde; ax->eax
        add eax, [d]; (a*a+b/c-1)/(b+c)+d
        cdq; eax->edx:eax
        mov ebx, dword[x]; lower part of x in ebx
        mov ecx, dword[x+4]; upper part of x in ecx
        sub eax, ebx; sub the lower parts
        sbb edx, ecx; sub the upper parts -> (a*a+b/c-1)/(b+c)+d-x
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
