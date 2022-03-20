bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    s1 db  '+', '4', '2', 'a', '8', '4', 'X', '5'
    l1 equ $-s1
    s2 db 'a', '4', '5'
    l2 equ $-s2
    d times l1+l2 db 0
    c db 0
; our code starts here
segment code use32 class=code
    start:
    ;Two character strings S1 and S2 are given. Obtain the string D which contains all the elements of S1 that do not appear in S2
        mov esi, 0;we start looping through s1 from index 0

        outerLoop: ;we compare a fixed element from s1 with every element in s2
            cmp esi, l1-1;we loop through s1
            je done;the program finishes when outerLoop finishes
                mov edi, 0;we will loop through s2 from index 0
                mov al, [s1+esi]
                mov dl, 0; dl will be an ok variable

            innerLoop: ;we loop through s2
                mov bl, [s2+edi]
                cmp al, bl
                jne alEQbl
                    mov dl, 1; dl becomes 1 if al=bl
                alEQbl:    
                cmp edi, l2-1; we go through s2
                je innerLoopDone
                inc edi
                jmp innerLoop ;repeat innerLoop

        innerLoopDone: ;we return to outerLoop
            mov dh, 0; another ok, to see if we can add al in d
            cmp dl, dh
            jne addTod
                mov edi, [c];c is index for d
                mov [d+edi], al
                add byte [c], 1;increase c
            addTod:
            inc esi; the enxt character in s1 will be verified
            jmp outerLoop ;restart loop
        done:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
