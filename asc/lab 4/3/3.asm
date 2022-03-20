bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dw 25ah
    b dw 2201h
    c dd 0

; our code starts here
segment code use32 class=code
    start:
    ;Given the words A and B, compute the doubleword C as follows:
    ;the bits 0-2 of C are the same as the bits 12-14 of A
    ;the bits 3-8 of C are the same as the bits 0-5 of B
    ;the bits 9-15 of C are the same as the bits 3-9 of A
    ;the bits 16-31 of C are the same as the bits of A
    
        mov eax, 0
        mov ax, [a]
        and eax, 0111_0000_0000_0000b
        
        mov cl, 12
        ror eax, cl
        
        mov edx, 0
        or edx, eax
        
        mov eax, 0
        mov ax, [b]
        and eax, 0000_0000_0011_1111b
        
        mov cl, 3
        rol eax, cl
        or edx, eax
        
        mov eax, 0
        mov ax, [a]
        and eax, 0000_0011_1111_1000b
        
        mov cl, 6
        rol eax, cl
        or edx, eax
        
        mov eax, 0
        mov ax, [a]
        mov cl, 16
        rol eax, cl
        or edx, eax
        
        mov [c], edx
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
