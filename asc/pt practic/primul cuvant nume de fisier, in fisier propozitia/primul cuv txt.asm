bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fclose, fread, fprintf, scanf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fprintf msvcrt.dll
import fread msvcrt.dll
import scanf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    file_name db "input.txt", 0
    access_mode1 db "r", 0
    file_desc1 dd -1
    access_mode2 db "w", 0
    file_desc2 dd -1
    we_read_chr dd 0
    first dd 0
    len equ 100
    wrd resb 20
    sentence resb 100
    buffer resb len

; our code starts here
segment code use32 class=code
    start:
        ;se da un fisier cu propozitii. creati cate fisiere trebuie cu primul cuvant ca titlu si propozitia respectiva in el
        push dword access_mode1
        push dword file_name
        call [fopen]
        add esp, 8
        
        cmp eax, 0
        je fin
        
        mov [file_desc1], eax
        
        read_file:
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
            mov edi, 0
            create_files:
                mov al, [buffer+esi]
                cmp al, ' '
                je first_word_found
                back:
                cmp al, '.'
                je print_sentence
                mov [wrd+edi], al
                mov [sentence+edi], al
                inc esi
                inc edi
                cmp esi, [we_read_chr]
                je cont
                jne create_files 
                first_word_found:
                    cmp dword [first], 0
                    jne back
                    mov dword [first], 1
                    mov al, ' '
                    mov [sentence+edi], al
                    mov al, '.'
                    mov [wrd+edi], al
                    mov al, 't'
                    mov [wrd+edi+1], al
                    mov al, 'x'
                    mov [wrd+edi+2], al
                    mov al, 't'
                    mov [wrd+edi+3], al
                    inc edi
                    
                    pushad
                    push dword access_mode2
                    push dword wrd
                    call [fopen]
                    add esp, 8
                    
                    cmp eax, 0
                    je fin
                    
                    mov [file_desc2], eax
                    popad
                    inc esi
                    jmp create_files
                    
               print_sentence:
                    mov al, '.'
                    mov [sentence+edi], al
                    
                    pushad
                    push dword sentence
                    push dword [file_desc2]
                    call [fprintf]
                    add esp, 8
                    
                    push dword [file_desc2]
                    call [fclose]
                    add esp, 4
                    popad
                    
                    mov edi, 0
                    clear_wrd:
                        mov byte [wrd+edi], 0
                        inc edi
                        cmp byte [wrd+edi], 0
                        jne clear_wrd
                    
                    mov edi, 0
                    clear_sentence:
                        mov byte [sentence+edi], 0
                        inc edi
                        cmp byte [sentence+edi], 0
                        jne clear_sentence
                        
                    mov edi, 0
                    inc esi
                    mov dword [first], 0
                    cmp esi, [we_read_chr]
                    jne create_files
                    
                    
                    

        cont:
            jmp read_file
            
        cleanup:
            push dword [file_desc1]
            call [fclose]
            add esp, 4
        fin:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
