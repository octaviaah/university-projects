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
    b db 3;
    c db 9;
    d db 11;

; our code starts here
segment code use32 class=code
    start:
        mov al, [a];
        mov cl, [c];
        mov dl, [d];
        mul dl; new result in ax
        mov dx, ax; dx
        mov al, [b];
        mul cl; new result in ax
        add ax, dx; ax
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
