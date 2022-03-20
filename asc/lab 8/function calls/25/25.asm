bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, scanf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import printf msvcrt.dll
import scanf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dd 0
    b dd 0
    message_a db "a=", 0
    message_b db "b=", 0
    dformat db "%d", 0
    equal_message db "%d = %d", 0
    less_message db "%d < %d", 0
    greater_message db "%d > %d", 0

; our code starts here
segment code use32 class=code
    start:
    ;Read two numbers a and b (in base 10) from the keyboard and determine the order relation between them (either a < b, or a = b, or a > b). Display the result in the following format: "<a> < <b>, <a> = <b> or <a> > <b>".
        push dword message_a;push address of message_a on the stack
        call [printf]
        add esp, 4*1; clear the stack
        
        push dword a;push address of a on the stack
        push dword dformat
        call [scanf]
        add esp, 4*2
        
        push dword message_b
        call [printf]
        add esp, 4*1
        
        push dword b
        push dword dformat
        call [scanf]
        add esp, 4*2
        
        mov eax, [a]
        mov ebx, [b]
        cmp eax, ebx
        
        jne not_eq
            push dword eax
            push dword ebx
            push dword equal_message
            call [printf]
            add esp, 4*3 
            jmp ending
        not_eq:
            jnl not_less
                push dword ebx
                push dword eax
                push dword less_message
                call [printf]
                add esp, 4*3 
                jmp ending 
            not_less:
                push dword ebx
                push dword eax
                push dword greater_message
                call [printf]
                add esp, 4*3 
                jmp ending 
        ending:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
