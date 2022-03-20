bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fclose, fprintf, printf, gets                ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import fopen msvcrt.dll
import fclose msvcrt.dll
import fprintf msvcrt.dll
import printf msvcrt.dll
import gets msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    text db "Almost before we knew it, we had left the gr0und", 0
    len equ $-text
    file_name db "hello.txt", 0
    file_descriptor dd -1
    access_mode db "a", 0
    new_text times len db 0

; our code starts here
segment code use32 class=code
    start:
    ;A file name and a text (defined in data segment) are given. The text contains lowercase letters, uppercase letters, digits and special characters. Replace all spaces from the text with character 'S'. Create a file with the given name and write the generated text to file.
        mov bl, ' '
        mov ecx, len
        mov esi, text
        mov edi, new_text
        cld
        change_to_S: ;changes spaces to 'S'
            lodsb
            cmp al, bl
            jne got_space
                mov al, 'S'
            got_space:
            stosb
        loop change_to_S
        
        push dword access_mode ;create file
        push dword file_name
        call [fopen]
        add esp, 4*2
        
        mov [file_descriptor], eax ;move the descriptor of the created file
        
        cmp eax, 0 ;verify if the file was creted
        je final
        
        push dword new_text ;write new text to file
        push dword [file_descriptor]
        call [fprintf]
        add esp, 4*2
        
        push dword [file_descriptor] ;close the file
        call [fclose]
        add esp, 4
        
        final:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
