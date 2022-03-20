bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 9;
    b dw 34;
    c dd 23;
    d dq 75;

; our code starts here
segment code use32 class=code
    start:
    ;(a + b - c) + (a + b + d) - (a + b)
        mov ax, [b]; b in ax
        add al, [a]; a+b
        cwd; ax->dx:ax
        mov bx, word [c]; lower part of c in bx
        mov cx, word [c+2]; upper part of c in cx
        sub ax, bx; sub the lower parts
        sbb dx, cx; sub the upper parts -> a+b-c
        push dx;
        push ax;
        pop eax; a+b-c in eax
        cdq; eax->edx:eax
        mov ebx, eax;
        mov ecx, edx; a+b-c in ecx:ebx
        mov ax, [b]; b in ax
        add al, [a]; a+b
        cwde; ax->eax
        cdq; eax->edx:eax
        add eax, dword [d]; add the lower parts
        adc edx, dword [d+4]; add the upper parts -> a+b+d
        add eax, ebx; add the lower parts
        adc edx, ecx; add the upper parts -> (a+b-c)+(a+b+d)
        mov ebx, eax;
        mov ecx, edx; (a+b-c)+(a+b+d) in ecx:ebx
        mov ax, [b]; b in ax
        add al, [a]; a+b
        cwde; ax->eax
        cdq; eax->edx:eax
        sub ebx, eax; sub the lower parts
        sbb ecx, edx; sub the upper parts -> (a+b-c)+(a+b+d)-(a+b)
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
