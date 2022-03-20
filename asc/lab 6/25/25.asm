bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 01011100b, 10001001b, 11100101b
    len equ $-a
    d times len db 0
; our code starts here
segment code use32 class=code
    start:
    ;A string of bytes is given. Obtain the mirror image of the binary representation of this string of bytes
        
        mov esi, a+len-1; source string address moved into esi
        mov edi, d; destination string in edi
        mov ecx, len
        repeta:
            mov edx, ecx
            std; parse rtl
            lodsb;move the current word in al
            mov bl, 0; bl=0 we store the reverse number here
            mov ecx, 8; byte
            revloop:
                rcr al, 1
                rcl bl, 1
            loop revloop
            mov al, bl; reverse number is stores in bl, then moved in al
            cld; parse ltr
            stosb; move the current word in edi
            mov ecx, edx
        loop repeta
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
