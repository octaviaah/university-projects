bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, printf, fclose, fread               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import fclose msvcrt.dll
import printf msvcrt.dll
import fopen msvcrt.dll
import fread msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    file_name db "thefile.txt", 0
    file_descriptor dd -1
    access_mode db "r", 0
    nmb_y dd 0
    nmb_z dd 0
    len equ 100
    buffer resb len
    message_y db "no of y: %d", 0
    message_z db "no of z: %d", 0
    we_read_chr dd 0
    newline db 13, 10
; our code starts here
segment code use32 class=code
    start:
        ;A text file is given. Read the content of the file, count the number of letters 'y' and 'z' and display the values on the screen. The file name is defined in the data segment.
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
            find_y_z:
                mov al, [buffer+esi]
                cmp al, 'y'
                je add_y
                cmp al, 'z'
                je add_z
                inc esi
                cmp esi, [we_read_chr]
                je cleanup
                jne find_y_z
                add_y:
                    add dword [nmb_y], 1
                    inc esi
                    cmp esi, [we_read_chr]
                    je cleanup
                    jne find_y_z
                add_z:
                    add dword [nmb_z], 1
                    inc esi
                    cmp esi, [we_read_chr]
                    jne find_y_z
                    
             jmp read_full_file
             
             cleanup:
                push dword [file_descriptor]
                call [fclose]
                add esp, 4
        
        fin:
            push dword [nmb_z]
            push dword message_z
            call [printf]
            add esp, 8
            
            push dword newline
            call [printf]
            add esp, 4
            
            push dword [nmb_y]
            push dword message_y
            call [printf]
            add esp, 8
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
