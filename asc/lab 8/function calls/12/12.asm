bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dd -98524
    message db "a = %d (base 10), a = %x (base 16)"

; our code starts here
segment code use32 class=code
    start:
        ;A negative number a (a: dword) is given. Display the value of that number in base 10 and in the base 16 in the following format: "a = <base_10> (base 10), a = <base_16> (base 16)"
        push dword [a]
        push dword [a]
        push dword message
        call [printf]
        add esp, 4*3
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
