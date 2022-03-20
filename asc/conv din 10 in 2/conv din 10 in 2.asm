bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dd 365288
    nmb resb 32
    dformat db "%d", 0
    ccx dd 0
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ebx, [a]
        mov byte [ccx], 32
        mov ecx, 32
        mov edi, 0
        all_bits:
            mov ecx, [ccx]
            rol ebx, 1
            jc store_bit
            cont:
                jnc store_no_bit
                cont2:
                    dec ecx
                    mov dword [ccx], ecx
                    jnz all_bits
                    jz fin
        store_bit:
            mov al, 1
            mov [nmb+edi], al
            inc edi
            jmp cont
        store_no_bit:
            mov al, 0
            mov [nmb+edi], al
            inc edi
            jmp cont2
        fin:
            mov esi, 0
            mov ecx, 32
            mov byte [ccx], 32
            printing:
                mov ecx, [ccx]
                mov eax, 0
                mov al, [nmb+esi]
                inc esi
                push eax
                push dword dformat
                call [printf]
                add esp, 4*2
                sub dword [ccx], 1
                mov ecx, [ccx]
                jnz printing
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
