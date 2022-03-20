bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fclose, fread, printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import fopen msvcrt.dll
import printf msvcrt.dll
import fclose msvcrt.dll
import fread msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    we_read_chr dd 0
    max dd 0
    chr dd 0
    index dd 0
    file_descriptor dd -1
    access_mode db "r", 0
    file_name db "file.txt", 0
    len equ 100
    buffer resb len
    frq1 resb 15
    frq2 resb 7
    frq3 resb 6
    frq4 resb 4
    message_frq db "The special character with the highest frequency is %c and it appears %d times"

; our code starts here
segment code use32 class=code
    start:
        ;A text file is given. Read the content of the file, determine the special character with the highest frequency and display the character along with its frequency on the screen. The name of text file is defined in the data segment.
        push dword access_mode
        push dword file_name
        call [fopen]
        add esp, 8
        
        cmp eax, 0
        je fin
        
        mov [file_descriptor], eax
        
        read_file:
            push dword [file_descriptor]
            push dword len
            push dword 1
            push dword buffer
            call [fread]
            add esp, 16
            
            cmp eax, 0
            je cleanup
            
            mov [we_read_chr], eax
            mov esi, 0
            
            frq_spcchr:
                mov al, [buffer+esi]
                cmp al, '!'
                jb not_found
                cmp al, '/'
                ja cont_search
                sub al, 21h
                mov byte [index], al
                mov edi, [index]
                add byte [frq1+edi], 1
                inc esi
                cmp esi, dword [we_read_chr]
                jne frq_spcchr
                je cont
                cont_search:
                    cmp al, ':'
                    jb not_found
                    cmp al, '@'
                    ja cont_search2
                    sub al, 3ah
                    mov byte [index], al
                    mov edi, [index]
                    add byte [frq2+edi], 1
                    inc esi
                    cmp esi, dword [we_read_chr]
                    jne frq_spcchr
                    je cont
                    cont_search2:
                        cmp al, '['
                        jb not_found
                        cmp al, '`'
                        ja cont_search3
                        sub al, 5bh
                        mov byte [index], al
                        mov edi, [index]
                        add byte [frq3+edi], 1
                        inc esi
                        cmp esi, dword [we_read_chr]
                        jne frq_spcchr
                        je cont
                        cont_search3:
                            cmp al, '{'
                            jb not_found
                            cmp al, '~'
                            ja not_found
                            sub al, 7bh
                            mov byte [index], al
                            mov edi, [index]
                            add byte [frq4+edi], 1
                            inc esi
                            cmp esi, dword [we_read_chr]
                            jne frq_spcchr
                            je cont
                not_found:
                    inc esi
                    cmp esi, dword [we_read_chr]
                    jne frq_spcchr
                    
            cont:
                jmp read_file
            
            cleanup:
                push dword file_descriptor
                call [fclose]
                add esp, 4
        
        fin:
            mov esi, 0
            find_max1:
                mov al, [frq1+esi]
                mov ebx, [max]
                cmp al, bl
                jle cont2
                mov bl, al
                mov dword [max], ebx
                mov dword [chr], esi
                add dword [chr], 21h
                cont2:
                    inc esi
                    cmp esi, 15
                    jne find_max1
                    
            mov esi, 0
            find_max2:
                mov al, [frq2+esi]
                mov ebx, [max]
                cmp al, bl
                jle cont3
                mov bl, al
                mov dword [max], ebx
                mov dword [chr], esi
                add dword [chr], 3ah
                cont3:
                    inc esi
                    cmp esi, 7
                    jne find_max2
                    
            mov esi, 0
            find_max3:
                mov al, [frq3+esi]
                mov ebx, [max]
                cmp al, bl
                jle cont4
                mov bl, al
                mov dword [max], ebx
                mov dword [chr], esi
                add dword [chr], 5bh
                cont4:
                    inc esi
                    cmp esi, 6
                    jne find_max3
                    
            mov esi, 0
            find_max4:
                mov al, [frq4+esi]
                mov ebx, [max]
                cmp al, bl
                jle cont5
                mov bl, al
                mov dword [max], ebx
                mov dword [chr], esi
                add dword [chr], 7bh
                cont5:
                    inc esi
                    cmp esi, 4
                    jne find_max4
                    
            push dword [max]
            push dword [chr]
            push dword message_frq
            call [printf]
            add esp, 12
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
