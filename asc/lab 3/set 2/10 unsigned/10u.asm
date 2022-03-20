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
    b dw 3;
    c db 6;
    d dd 25;
    x dq 200;

; our code starts here
segment code use32 class=code
    start:
    ;d-(7-a*b+c)/a-6+x/2
        mov al, [a]; a in al
        mov ah, 0;
        mul word [b]; ax*b=dx:ax -> a*b in dx:ax
        mov bx, 7;
        mov cx, 0;7 in cx:bx for subtraction
        sub bx, ax; sub the lower parts
        sbb cx, dx; sub the upper parts -> 7-a*b
        add bl, [c]; 7-a*b+c
        mov ax, bx;
        mov dx, cx; 7-a*b+c in dx:ax
        mov bl, [a]; a in bl
        mov bh, 0;
        div bx; dx:ax/bx = quotient in ax, remainder in dx -> (7-a*b+c)/a
        mov dx, 0;
        mov bx, word [d]; lower part of d in bx
        mov cx, word [d+2]; upper part of d in cx
        sub bx, ax; sub the lower parts
        sbb cx, dx; sub the upper parts -> d-(7-a*b+c)/a
        mov dl, 6;
        sub bl, dl; d-(7-a*b+c)/a-6
        push cx;
        push bx; move cx:bx to the stack
        pop ecx; d-(7-a*b+c)/a-6 is in ecx
        mov eax, dword [x]; lower part of x in eax
        mov edx, dword [x+4]; upper part of x in edx
        mov bx, 0;
        push bx;
        mov bl, 2;
        mov bh, 0;
        push bx;
        pop ebx; 2 is in ebx
        div ebx; edx:eax/ebx = quotient in eax, remainder in edx -> x/2
        mov ebx, 0;
        mov edx, 0;
        add eax, ecx; add the lower parts
        adc edx, ebx; add the upper parts -> d-(7-a*b+c)/a-6+x/2
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
