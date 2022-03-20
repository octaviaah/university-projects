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
    a dd 0
    b dd 0
    message_a db "a=", 0
    message_b db "b=", 0
    dformat db "%d", 0
    xformat db "%x", 0
    no_1 dd 0
; our code starts here
segment code use32 class=code
    start:
        ;Read a decimal number and a hexadecimal number from the keyboard. Display the number of 1's of the sum of the two numbers in decimal format. ;Example:
        ;a = 32 = 0010 0000b
        ;b = 1Ah = 0001 1010b
        ;32 + 1Ah = 0011 1010b
        ;The value printed on the screen will be 4
        
        push dword message_a
        call [printf]
        add esp, 4
        
        push dword a
        push dword dformat
        call [scanf]
        add esp, 8
        
        push dword message_b
        call [printf]
        add esp, 4
        
        push dword b
        push dword xformat
        call [scanf]
        add esp, 8
        
        xor eax, eax
        mov eax, [a]
        add eax, [b]
        
        mov ecx, 32
        find_bits:
            rol eax, 1
            jc add_1
            cont:
                dec ecx
                jnz find_bits
                
        push dword [no_1]
        push dword dformat
        call [printf]
        add esp, 4*2
        jmp fin
        
        add_1:
            add dword [no_1], 1
            jmp cont
            
        fin:   
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
