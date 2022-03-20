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
    a resw 2
    m resw 2
    n resw 2
    message_a db "a=", 0
    message_m db "m=", 0
    message_n db "n=", 0
    dformat db "%d", 0
    message_fin db "le new numbah iz: %x", 0

; our code starts here
segment code use32 class=code
    start:
        ;Read three numbers a, m and n (a: word, 0 <= m, n <= 15, m > n) from the keyboard. Isolate the bits m-n of a and display the integer represented by those bits in base 16
        push dword  message_a
        call [printf]
        add esp, 4
        
        push dword a
        push dword dformat
        call [scanf]
        add esp, 8
        
        push dword  message_m
        call [printf]
        add esp, 4
        
        push dword m
        push dword dformat
        call [scanf]
        add esp, 8
        
        push dword  message_n
        call [printf]
        add esp, 4
        
        push dword n
        push dword dformat
        call [scanf]
        add esp, 8
        
        xor eax, eax
        mov ax, 0
        mov ecx, 0
        
        the_loop:
            cmp ecx, dword [n]
            jl cont
            cmp ecx, dword [m]
            jg cont
            or ax, 1
            rol ax, 1
            cont:
                inc ecx
                cmp ecx, 16
                jnz the_loop
        mov cl, byte [m]
        sub cl, byte [n]
        add cl, 1
        rol ax, cl
        
        xor ebx, ebx
        mov bx, ax
        xor eax, eax
        mov eax, [a]
        
        and eax, ebx
        push eax
        push message_fin
        call [printf]
        add esp, 8
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
