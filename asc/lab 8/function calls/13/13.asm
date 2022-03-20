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
    result resd 2
    dformat db "%d", 0
    message_a db "a=", 0
    message_b db "b=", 0
    adunare dd 0
    scadere dd 0
; our code starts here
segment code use32 class=code
    start:
        ;Read two numbers a and b (base 10) from the keyboard and calculate: (a+b)*(a-b). The result of multiplication will be stored in a variable called "result" (defined in the data segment).
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
        
        xor eax, eax
        xor ebx, ebx
        xor ecx, ecx
        xor edx, edx
        
        mov ax, word [a]
        mov dx, word[a+2]
        mov bx, word[b]
        mov cx, word[b+2]
        add ax, bx
        adc dx, cx
        
        mov word[adunare], ax
        mov word[adunare+2], dx
        
        xor eax, eax
        xor ebx, ebx
        xor ecx, ecx
        xor edx, edx
        
        mov ax, word [a]
        mov dx, word[a+2]
        mov bx, word[b]
        mov cx, word[b+2]
        sub ax, bx
        sbb dx, cx
        
        mov word[scadere], ax
        mov word [scadere+2], dx
        
        xor eax, eax
        mov eax, [adunare]
        xor ebx, ebx
        mov ebx, [scadere]
        
        imul ebx
        mov dword [result], eax
        mov dword [result+4], edx
        
        push dword [result]
        push dword dformat
        call [printf]
        add esp, 4*2
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
