bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dw 25;
    b db 9;
    c dd 84;
    x dq 100;
    
; our code starts here
segment code use32 class=code
    start:
    ;(a*a+b+x)/(b+b)+c*c
        mov ax, [a]; a in ax
        imul ax; ax*ax=dx:ax -> a*a
        add al, [b]; a*a+b
        push dx;
        push ax;
        pop eax;
        cdq; eax->edx:eax
        mov ebx, dword [x]; lower part of x in ebx
        mov ecx, dword [x+4]; upper part of x in ecx
        add eax, ebx; add the lower parts
        adc edx, ecx; add the upper parts -> a*a+b+x
        mov ebx, eax;
        mov ecx, edx; a*a+b+x in ecx:ebx
        mov al, [b]; b in al
        add al, al; b+b
        cbw; al->ax
        cwde; ax->eax
        mov edx, eax; b*b in edx
        mov eax, ebx; lower part of a*a+b+x in eax
        mov ebx, edx; b*b in ebx
        mov edx, ecx; upper part of a*a+b+x in edx
        idiv ebx; edx:eax/ebx = quotient in eax, remainder in edx ->  (a*a+b+x)/(b+b)
        mov ebx, eax;
        mov eax, [c]; c in eax
        imul eax; eax*eax=edx:eax -> c*c
        mov ecx, eax; lower part of c*c in ecx
        mov eax, ebx; (a*a+b+x)/(b+b) in eax
        mov ebx, edx; upper part of c*c in ebx
        cdq; eax->edx:eax
        add eax, ecx; add the lower parts
        adc edx, ebx; add the upper parts -> (a*a+b+x)/(b+b)+c*c
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
