bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    s1 db '+', '2', '2', 'b', '8', '6', 'X', '8'
    l1 equ $-s1
    s2 db 'a', '4', '5'
    l2 equ $-s2
    d times l1+l2 db 0
; our code starts here
segment code use32 class=code
    start:
    ;Two character strings S1 and S2 are given. Obtain the string D by concatenating the elements of S2 in reverse order and the elements found on even positions in S1.
    ;D: '5', '4', 'a', '2','b', '6', '8'
    ;Q: does the index start at 0 or 1?
        mov ecx, l2; ecx becomes l2
        mov esi, l2-1; we will go through the string in reverse
        mov edi, 0; index of d will be increasing
        jecxz Final1
        Repeta1:
           mov al, [s2+esi]
           mov [d+edi], al
           inc edi
           dec esi
        loop Repeta1
        Final1:
        
        mov eax, l1
        mov edx, 0; l1 is in edx:eax
        mov ecx, 2
        div ecx; edx:eax/ecx -> if parity even, edx is 0, else edx is 1
        add eax, edx
        mov ecx, eax; we obtain the number of steps required to get all the elements from even positions
        
        mov esi, 1
        mov edi, l2; we set edi to l2 so we continue to add in d
        jecxz Final2
        Repeta2:
            mov al, [s1+esi]
            mov [d+edi], al
            inc esi
            inc esi
            inc edi
        loop Repeta2
        Final2:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
