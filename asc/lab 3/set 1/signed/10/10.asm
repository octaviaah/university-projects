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
    b dw 54;
    c dd 100;
    d dq 140;

; our code starts here
segment code use32 class=code
    start:
    ;b+c+d+a-(d+c)
        mov ax, [b]; b in ax
        cwd; ax->dx:ax
        mov bx, word [c]; lower part of c in bx
        mov cx, word [c+2]; upper part of c in cx
        add ax, bx; add the lower parts
        adc dx, cx; add the upper parts -> b+c
        push dx;
        push ax;
        pop eax; b+c in eax
        cdq; eax->edx:eax
        mov ebx, dword [d]; lower part of d in ebx
        mov ecx, dword [d+4]; upper part of d in ecx
        add eax, ebx; add the lower parts
        adc edx, ecx; add the upper parts -> b+c+d
        add al, [a]; b+c+d+a
        mov ebx, dword [d]; lower part of d in ebx
        mov ecx, dword [d+4]; upper part of d in ecx
        add ebx, [c]; d+c
        sub eax, ebx; sub the lower parts
        sbb edx, ecx; sub the upper parts -> b+c+d+a-(d+c)
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
