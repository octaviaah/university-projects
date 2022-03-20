bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fclose, fread, printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import fread msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import printf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    file_name db "le_file20.txt", 0
    access_mode db "r", 0
    file_descriptor dd -1
    nmb_wrds dd 0
    we_read_chr dd 0
    len equ 100
    buffer resb len
    message_words db "no of words: %d", 0

; our code starts here
segment code use32 class=code
    start:
        ;A text file is given. The text contains letters, spaces and points. Read the content of the file, determine the number of words and display the result on the screen. (A word is a sequence of characters separated by space or point)
        push dword access_mode
        push dword file_name
        call [fopen]
        add esp, 8
        
        cmp eax, 0
        je fin 
        
        mov [file_descriptor], eax
        
        read_full_file:
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
            find_words:
                mov al, [buffer+esi]
                cmp al, ' '
                je add_word
                cmp al, '.'
                je add_word
                inc esi
                cmp esi, [we_read_chr]
                je cleanup
                jne find_words
                add_word:
                    add dword [nmb_wrds], 1
                    inc esi
                    cmp esi, [we_read_chr]
                    jne find_words
                    
            jmp read_full_file
            
        cleanup:
            push dword [file_descriptor]
            call [fclose]
            add esp, 4
        
        fin:
            push dword [nmb_wrds]
            push dword message_words
            call [printf]
            add esp, 8
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
