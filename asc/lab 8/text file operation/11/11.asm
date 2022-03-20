bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, scanf, fprintf, fopen, fclose               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import scanf msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fprintf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    access_mode db "w", 0
    file_name db "myfile.txt", 0
    wrd resb 20
    file_descriptor dd -1
    sformat db "%s", 0
    newline db 13
    

; our code starts here
segment code use32 class=code
    start:
        ;A file name is given (defined in the data segment). Create a file with the given name, then read words from the keyboard and write those words in the file, until character '$' is read from the keyboard.
        push dword access_mode
        push dword file_name
        call [fopen]
        add esp, 8
        
        cmp eax, 0
        je fin
        
        mov [file_descriptor], eax
        
        the_loop:
            push dword wrd
            push dword sformat
            call [scanf]
            add esp, 8
            
            mov esi, [wrd]
            cmp esi, '$'
            je cls
            
            push dword wrd
            push dword [file_descriptor]
            call [fprintf]
            add esp, 8
            
            push dword newline
            push dword [file_descriptor]
            call [fprintf]
            add esp, 8
            
            mov edi, 0
            cleanup:
                mov [wrd+edi], byte 0
                inc edi
                cmp edi, 20
                jne cleanup
            
            jmp the_loop
            
        
        cls:
            push dword [file_descriptor]
            call [fclose]
            add esp, 4
            
        fin:
            
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
