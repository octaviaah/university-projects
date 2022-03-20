bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, fopen, fread, fclose               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fread msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    nmb_even dd 0
    we_read_chr dd 0
    message_even db "the nmb of even numbers: %d", 0
    file_name db "thefile.txt", 0
    file_descriptor dd -1
    access_mode db "r", 0
    len equ 100
    buffer resb len

; our code starts here
segment code use32 class=code
    start:
        ;A text file is given. Read the content of the file, count the number of even digits and display the result on the screen. The name of text file is defined in the data segment.
        push dword access_mode
        push dword file_name
        call [fopen]
        add esp, 4*2
        
        cmp eax, 0
        je fin
        
        mov [file_descriptor], eax
        
        read_full_file:
            push dword [file_descriptor]
            push dword len
            push dword 1
            push dword buffer
            call [fread]
            add esp, 4*4
            
            cmp eax, 0
            je cleanup
            
            mov [we_read_chr], eax
            mov esi, 0
            
            find_even:
                mov al, [buffer+esi]
                cmp al, '0'
                je add_even
                cmp al, '2'
                je add_even
                cmp al, '4'
                je add_even
                cmp al, '6'
                je add_even
                cmp al, '8'
                je add_even
                inc esi
                cmp esi, dword [we_read_chr]
                jne find_even
                je cont
                add_even:
                    add dword[nmb_even], 1
                    inc esi
                    cmp esi, dword [we_read_chr]
                    jne find_even
                    
            cont:
                jmp read_full_file
            
            cleanup:
                push dword file_descriptor
                call [fclose]
                add esp, 4
        
        fin:
            push dword [nmb_even]
            push dword message_even
            call [printf]
            add esp, 4*2
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
