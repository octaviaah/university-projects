bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dw 0000_1101_0100_0101b
    b dw 0000_1001_0110_1111b
    c dd 0

; our code starts here
segment code use32 class=code
    start:
    ;Given the words A and B, compute the doubleword C as follows:
    ;the bits 0-4 of C are the same as the bits 11-15 of A
    ;the bits 5-11 of C have the value 1
    ;the bits 12-15 of C are the same as the bits 8-11 of B
    ;the bits 16-31 of C are the same as the bits of A
        
        mov eax, 0
        mov ax, [a]; moves a to eax
        
        and eax, 1111_1000_0000_0000b ;isolate bits 11-15 from A
        mov cl, 11
        ror eax, cl ;bits 11-15 are on positions 0-4
        
        mov edx, 0
        or edx, eax ;we construct C using edx
        
        or edx, 0000_1111_1110_0000b ; bits 5-11 are 1 each
        
        mov eax, 0
        mov ax, [b] ; moves b to eax
      
        and eax, 0000_1111_0000_0000b ; isolate bits 8-11 of B
        mov cl, 4
        rol eax, cl ;bits 8-11 are on positions 12-15
        
        or edx, eax; continue constructing C
        
        mov eax, 0
        mov ax, [a] ;moves a to eax
        mov cl, 16
        rol eax, cl ; bits of A are on 16-31
        
        or edx, eax ;finished C
        mov [c], edx
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
