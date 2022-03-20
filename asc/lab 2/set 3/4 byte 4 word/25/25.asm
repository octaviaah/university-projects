bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    b db 4;
    c db 9;
    e dw 23;
    f dw 45;
    g dw 21;

; our code starts here
segment code use32 class=code
    start:
        mov bx, [e];
        mov cx, [f];
        mov dx, [g];
        add bx, cx; bx
        sub bx, dx; bx
        mov al, [b];
        mov cl, [c];
        add al, cl; al
        mov cl, 3;
        mul cl; new result in ax
        add ax, bx; ax
        mov bl, 5;
        div bl; quotient in al, remainder in ah
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
