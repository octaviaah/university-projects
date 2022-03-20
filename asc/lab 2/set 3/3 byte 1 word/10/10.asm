bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 6;
    b db 9;
    c db 5;
;3*[20*(b-a+2)-10*c]/5
; our code starts here
segment code use32 class=code
    start:
        mov al, [a];
        mov bl, [b];
        mov cl, [c];
        sub bl, al; result in bl
        add bl, 2; bl
        mov al, bl; al
        mov dl, 20; dl
        mul dl; new result is in ax
        mov bx, ax; bx
        mov al, cl; al
        mov dl, 10; dl
        mul dl; new result is in ax
        mov cx, ax; cx
        sub bx, cx; bx
        mov ax, bx; ax
        mov dl, 3; dl
        mul dl; new result in ax
        mov dl, 5; dl
        div dl; quotient in al, remainder in ah
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
