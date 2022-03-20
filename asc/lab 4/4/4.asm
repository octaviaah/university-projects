bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 25
    n db 0
    b db 0
    c dd 0

; our code starts here
segment code use32 class=code
    start:
    ;Given the byte A, obtain the integer number n represented on the bits 2-4 of A. Then obtain the byte B by rotating A n positions to the right. Compute the doubleword C as follows:
    ;the bits 8-15 of C have the value 0
    ;the bits 16-23 of C are the same as the bits of B
    ;the bits 24-31 of C are the same as the bits of A
    ;the bits 0-7 of C have the value 1
    
        mov eax, 0
        mov al, [a]
        and eax, 0001_1100b
        
        mov cl, 2
        ror eax, cl
        
        mov edx, 0
        or edx, eax
        mov [n], dl
        
        mov eax, 0
        mov al, [a]
        
        mov cl, [n]
        ror eax, cl
        mov [b], al
        
        mov edx, 0
        or edx, 0000_0000_1111_1111b
        
        mov eax, 0
        mov al, [a]
        mov cl, 24
        rol eax, cl
        
        or edx, eax
        
        mov eax, 0
        mov al, [b]
        mov cl, 16
        rol eax, cl
        
        or edx, eax
        
        mov [c], edx
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
