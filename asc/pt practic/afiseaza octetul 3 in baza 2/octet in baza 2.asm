bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    sir dd 12345678h,1234abcdh,0FF00FE33h
    len equ $-sir
    ccx dd 0
    nmb resb 16
    index dd 0
    dformat db "%d", 0
    space db ' ', 0

; our code starts here
segment code use32 class=code
    start:
        ;Se da un sir de dublucuvinte. Se cere formarea si afisarea unui sir de biti cu urmatoarele reguli:
        ;Se ia cel mai semnificativ octet din cel mai putin semnificativ cuvant, iar daca este strict negativ se pune in sir.
        ;Exemplu: sir dd 12345678h,1234abcdh,FF00FE33h.
        ;Pe ecan se afiseaza: 1010 1011 1111 1110 (numerele gasite fiind AB,FE
        mov esi, 1
        read_string:
            xor eax, eax
            mov al, [sir+esi]
            mov ebx, eax
            
            mov byte [ccx], 8
            mov ecx, 8
            mov edi, 0
            all_bits:
                mov ecx, [ccx]
                rol bl, 1
                jc store_bit
                cont:
                    jnc store_no_bit
                    cont2:
                        dec ecx
                        mov dword [ccx], ecx
                        jnz all_bits
                        jz print_bin
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
        print_bin:
            mov al, [nmb+0]
            add esi, 4
            cmp al, 1
            jne read_string
            
            mov [index], esi
            mov esi, 0
            mov ecx, 8
            mov byte [ccx], 8
            printing:
                mov ecx, [ccx]
                mov eax, 0
                mov al, [nmb+esi]
                inc esi
                
                push eax
                push dword dformat
                call [printf]
                add esp, 4*2
                
                cmp esi, 4
                je add_space
                cmp esi, 8
                je add_space
                
                sub dword [ccx], 1
                mov ecx, [ccx]
                jnz printing
                jz cont3
                
                add_space:
                    push dword space
                    call [printf]
                    add esp, 4
                    
                    cmp esi, 8
                    jne printing
            
            cont3:
            mov esi, [index]
            cmp esi, len
            jl read_string
            
        fin:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
