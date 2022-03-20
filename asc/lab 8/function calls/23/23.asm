bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, scanf, printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a resb 4
    xformat db "%x", 0
    message_a db "a=", 0
    message_uns db "unsigned=%d", 0
    message_sgn db "signed=%d", 0
    signed_nmb dd 0
    newline db 13, 10

; our code starts here
segment code use32 class=code
    start:
        ;Read a hexadecimal number with 2 digits from the keyboard. Display the number in base 10, in both interpretations: as an unsigned number and as an signed number (on 8 bits).
        push dword message_a
        call [printf]
        add esp, 4
        
        push dword a
        push dword xformat
        call [scanf]
        add esp, 8
        
        mov eax, [a]
        mov [signed_nmb], eax
        
        cmp dword [a], 127
        jle next
        
        mov ax, [a]
        mov dx, 0
        mov bx, 256
        mov cx, 0
        sub ax, bx
        sbb dx, cx
        mov word [signed_nmb], ax
        mov word [signed_nmb+2], dx
        
        next:
        
        push dword [a]
        push dword message_uns
        call [printf]
        add esp, 8
        
        push dword newline
        call [printf]
        add esp, 4
        
        push dword [signed_nmb]
        push dword message_sgn
        call [printf]
        add esp, 8
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
