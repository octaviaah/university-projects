bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fclose, fprintf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fprintf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    file_name db "mama.txt", 0
    access_mode db "w", 0
    file_descriptor dd -1
    text db "a3652um 3st3 se!ra. si 212155 558 va j8ca B8RNL3Y!!!", 0

; our code starts here
segment code use32 class=code
    start:
        ;A file name and a text (defined in data segment) are given. The text contains lowercase letters, uppercase letters, digits and special characters. Replace all digits from the text with character 'C'. Create a file with the given name and write the generated text to file.
        push dword access_mode
        push dword file_name
        call [fopen]
        add esp, 8
        
        cmp eax, 0
        je fin
        
        mov [file_descriptor], eax
        mov esi, 0
        mov edi, 0
        
        read_text:
            mov al, [text+esi]
            cmp al, '0'
            jb not_found
            cmp al, '9'
            ja not_found
            mov al, 'C'
            mov [text+edi], al
            inc esi
            inc edi
            cmp byte [text+esi], 0
            je write_text
            jne read_text
            not_found:
                mov [text+edi], al
                inc esi
                inc edi
                cmp byte [text+esi], 0
                jne read_text
        
        write_text:
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
