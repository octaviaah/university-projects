bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fread, fclose, printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import fread msvcrt.dll
import fclose msvcrt.dll
import fopen msvcrt.dll
import printf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    nmb_cons dd 0
    we_read_chr dd 0
    message_cons db "no of cons: %d", 0
    file_name db "mytext.txt", 0
    access_mode db "r", 0
    file_descriptor dd -1
    len equ 100
    buffer resb len

; our code starts here
segment code use32 class=code
    start:
        ;A text file is given. Read the content of the file, count the number of consonants and display the result on the screen. The name of text file is defined in the data segment.
        push dword access_mode
        push dword file_name
        call [fopen]
        add esp, 8
        
        cmp eax, 0
        je fin
        
        mov [file_descriptor], eax
        
        read_in_file:
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
            
            find_cons:
                mov al, [buffer+esi]
                cmp al, 'B'
                je add_cons
                cmp al, 'C'
                je add_cons
                cmp al, 'D'
                je add_cons
                cmp al, 'F'
                je add_cons
                cmp al, 'G'
                je add_cons
                cmp al, 'H'
                je add_cons
                cmp al, 'J'
                je add_cons
                cmp al, 'K'
                je add_cons
                cmp al, 'L'
                je add_cons
                cmp al, 'M'
                je add_cons
                cmp al, 'N'
                je add_cons
                cmp al, 'P'
                je add_cons
                cmp al, 'Q'
                je add_cons
                cmp al, 'R'
                je add_cons
                cmp al, 'S'
                je add_cons
                cmp al, 'T'
                je add_cons
                cmp al, 'V'
                je add_cons
                cmp al, 'W'
                je add_cons
                cmp al, 'X'
                je add_cons
                cmp al, 'Y'
                je add_cons
                cmp al, 'Z'
                je add_cons
                cmp al, 'b'
                je add_cons
                cmp al, 'c'
                je add_cons
                cmp al, 'd'
                je add_cons
                cmp al, 'f'
                je add_cons
                cmp al, 'g'
                je add_cons
                cmp al, 'h'
                je add_cons
                cmp al, 'j'
                je add_cons
                cmp al, 'k'
                je add_cons
                cmp al, 'l'
                je add_cons
                cmp al, 'm'
                je add_cons
                cmp al, 'n'
                je add_cons
                cmp al, 'p'
                je add_cons
                cmp al, 'q'
                je add_cons
                cmp al, 'r'
                je add_cons
                cmp al, 's'
                je add_cons
                cmp al, 't'
                je add_cons
                cmp al, 'v'
                je add_cons
                cmp al, 'w'
                je add_cons
                cmp al, 'x'
                je add_cons
                cmp al, 'y'
                je add_cons
                cmp al, 'z'
                je add_cons
                inc esi
                cmp esi, dword [we_read_chr]
                jne find_cons
                je cont
                add_cons:
                    add DWORD [nmb_cons], 1
                    inc esi
                    cmp esi, dword [we_read_chr]
                    jne find_cons
            
            cont:
            jmp read_in_file
            
        cleanup:
            push dword [file_descriptor]
            call [fclose]
            add esp, 4
        
        fin:
            push dword [nmb_cons]
            push dword message_cons
            call [printf]
            add esp, 8
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
