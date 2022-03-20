bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fclose, fprintf, fread               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import fopen msvcrt.dll
import fprintf msvcrt.dll
import fclose msvcrt.dll
import fread msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    access_mode1 db "r", 0
    access_mode2 db "w", 0
    fd1 dd -1
    fd2 dd -1
    file_name1 db "fisier1.txt", 0
    file_name2 db "fisier2.txt", 0
    index dd 0
    we_read_chr dd 0
    wrd dd 0
    lwrd dd 0
    chr dd 0
    index2 dd 0
    cformat db "%c", 0
    dformat db "%d", 0
    save_sentence resb 100
    len equ 1000
    buffer resb len
    newline db 13

; our code starts here
segment code use32 class=code
    start:
        ; ...
        push dword access_mode1
        push dword file_name1
        call [fopen]
        add esp, 8
        
        cmp eax, 0
        je fin
        
        mov [fd1], eax
        
        push dword access_mode2
        push dword file_name2
        call [fopen]
        add esp, 8
        
        cmp eax, 0
        je fin
        
        mov [fd2], eax
        
        read_full_file:
            push dword [fd1]
            push dword len
            push dword 1
            push dword buffer
            call [fread]
            add esp, 16
            
            cmp eax, 0
            je cleanup
            
            mov [we_read_chr], eax
            mov esi, 0
            mov edi, 0
            
            second_to_last_search:
                xor eax, eax
                mov al, [buffer+esi]
                mov [save_sentence+edi], al
                cmp al, ' '
                je add_word
                cmp al, '-'
                je get_alm_last
                inc esi
                inc edi
                cmp esi, [we_read_chr]
                je cont
                jne second_to_last_search
                add_word:
                    add dword [wrd], 1
                    mov [save_sentence+esi], al
                    inc edi
                    inc esi
                    cmp esi, [we_read_chr]
                    je cont
                    jne second_to_last_search
                get_alm_last:
                    sub dword [wrd],1
                    mov [index], esi
                    add dword [index], 1
                    mov esi, 0
                    find:
                        xor eax, eax
                        mov al, [save_sentence+esi]
                        inc esi
                        cmp al, ' '
                        je see_if_found
                        cmp byte [save_sentence+esi], 0
                        je second_to_last_search
                        jne find                            
                         see_if_found:
                            add dword [lwrd], 1
                            mov ebx, dword [wrd]
                            cmp ebx, dword [lwrd]
                            jne find
                            je found
                            found:
                                mov al, [save_sentence+esi]
                                inc esi
                                mov [index2], esi
                                mov [chr], al
                                push dword [chr]
                                push dword cformat
                                push dword [fd2]
                                call [fprintf]
                                add esp, 12
                                
                                xor eax, eax
                                mov esi, [index2]
                                mov al, [save_sentence+esi]
                                cmp al, ' '
                                jne found
                                       
                         mov dword [chr], ' '
                         push dword [chr]
                         push dword cformat
                         push dword [fd2]
                         call [fprintf]
                         add esp, 12
                                
                         add dword [wrd], 2
                         push dword [wrd]
                         push dword dformat
                         push dword [fd2]
                         call [fprintf]
                         add esp, 12
                                
                         push dword newline
                         push dword [fd2]
                         call [fprintf]
                         add esp, 8
                         
                         mov dword [wrd], 0
                         mov dword [lwrd], 0
                         mov edi, 0
                         delete_sentence:
                            mov byte [save_sentence+edi], 0
                            inc edi
                            cmp byte [save_sentence+edi], 0
                            jne delete_sentence
                         mov edi, 0
                         mov esi, [index]  
                         jmp second_to_last_search
                         
                
                
            cont:
                jmp read_full_file

       cleanup:
            push dword [fd1]
            call [fclose]
            add esp, 4
            
            push dword [fd2]
            call [fclose]
            add esp, 4
        
        fin:
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
