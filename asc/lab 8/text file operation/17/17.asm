bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fclose, fprintf, scanf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import scanf msvcrt.dll
import fprintf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    file_name db "17.txt", 0
    access_mode db "w", 0
    nmb resb 8
    file_desciptor dd -1
    dformat db "%d", 0
    newline db 13

; our code starts here
segment code use32 class=code
    start:
        ;A file name is given (defined in the data segment). Create a file with the given name, then read numbers from the keyboard and write only the numbers divisible by 7 to file, until the value '0' is read from the keyboard.
        push dword access_mode
        push dword file_name
        call [fopen]
        add esp, 8
        
        cmp eax, 0
        je fin
        
        mov [file_desciptor], eax
        
        read_nmb:
            push dword nmb
            push dword dformat
            call [scanf]
            add esp, 8
            
            mov eax, dword [nmb]
            mov edx, dword [nmb+4]
            cmp eax, 0
            je cont_ver
            
            mov ebx, 7
            idiv ebx
            cmp edx, 0
            je write_to_file
            
            mov dword [nmb], 0
            mov dword [nmb+4], 0
            jmp read_nmb
            
            cont_ver:
                cmp edx, 0
                je cleanup
                
                mov ebx, 7
                idiv ebx
                cmp edx, 0
                je write_to_file
                
                mov dword [nmb], 0
                mov dword [nmb+4], 0
                jmp read_nmb
            
            write_to_file:
                push dword [nmb]
                push dword dformat
                push dword [file_desciptor]
                call [fprintf]
                add esp, 12
                
                push dword newline
                push dword [file_desciptor]
                call [fprintf]
                add esp, 8
                
                mov dword [nmb], 0
                mov dword [nmb+4], 0
                jmp read_nmb
                
        cleanup:
            push dword [file_desciptor]
            call [fclose]
            add esp, 4
        
        fin:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
