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
    nmb_in_ascii resb 5
    file_name db "my_file.txt", 0
    access_mode db "w", 0
    text db "ma ma ma oa d", 0
    file_descriptor dd -1
    index dd 0
    index2 dd 0
    new_text resb 100

; our code starts here
segment code use32 class=code
    start:
        ;A file name and a text (defined in the data segment) are given. The text contains lowercase letters and spaces. Replace all the letters on even positions with their position. Create a file with the given name and write the generated text to file.
        push dword access_mode
        push dword file_name
        call [fopen]
        add esp, 8
        
        cmp eax, 0
        je fin
        
        mov [file_descriptor], eax
        mov esi, 0
        mov edi, 0
        
        read_text:
            mov al, [text+esi]
            cmp al, 'a'
            jb not_found
            cmp al, 'z'
            ja not_found
            mov bl, al
            mov edx, 0
            mov eax, esi
            mov ecx, 2
            div ecx
            cmp edx, 0
            je change
            xor eax, eax
            mov al, bl
            mov [new_text+edi], al
            inc esi
            inc edi
            cmp byte [text+esi], 0
            je write_text
            jne read_text
            change:
                xor eax, eax
                mov eax, esi
                mov ebx, 10
                
                mov [index], edi
                mov edi, 3
                convert_chr_to_nmb:
                    mov edx, 0
                    div ebx
                    add edx, 30h
                    
                    mov [nmb_in_ascii+edi], dl
                    dec edi
                    
                    cmp eax, 0
                    jnz convert_chr_to_nmb
                mov [index2], esi
                mov esi, 0
                advance:
                    cmp byte[nmb_in_ascii+esi], 0
                    jne putnmb
                    inc esi
                    jmp advance
                putnmb:    
                mov edi, [index]
                add_index:
                    mov al, [nmb_in_ascii+esi]
                    mov [new_text+edi], al
                    inc edi
                    inc esi
                    cmp byte [nmb_in_ascii+esi], 0
                    jne add_index
                mov esi, [index2]
                inc esi
                cmp byte [text+esi], 0
                je write_text
                jne read_text
                
                not_found:
                    mov [new_text+edi], al
                    inc esi
                    inc edi
                    cmp byte [text+esi], 0
                    jne read_text
                
        write_text:
            push dword new_text
            push dword [file_descriptor]
            call [fprintf]
            add esp, 8
            
            push dword [file_descriptor]
            call [fclose]
            add esp, 4
        
        fin:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
