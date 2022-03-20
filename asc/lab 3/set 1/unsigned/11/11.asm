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
    b dw 12;
    c dd 230;
    d dq 1000;

; our code starts here
segment code use32 class=code
    start:
    ;(d-c)+(b-a)-(b+b+b)
        mov eax, dword [d]; lower part of d in eax
        mov edx, dword [d+4]; upper part of d in edx
        mov ebx, [c]; c is in ebx
        mov ecx, 0; so we have qword-qword
        sub eax, ebx; sub the lower parts
        sbb edx, ecx; sub the upper parts -> now we have d-c
        mov ebx, 0; convert to dword
        mov bl, byte [b]; lower part of b in bl
        mov bh, byte [b+1]; upper part of b in bh
        mov cx, 0; convert to word
        mov cl, [a]; a is in cl
        sub bl, cl; sub the lower parts
        sbb bh, ch; sub the upper parts -> now we have b-a
        add eax, ebx; (d-c) + (b-a)
        mov ebx, 0; convert to dword
        mov bx, [b];
        add bx, [b];
        add bx, [b]; now we have b+b+b
        sub eax, ebx; (d-c)+(b-a)-(b+b+b)
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
