bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dw 0100_1001_1010_0000b
    b db 0111_0111b

; our code starts here
segment code use32 class=code
    start:
    ;Replace the bits 0-3 of the byte B by the bits 8-11 of the word A.
        mov ax, [a]; we isolate A in ax
        and ax, 0000_1111_0000_0000b; we isolate bits 8-11
        mov cl, 4
        ror ax, cl; we rotate 4 positions to the right -> 1001 are on positions 4-7
        
        mov bl, [b]; we isolate B in bl
        mov cl, 4
        ror bl, cl; we rotate 4 positions to the right -> bits 4-7 are on positions 0-3
        or ah, bl; bits 0-3 from B are on positions 8-11 in A
        mov cl, 4
        ror ax, cl; we rotate 4 positions to the right -> we obtain new B
        mov [b], al;
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
