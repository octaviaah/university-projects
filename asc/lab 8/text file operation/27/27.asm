bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fclose, fread, fprintf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fread msvcrt.dll
import fprintf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    file_name db "min.txt", 0
    access_mode db "a+", 0
    file_descriptor dd -1
    dformat db "%d", 0
    we_read_chr dd 0
    index dd 0
    nmb dd 0
    mini dd 99999
    nmb_chr resb 9
    len equ 100
    buffer resb 100
    newline db 13

; our code starts here
segment code use32 class=code
    start:
        ;A text file is given. The text file contains numbers (in base 10) separated by spaces. Read the content of the file, determine the minimum number (from the numbers that have been read) and write the result at the end of file.
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
            mov edi, 0
            
            see_nmb:
                mov al, [buffer+esi]
                cmp al, '0'
                jb not_found
                cmp al, '9'
                ja not_found
                sub al, 30h
                mov [nmb_chr+edi], al
                inc edi
                inc esi
                cmp esi, [we_read_chr]
                jne see_nmb
                je cont
                not_found:
                    mov byte [nmb_chr+edi], 21h
                    mov edi, 0
                    xor eax, eax
                    mov ebx, 10
                    
                    mov [index], esi
                    
                    mov esi, 0
                    create_number:
                        mul ebx
                        mov ecx, eax
                        xor eax, eax
                        mov al, [nmb_chr+esi]
                        add ecx, eax
                        mov [nmb], ecx
                        inc esi
                        cmp byte [nmb_chr+esi], 21h
                        jne create_number
                        
                   mov eax, [nmb]
                   cmp eax, dword [mini]
                   jge not_min
                   mov [mini], eax
                   
                   not_min:  
                        clean:
                            mov dword [nmb_chr+edi], 0
                            inc edi
                            cmp edi, 8
                            jne clean
                   mov edi, 0
                   mov esi, [index]
                   inc esi
                   cmp esi, [we_read_chr]
                   jne see_nmb
                   
          cont:
            jmp read_full_file
                        
         cleanup:
            push dword newline
            push dword [file_descriptor]
            call [fprintf]
            add esp, 8
            
            push dword [mini]
            push dword dformat
            push dword [file_descriptor]
            call [fprintf]
            add esp, 12
            
            push dword [file_descriptor]
            call [fclose]
            add esp, 4
         
       fin:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
