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
    digit resb 1
    cformat db "%c", 0
    frq resb 10
    dformat db "%d", 0
    index dd 0
    no dd 0

; our code starts here
segment code use32 class=code
    start:
        ;Se citesc cifre de la tastatura pana la introducerea lui !
        ;(atentie sa se citeasca cu %c!!)
        ;sa se formeze cel mai mic numar din cifrele impare citite
        read_digits:
            push dword digit
            push dword cformat
            call [scanf]
            add esp, 8
            
            xor eax, eax
            mov al, [digit]
            cmp al, '!'
            je fin
            
            sub al, 30h
            mov edi, eax
            add byte [frq+edi], 1
            
            jmp read_digits
            
        fin:
            mov esi, 1
            print_nmb:
                mov [index], esi
                xor eax, eax
                mov al, [frq+esi]
                cmp al, 0
                jne printing
                je cont
                printing:
                    mov [no], eax
                    push dword [index]
                    push dword dformat
                    call [printf]
                    add esp, 8
                    
                    mov eax, [no]
                    sub al, 1
                    cmp al, 0
                    jne printing
                cont:
                    mov esi, [index]
                    add esi, 2
                    cmp esi, 11
                    jne print_nmb
                    
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
