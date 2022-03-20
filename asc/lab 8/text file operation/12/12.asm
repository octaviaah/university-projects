bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, scanf, fprintf,  fopen, fclose              ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import fprintf msvcrt.dll
import scanf msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    file_name db "lefile.txt", 0
    access_mode db "w", 0
    nmb resb 8
    dformat db "%d", 0
    file_descriptor dd -1
    newline db 13

; our code starts here
segment code use32 class=code
    start:
        ;A file name is given (defined in the data segment). Create a file with the given name, then read numbers from the keyboard and write those numbers in the file, until the value '0' is read from the keyboard.
        push dword access_mode
        push dword file_name
        call [fopen]
        add esp, 8
        
        cmp eax, 0
        je fin
        
        mov [file_descriptor], eax
        
        the_loop:
            push dword nmb
            push dword dformat
            call [scanf]
            add esp, 8
            
            mov eax, dword [nmb]
            mov edx, dword [nmb+4]
            cmp eax, 0
            je cont_verifying
            
            push dword [nmb]
            push dword dformat
            push dword [file_descriptor]
            call [fprintf]
            add esp, 16
            
            push dword newline
            push dword [file_descriptor]
            call [fprintf]
            add esp, 8
            
            mov dword [nmb], 0
            mov dword [nmb+4], 0
            
            cont_verifying:
                cmp edx, 0
                je cleanup
                
                push dword [nmb]
                push dword [nmb+4]
                push dword [file_descriptor]
                call [fprintf]
                add esp, 12
            
                mov dword [nmb], 0
                mov dword [nmb+4], 0
           jmp the_loop

           cleanup:
              push dword [file_descriptor]
              call [fclose]
              add esp, 4
        
        fin:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
