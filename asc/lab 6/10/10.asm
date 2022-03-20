bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dw 241Ah, 32ABh, 0ABCh
    len equ ($-a)/2; length of the string in words
    b1 times len db 0
    b2 times len db 0

; our code starts here
segment code use32 class=code
    start:
    ;Given an array A of words, build two arrays of bytes:  
    ;- array B1 contains as elements the higher part of the words from A
    ;- array B2 contains as elements the lower part of the words from A
        
        mov esi, a; move the far address of the string in esi
        cld; parse the string from left to right
        mov ecx, len; keep the length of the string in ecx
        mov edi, b1; we move the destination string, b1, in edi
        repeta1:
            movsb; move low part of current word into b1
            lodsb; move high part into al
        loop repeta1
        
        mov esi, a; move the far address of the string in esi
        cld; parse the string from left to right
        mov edi, b2; we move th destination string, b2, in edi
        mov ecx, len
        repeta2:
            lodsb; move low part into al
            movsb; move high part of current word into b2
        loop repeta2
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
