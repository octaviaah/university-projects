bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 4;
    b db 0Ah;
    c db 1;
    d db 0Bh;

; our code starts here
segment code use32 class=code
    start:
        mov al, [a];
        mov bl, [b];
        mov cl, [c];
        mov dl, [d];
        add cl, dl; cl
        add cl, dl; cl
        add al, al; al
        add al, bl; al
        sub cl, al; cl
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
