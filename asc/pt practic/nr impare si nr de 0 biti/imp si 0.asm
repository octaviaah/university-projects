bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fclose, fread, printf              ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fread msvcrt.dll
import printf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    access_mode db "r", 0
    file_name db "fisier.txt", 0
    file_desc dd -1
    bin_string resb 8
    no_0 dd 0
    nmb dd 0
    dformat db "%x %d", 0
    we_read_chr dd 0
    ccx dd 0
    len equ 100
    buffer resb len
    newline db 13, 10

; our code starts here
segment code use32 class=code
    start:
        ;se da in segment numele unui fisier. acesta contine cifre separate prin spatiu(cifre baza 16). sa se afiseze fiecare cifra impara citita din fisier si numarul de biti 0 din reprezentarea binara a acesteia
        push dword access_mode
        push dword file_name
        call [fopen]
        add esp, 8
        
        cmp eax, 0
        je fin
        
        mov [file_desc], eax
        
        read_file:
            push dword [file_desc]
            push dword len
            push dword 1
            push dword buffer
            call [fread]
            add esp, 16
            
            cmp eax, 0
            je cleanup
            
            mov [we_read_chr], eax
            mov esi, 0
            
            get_nmbs:
                xor eax, eax
                mov al, [buffer+esi]
                cmp al, '1'
                je found
                cmp al, '3'
                je found
                cmp al, '5'
                je found
                cmp al, '7'
                je found
                cmp al, '9'
                je found
                cmp al, 'b'
                je found
                cmp al, 'd'
                je found
                cmp al, 'f'
                je found
                
                inc esi
                cmp esi, [we_read_chr]
                je cont3
                jne get_nmbs
                
                found:
                cmp al, 'b'
                je dec_more
                cmp al, 'd'
                je dec_more
                cmp al, 'f'
                je dec_more
                sub al, 30h
                back:
                mov byte [nmb], al
                
                mov bl, al
                mov ecx, 8
                mov dword [ccx], 8
                mov edi, 0
                get_bin:
                    mov ecx, [ccx]
                    rol bl, 1
                    jc store_1
                    cont:
                        jnc store_0
                        cont2:
                            dec ecx
                            mov [ccx], ecx
                            jnz get_bin
                            jz print_nmb
                 
                store_1:
                    mov al, 1
                    mov [bin_string+edi], al
                    inc edi
                    jmp cont
                    
                store_0:
                    mov al, 0
                    add dword [no_0], 1
                    mov [bin_string+edi], al
                    inc edi
                    jmp cont2
                    
                print_nmb:
                    pushad
                    push dword [no_0]
                    push dword [nmb]
                    push dword dformat
                    call [printf]
                    add esp, 12
                    
                    push dword newline
                    call [printf]
                    add esp, 4
                    
                    popad
                    
                    mov dword [no_0], 0
                    inc esi
                    cmp esi, [we_read_chr]
                    jne get_nmbs
                    je cont3
                    
               dec_more:
                    sub al, 57h
                    jmp back
        
        cont3:
            jmp read_file
            
        cleanup:
            push dword [file_desc]
            call [fclose]
            add esp, 4
            
        fin:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
