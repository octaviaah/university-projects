bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fclose, fread, fprintf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fprintf msvcrt.dll
import fread msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    file_name db "fisier.txt", 0
    access_mode1 db "r", 0
    access_mode2 db "w", 0
    file_descriptor dd -1
    out_file_name1 db "i.output.txt", 0
    out_file_name2 db "ii.output.txt", 0
    file_desc1 dd -1
    file_desc2 dd -1
    nmb_chr resb 2
    nmb dd 0
    len equ 4
    we_read_chr dd 0
    buffer resb len

; our code starts here
segment code use32 class=code
    start:
        ;se citeste un numar din fisier(max 2 cifre cred). Sa se genereze n fisiere (i de la 0 la n) de forma "i.output.txt". 
        push dword access_mode1
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
            mov edi, 0
            
            transform_from_chr_to_nmb:
                mov ebx, [we_read_chr]
                cmp ebx, 2
                je get_2_digit_nmb
                mov al, [buffer+esi]
                mov [nmb_chr+edi], al
                sub al, 30h
                mov byte [nmb], al
                jmp create_files_1
                get_2_digit_nmb:
                    mov al, [buffer+esi]
                    mov [nmb_chr+edi], al
                    sub al, 30h
                    
                    mov eax, 10
                    mov ebx, [nmb_chr]
                    mul ebx
                    mov [nmb], eax
                    
                    inc esi
                    inc edi
                    mov al, [buffer+esi]
                    mov [nmb_chr+edi], al
                    sub al, 30h
                    add byte [nmb], al
                    jmp create_files_2
         
       mov esi, 0
       create_files_1:
            xor eax, eax
            mov al, [nmb_chr+esi]
            mov [out_file_name1+0], al
            
            push dword access_mode2
            push dword out_file_name1
            call [fopen]
            add esp, 8
            
            cmp eax, 0
            je fin
            
            mov [file_desc1], eax
            
            push dword [file_desc1]
            call [fclose]
            add esp, 4
            
            sub byte [nmb_chr+esi], 1
            cmp byte[nmb_chr+esi], 2fh
            je fin
            jne create_files_1
            
      create_files_2:
            xor eax, eax
            mov al, [nmb_chr+0]
            mov [out_file_name2+0], al
            
            mov al, [nmb_chr+1]
            mov [out_file_name2+1], al
            
            push dword access_mode2
            push dword out_file_name2
            call [fopen]
            add esp, 8
            
            cmp eax, 0
            je fin
            
            mov [file_desc2], eax
            
            push dword [file_desc2]
            call [fclose]
            add esp, 4
            
            sub byte [nmb_chr+1], 1
            cmp byte[nmb_chr+1], 2fh
            je lower
            jne create_files_2
            lower:
                add byte [nmb_chr+1], 10
                sub byte [nmb_chr+0], 1
                cmp byte [nmb_chr+0], 30h
                mov esi, 1
                je create_files_1
                jne create_files_2
            
       cleanup:
            push dword [file_descriptor]
            call [fclose]
            add esp, 4
            
        fin:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
