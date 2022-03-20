bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fclose, fprintf, fread               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fprintf msvcrt.dll
import fread msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    file_name1 db "fisier1.txt", 0
    file_name2 db "fisier2.txt", 0
    access_mode1 db "r", 0
    access_mode2 db "w", 0
    file_desc1 dd -1
    file_desc2 dd -1
    we_read_chr dd 0
    len equ 1000
    buffer resb len
    stop db 0
    index dd 2
    chr dd 0
    cformat db "%c", 0
    first dd 0
    newline db 13

; our code starts here
segment code use32 class=code
    start:
        ;Se citesc propozitii din fisier1. Sa se afisez in fisier 2 propozitiile care au indici 3k+1
        push dword access_mode1
        push dword file_name1
        call [fopen]
        add esp, 8
        
        cmp eax, 0
        je fin
        
        mov [file_desc1], eax
        
        push dword access_mode2
        push dword file_name2
        call [fopen]
        add esp, 8
        
        cmp eax, 0
        je fin
        
        mov [file_desc2], eax
        
        read_full_file:
            push dword [file_desc1]
            push dword len
            push dword 1
            push dword buffer
            call [fread]
            add esp, 16
            
            cmp eax, 0
            je cleanup
            
            mov [we_read_chr], eax
            mov esi, 0

            cmp dword [first], 0
            jne print_prop
            
            first_prop:
                mov dword [first], 1
                xor eax, eax
                mov al, [buffer+esi]
                inc esi
                cmp al, '.'
                je add_space
                jne first_add       
                cmp esi, [we_read_chr]
                je cont2
                
                first_add:
                    cmp al, 0
                    je cont2
                            
                    mov byte [chr], al
                            
                    push dword [chr]
                    push dword cformat
                    push dword [file_desc2]
                    call [fprintf]
                    add esp, 12
                jmp first_prop
            
            print_prop:
                mov al, [buffer+esi]
                cmp al, '.'
                je in_file2
                inc esi
                cmp esi, dword [we_read_chr]
                jne print_prop
                je cont2
                in_file2:
                    add dword [index], 1
                    mov eax, [index]
                    mov edx, 0
                    mov ebx, 3
                    div ebx
                    
                    cmp edx, 1
                    jne cont
                    add_to_file:
                        inc esi
                        xor eax, eax
                        mov al, [buffer+esi]
                        
                        cmp al, '.'
                        je add_space
                        jne next_comp
                        
                        cmp esi, [we_read_chr]
                        je cont2
                        
                        next_comp:
                            cmp al, 0
                            je cont2
                            
                            mov byte [chr], al
                            
                            push dword [chr]
                            push dword cformat
                            push dword [file_desc2]
                            call [fprintf]
                            add esp, 12
                            
                        jmp add_to_file
                        
                    cont:
                        inc esi
                        xor eax, eax
                        mov al, [buffer+esi]
                        
                        cmp al, '.'
                        je print_prop
                        jne cont
             
             cont2:
             jmp read_full_file
             
             add_space:
                mov byte [chr], '.'
                
                push dword [chr]
                push dword cformat
                push dword [file_desc2]
                call [fprintf]
                add esp, 12
                
                push dword newline
                push dword [file_desc2]
                call [fprintf]
                add esp, 8
                
                jmp print_prop
            
            cleanup:
                push dword [file_desc1]
                call [fclose]
                add esp, 4
                
                push dword [file_desc2]
                call [fclose]
                add esp, 4
        
        fin:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
