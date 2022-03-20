bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fclose, fprintf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fprintf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    file_name db "file.txt", 0
    access_mode db "w", 0
    file_descriptor dd -1
    nmb dd 12aaah
    cformat db "%c", 0
    nmb_chr resb 9
    newline db 13

; our code starts here
segment code use32 class=code
    start:
        ;A file name and a hexadecimal number (on 16 bits) are given. Create a file with the given name and write each nibble composing the hexadecimal number on a different line to file.
        push dword access_mode
        push dword file_name
        call [fopen]
        add esp, 8
        
        cmp eax, 0
        je fin
        
        mov [file_descriptor], eax
        mov eax, [nmb]
        mov edi, 7
        
        convert_nmb_to_chr:
            mov edx, 0
            mov ebx, 16
            div ebx
            cmp dl, 0ah
            je add_more
            cmp dl, 0bh
            je add_more
            cmp dl, 0ch
            je add_more
            cmp dl, 0dh
            je add_more
            cmp dl, 0eh
            je add_more
            cmp dl, 0fh
            je add_more
            
            add edx, 30h
            
            mov ecx, eax
            mov eax, edx
            
            mov [nmb_chr+edi], al
            dec edi
            
            mov eax, ecx
            cmp eax, 0
            jne convert_nmb_to_chr
            je cont
            
            add_more:
                add edx, 57h
                mov ecx, eax
                mov eax, edx
            
                mov [nmb_chr+edi], al
                dec edi
            
                mov eax, ecx
                cmp eax, 0
                jne convert_nmb_to_chr
                
        cont:    
        mov esi, 0
        start_to_add:
            cmp byte [nmb_chr+esi], 0
            jne print_digit
            inc esi
            jmp start_to_add
            
        print_digit:
            xor eax, eax
            mov al, [nmb_chr+esi]
            push eax
            push dword cformat
            push dword [file_descriptor]
            call [fprintf]
            add esp, 12
            
            push dword newline
            push dword [file_descriptor]
            call [fprintf]
            add esp, 8
            
            inc esi
            cmp esi, 8
            je cleanup
            jne print_digit
            
        cleanup:
            push dword [file_descriptor]
            call [fclose]
            add esp, 4
        
        fin:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
