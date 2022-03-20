bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fread, printf, fclose               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import fopen msvcrt.dll
import fread msvcrt.dll
import printf msvcrt.dll
import fclose msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    nmb_vowels dd 0
    we_read_chr dd 0
    access_mode db "r", 0
    file_descriptor dd -1
    message_vowel db "no of vowels: %d", 0
    len equ 100
    file_name db "textfile.txt", 0
    buffer resb len

; our code starts here
segment code use32 class=code
    start:
        ;A text file is given. Read the content of the file, count the number of vowels and display the result on the screen. The name of text file is defined in the data segment.
        push dword access_mode
        push dword file_name
        call [fopen]
        add esp, 8
        
        cmp eax, 0
        jz fin
        
        mov [file_descriptor], eax
        
        read_whole_file:
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
            find_vowels:
                mov al, [buffer+esi]
                cmp al, 'A'
                je add_vowel
                cmp al, 'E'
                je add_vowel
                cmp al, 'I'
                je add_vowel
                cmp al, 'O'
                je add_vowel
                cmp al, 'U'
                je add_vowel
                cmp al, 'a'
                je add_vowel
                cmp al, 'i'
                je add_vowel
                cmp al, 'e'
                je add_vowel
                cmp al, 'o'
                je add_vowel
                cmp al, 'u'
                je add_vowel
                inc esi
                cmp esi, dword[we_read_chr]
                jne find_vowels
                je cont
                add_vowel:
                    add dword [nmb_vowels], 1
                    inc esi
                    cmp esi, dword[we_read_chr]
                    jne find_vowels
            
            cont:
            jmp read_whole_file
        
        cleanup:
            push dword [file_descriptor]
            call [fclose]
            add esp, 4
            
        
        fin:
            push dword [nmb_vowels]
            push dword message_vowel
            call [printf]
            add esp, 8
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
