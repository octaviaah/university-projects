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
    b dw 34;
    c dd 44;
    d dq 567;

; our code starts here
segment code use32 class=code
    start:
    ;d-(a+b+c)-(a+a)
        mov al, [a]; a in al
        cbw; al -> ax
        cwd; ax -> dx:ax
        add ax, [b]; a+b
        add ax, word [c]; add lower parts
        adc dx, word [c+2]; add upper parts -> a+b+c
        add al, [a];
        add al, [a]; (a+b+c)-(a+a)
        push dx;
        push ax;
        pop eax; saves dx:ax in eax
        cdq; eax -> edx:eax
        mov ebx, dword [d]; lower part of d in ebx
        mov ecx, dword [d+4]; upper part of d in ecx
        sub ebx, eax; sub the lower parts
        sbb ecx, edx; sub the upper parts -> d-(a+b+c)-(a+a)
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
