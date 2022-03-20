bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fclose, fopen, fprintf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import fclose msvcrt.dll
import fopen msvcrt.dll
import fprintf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    file_name db "15.txt", 0
    text db "audhka535:?Ajda::/fjsijdlsdsdj^%%^*hh&656", 0
    file_descriptor dd -1
    access_mode db "w", 0

; our code starts here
segment code use32 class=code
    start:
        ;A file name and a text (defined in the data segment) are given. The text contains lowercase letters, uppercase letters, digits and special characters. Replace all the special characters from the given text with the character 'X'. Create a file with the given name and write the generated text to file.
        push dword access_mode
        push dword file_name
        call [fopen]
        add esp, 8
        
        cmp eax, 0
        je fin
        
        mov [file_descriptor], eax
        
        mov esi, 0
        mov edi, 0
        find_spec:
            mov al, [text+esi]
            cmp al, '!'
            jb not_found
            cmp al, '/'
            ja cont
            mov al, 'X'
            mov [text+edi], al
            inc esi
            inc edi
            cmp byte [text+esi], 0
            je print_text
            jne find_spec
            cont:
                cmp al, ':'
                jb not_found
                cmp al, '@'
                ja cont2
                mov al, 'X'
                mov [text+edi], al
                inc esi
                inc edi
                cmp byte [text+esi], 0
                je print_text
                jne find_spec
                cont2:
                    cmp al, '['
                    jb not_found
                    cmp al, '`'
                    ja cont3
                    mov al, 'X'
                    mov [text+edi], al
                    inc esi
                    inc edi
                    cmp byte [text+esi], 0
                    je print_text
                    jne find_spec
                    cont3:
                        cmp al, '{'
                        jb not_found
                        cmp al, '~'
                        ja not_found
                        mov al, 'X'
                        mov [text+edi], al
                        inc esi
                        inc edi
                        cmp byte [text+esi], 0
                        je print_text
                        jne find_spec
                        not_found:
                            inc esi
                            inc edi
                            cmp byte [text+esi], 0
                            jne find_spec
                
        print_text:
            push dword text
            push dword [file_descriptor]
            call [fprintf]
            add esp, 8
            
            push dword [file_descriptor]
            call [fclose]
            add esp, 4
            
        
        fin:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
