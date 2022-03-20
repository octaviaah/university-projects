bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, scanf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dd 0
    b dd 0
    message_a db "a=", 0
    message_b db "b=", 0
    message_sum db "sum=%x", 0
    message_diff db "difference=%x", 0
    xformat db "%x", 0
    diff dd 0
    newline db 13, 10
    
; our code starts here
segment code use32 class=code
    start:
        ;Read two doublewords a and b in base 16 from the keyboard. Display the sum of the low parts of the two numbers and the difference between the high parts of the two numbers in base 16 Example:
        ;a = 00101A35h
        ;b = 00023219h
        ;sum = 4C4Eh
        ;difference = Eh
        
        push dword message_a
        call [printf]
        add esp, 4
        
        push dword a
        push dword xformat
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
        xor edx, edx
        
        mov ax, word [a]
        mov bx, word [b]
        mov cx, word [b+2]
        mov dx, word [a+2]
        
        add ax, bx
        sub dx, cx
        mov word [diff], dx
        
        push eax
        push dword message_sum
        call [printf]
        add esp, 8
        
        push newline
        call [printf]
        add esp, 4
        
        push dword [diff]
        push dword message_diff
        call [printf]
        add esp, 8
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
