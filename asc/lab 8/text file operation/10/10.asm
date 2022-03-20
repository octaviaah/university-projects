bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fclose, fprintf, printf, gets       ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import fopen msvcrt.dll
import fclose msvcrt.dll
import fprintf msvcrt.dll
import printf msvcrt.dll
import gets msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    message_name db "file name=", 0
    len_file_name equ 30
    file_name times len_file_name db 0
    message_text db "text=", 0
    len_text equ 120
    text times len_text db 0
    access_mode db "a", 0
    file_descriptor dd -1

; our code starts here
segment code use32 class=code
    start:
    ;Read a file name and a text from the keyboard. Create a file with that name in the current folder and write the text that has been read to file. Observations: The file name has maximum 30 characters. The text has maximum 120 characters.
        push dword message_name ;announces that we need to read the file name
        call [printf]
        add esp, 4*1
        
        push dword file_name ;read file name(allows spaces)
        call [gets]
        add esp, 4*1
        
        push dword message_text ;announces that we need to read the text
        call [printf]
        add esp, 4*1
        
        push dword text ;read text with spaces
        call [gets]
        add esp, 4*1
        
        push dword access_mode ;create file
        push dword file_name
        call [fopen]
        add esp, 4*2
        
        mov [file_descriptor], eax ;move the descriptor of the created file
        
        cmp eax, 0 ;verify if the file was creted
        je final
        
        push dword text ;write read text to file
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
