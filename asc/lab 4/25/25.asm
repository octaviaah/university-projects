bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    m dd 0110_1111_0010_0100_1000_1000_1101_0000b
    n dd 1100_1000_0011_0101_1010_0000_1001_1101b
    p dd 0

; our code starts here
segment code use32 class=code
    start:
    ;Given the doublewords M and N, compute the doubleword P as follows.
        ;the bits 0-6 of P are the same as the bits 10-16 of M
        ;the bits 7-20 of P are the same as the bits 7-20 of (M AND N).
        ;the bits 21-31 of P are the same as the bits 1-11 of N.
        mov eax, [m]; move m to eax so we can isolate the bits 10-16
        and eax, 0000_0000_0000_0001_1111_1100_0000_0000b; we isolate bits 10-16
        mov cl, 10; we will shift 10 positions to the right
        shr eax, cl; bits 10-16 are on positions 0-6
        mov [p], eax
        
        mov eax, [m]; move m in eax for 'and' operation
        and eax, [n]; m and n
        and eax, 0000_0000_0001_1111_1111_1111_1000_0000b; we isolate bits 7-20
        or [p], eax; we move bits 7-20 in p
        
        mov eax, [n]; move n to eax so we can isolate bits 1-11
        and eax, 0000_0000_0000_0000_0000_1111_1111_1110b; we isolate bits 1-11
        mov cl, 20; we will shift 20 position to the left
        shl eax, cl; bits 1-11 are on positions 21-31
        or [p], eax; we move bits 1-11 in p
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
