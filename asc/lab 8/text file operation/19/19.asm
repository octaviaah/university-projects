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
    file_name db "magma.txt", 0
    file_descriptor dd -1
    access_mode db "w", 0
    sum dd 0
    text db "mama are 100 mere. tata are 22 mere. in total ei au 122 mere.", 0
    dformat db "%d", 0
    

; our code starts here
segment code use32 class=code
    start:
        ;A file name and a text (which can contain any type of character) are given in data segment. Calculate the sum of digits in the text. Create a file with the given name and write the result to file.
        push dword access_mode
        push dword file_name
        call [fopen]
        add esp, 8
        
        cmp eax, 0
        je fin
        
        mov [file_descriptor], eax
        mov esi, 0
        
        read_text:
            xor eax, eax
            mov al, [text+esi]
            cmp al, '0'
            jb not_found
            cmp al, '9'
            ja not_found
            sub al, 30h
            add [sum], eax
            inc esi
            cmp byte [text+esi], 0
            je write_file
            jne read_text
            not_found:
                inc esi
                cmp byte [text+esi], 0
                jne read_text
            
        write_file:
            push dword [sum]
            push dword dformat
            push dword [file_descriptor]
            call [fprintf]
            add esp, 12
                
        cleanup:
            push dword [file_descriptor]
            call [fclose]
            add esp, 4
        
        fin:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
