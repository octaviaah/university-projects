bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dw 2Ch
    b dw 201h
    c dd 0

; our code starts here
segment code use32 class=code
    start:
        ;Given the words A and B, compute the doubleword C as follows:
        ;the bits 0-3 of C are the same as the bits 5-8 of B
        ;the bits 4-8 of C are the same as the bits 0-4 of A
        ;the bits 9-15 of C are the same as the bits 6-12 of A
        ;the bits 16-31 of C are the same as the bits of B
    
        mov eax, 0
        mov ax, [b]
        and eax, 0000_0001_1110_0000b ;isolate bits 5-8 of B
        
        mov cl, 5
        ror eax, cl; bits 5-8 are on positions 0-3
        
        mov edx, 0
        or edx, eax ;compute C here
        
        mov eax, 0
        mov ax, [a]
        and eax, 0000_0000_0001_1111b ; isolate bits 0-4 of A
        
        mov cl, 4
        rol eax, cl ; bits 0-4 are on position 4-8
        or edx, eax ;continue computing C
        
        mov eax, 0
        mov ax, [a]
        and eax, 0001_1111_1100_0000b ; isolate bits 6-12 of A
        
        mov cl, 3
        rol eax, cl ; bits 6-12 are on position 6-12
        or edx, eax
        
        mov eax, 0
        mov ax, [b]
        mov cl, 16
        rol eax, cl
        or edx, eax
        
        mov [c], edx
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
