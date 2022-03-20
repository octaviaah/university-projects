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
    b dw 13;
    c db 7;
    d dd 25;
    x dq 200;
; our code starts here
segment code use32 class=code
    start:
    ;d-(7-a*b+c)/a-6+x/2
        mov al, [a]; a in al;
        cbw; al->ax
        imul word [b]; ax*[b]=dx:ax -> a*b
        mov bx, ax;
        mov cx, dx; a*b in cx:bx
        mov al, 7; 7 in al
        cbw; al->ax
        cwd; ax->dx:ax
        sub ax, bx; sub the lower parts
        sbb dx, cx; sub the upper parts -> 7-a*b
        add al, [c]; 7-a*b+c
        mov bx, ax;
        mov cx, dx; 7-a*b+c in cx:bx
        mov al, [a]; a in al
        cbw; al->ax
        push ax;
        mov ax, bx;
        mov dx, cx; 7-a*b+c in dx:ax
        pop bx; a in bx now
        idiv bx; dx:ax/bx = quotient in ax, remainder in dx -> (7-a*b+c)/a
        cwd; ax->dx:ax
        mov bx, word [d]; lower part of d in bx
        mov cx, word [d+2]; upper part of d in cx
        sub bx, ax; sub the lower parts
        sbb cx, dx; sub the upper parts -> d-(7-a*b+c)/a in cx:bx
        mov dl, 6; 6 in dl;
        sub bl, dl; d-(7-a*b+c)/a-6
        push cx;
        push bx;
        mov ebx, dword [x]; lower part of x in ebx
        mov ecx, dword [x+4]; upper part of x in ecx
        mov ax, 2; 2 in ax;
        cwde; ax->eax
        mov edx, eax; 2 in edx
        mov eax, ebx; lower part of x in eax
        mov ebx, edx; 2 in ebx
        mov edx, ecx; upper part of x in edx
        idiv ebx; edx:eax/ebx = quotient in eax, remainder in edx -> x/2
        pop ebx; d-(7-a*b+c)/a-6
        add eax, ebx; d-(7-a*b+c)/a-6+x/2
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
