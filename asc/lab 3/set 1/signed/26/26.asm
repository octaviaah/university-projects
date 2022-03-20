bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 5;
    b dw 128;
    c dd 58;
    d dq 40;

; our code starts here
segment code use32 class=code
    start:
    ;(c-d-a)+(b+b)-(c+a)

        mov bx, [b];
        add bx, [b]; b+b
        mov ax, bx;
        cwd; ax -> dx:ax
        mov bx, word [c]; lower part of c in bx
        mov cx, word [c+2]; upper part of c in cx
        add bl, [a]; c+a
        sub ax, bx; sub the lower parts
        sbb dx, cx; sub the upper parts -> (b+b)-(c+a)
        push dx;
        push ax;
        pop ecx; dx:ax is now ecx - (b+b)-(c+a)
        mov eax, [c];
        cdq; eax -> edx:eax
        sub eax, dword [d];  sub the lower parts
        sbb edx, dword [d+4]; sub the upper parts -> c-d
        mov bl, [a];
        sub al, bl; c-d-a
        push ecx;
        mov ebx, eax;
        mov ecx, edx; edx:eax is now ecx:ebx - c-d-a
        pop eax; ecx is now eax - (b+b)-(c+a)
        cdq; eax -> edx:eax
        add ebx, eax; add the lower parts
        adc ecx, edx; add the upper parts -> (c-d-a)+(b+b)-(c+a)
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
