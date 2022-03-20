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
    file_name db "14.txt", 0
    text db "68BABABABBABUU KSLDJS 25466ghkjlkjhkghjd JLKSJ226+++++", 0
    file_descriptor dd -1
    access_mode db "w", 0
    

; our code starts here
segment code use32 class=code
    start:
        ;A file name and a text (defined in the data segment) are given. The text contains lowercase letters, uppercase letters, digits and special characters. Transform all the uppercase letters from the given text in lowercase. Create a file with the given name and write the generated text to file.
        
        push dword access_mode
        push dword file_name
        call [fopen]
        add esp, 8
        
        cmp eax, 0
        je fin
        
        mov [file_descriptor], eax
        
        mov esi, 0
        mov edi, 0
        find_upr:
            mov al, [text+esi]
            cmp al, 'A'
            jb not_found
            cmp al, 'Z'
            ja not_found
            add al, 20h
            mov [text+edi], al
            inc esi
            inc edi
            cmp byte [text+esi], 0
            je print_text
            jne find_upr
            not_found:
                inc esi
                inc edi
                cmp byte [text+esi], 0
                jne find_upr
                
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
