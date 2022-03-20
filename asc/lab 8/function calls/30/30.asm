bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, scanf, printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    nmb dd 0
    min dd 999999999
    dformat db "%d", 0
    message_min db "The minimum is %d", 0

; our code starts here
segment code use32 class=code
    start:
        ;Read numbers (in base 10) in a loop until the digit '0' is read from the keyboard. Determine and display the smallest number from those that have been read.
        the_loop:
            push dword nmb
            push dword dformat
            call [scanf]
            add esp, 8
            
            cmp dword [nmb], 0
            jz fin
            
            mov eax, [min]
            cmp dword [nmb], eax
            jge the_loop
            mov eax, [nmb]
            mov [min], eax
            jmp the_loop
            
        fin:
            push dword [min]
            push dword message_min
            call [printf]
            add esp, 8
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
