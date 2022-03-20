bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, scanf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import scanf msvcrt.dll                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    dformat db "%i", 0
    string times 20 dd 0
    entr dd 0
; our code starts here
segment code use32 class=code
    start:
        ;Read from the keyboard a string of numbers, given in the base 10 as signed numbers (a string of characters is read from the keyboard and a string of numbers must be stored in the memory).
        mov ecx, 20
        the_loop:
            push dword string
            push dword dformat
            call [scanf]
            add esp, 4*2
            mov eax, [entr]
            cmp dword [string], eax
            jz fin
            jmp the_loop
        fin:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
