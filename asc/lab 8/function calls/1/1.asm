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
    result dd 0
    dformat db "%d", 0
    a dw 0
    b dw 0
    message_a db "a=", 0
    message_b db "b=", 0

; our code starts here
segment code use32 class=code
    start:
        ;Read two numbers a and b (in base 10) from the keyboard and calculate their product. This value will be stored in a variable called "result" (defined in the data segment).
        push dword message_a
        call [printf]
        add esp, 4
        
        push dword a
        push dword dformat
        call [scanf]
        add esp, 4*2
        
        push dword message_b
        call [printf]
        add esp, 4
        
        push dword b
        push dword dformat
        call [scanf]
        add esp, 4*2
        
        mov eax, 0
        mov ebx, 0
        mov ax, [a]
        mov bx, [b]
        mul ebx
        mov [result], eax
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
