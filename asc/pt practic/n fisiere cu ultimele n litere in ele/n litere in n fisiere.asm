bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fclose, fread, fprintf, scanf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fprintf msvcrt.dll
import fread msvcrt.dll
import scanf msvcrt.dll

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
    nmb dd 0
    nmb_chr dd 0
    dformat db "%d", 0
    index dd 0
    index_when_printing dd 0
    chr dd 0
    cformat db "%c", 0
    len equ 100
    we_read_chr dd 0
    buffer resb len

; our code starts here
segment code use32 class=code
    start:
        ;se citeste un numar de la tastatura(max 2 cifre cred). Se mai citeste si un sir de caractere dintr-un fisier(??)
       ;Sa se genereze n fisiere (i de la 0 la n) de forma "i.output.txt" care sa contina sirul de caractere citit/ultimele n carctere din sirul citit
    ;Ex: n=4
            ;fisier1: "abcdefgh"
            ;se genereaza, fiecare cu continutul "efgh"
         ;0.output.txt 
        ;1.output.txt
        ;2.output.txt
        ;3.output.txt
        ;4.output.txt
        push dword access_mode1
        push dword file_name
        call [fopen]
        add esp, 8
        
        cmp eax, 0
        je fin
        
        mov [file_descriptor], eax
        
        push dword nmb
        push dword dformat
        call [scanf]
        add esp, 8
        
        transform_nmb_to_chr:
            mov eax, [nmb]
            mov ebx, 10
            mov edx, 0
            
            div ebx
            add al, 30h
            mov [nmb_chr+0], al
            
            mov eax, edx
            add al, 30h
            mov [nmb_chr+1], al
        
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
            
            mov eax, [we_read_chr]
            sub eax, [nmb]
            mov [index], eax
            
            
         
       mov esi, [index]
       cmp byte [nmb_chr+0], 30h
       jne create_files_2
       create_files_1:
            xor eax, eax
            mov al, [nmb_chr+1]
            mov [out_file_name1+0], al
            
            push dword access_mode2
            push dword out_file_name1
            call [fopen]
            add esp, 8
            
            cmp eax, 0
            je fin
            
            mov [file_desc1], eax
            
            write_word_to_file1:
                mov al, [buffer+esi]
                mov [index_when_printing], esi
                mov byte [chr], al
                
                push dword [chr]
                push dword cformat
                push dword [file_desc1]
                call [fprintf]
                add esp, 12
                
                mov esi, [index_when_printing]
                inc esi
                cmp esi, [we_read_chr]
                jne write_word_to_file1
                
            mov esi, [index]
            
            push dword [file_desc1]
            call [fclose]
            add esp, 4
            
            sub byte [nmb_chr+1], 1
            cmp byte[nmb_chr+1], 2fh
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
            
            write_word_to_file2:
                mov al, [buffer+esi]
                mov [index_when_printing], esi
                mov byte [chr], al
                
                push dword [chr]
                push dword cformat
                push dword [file_desc2]
                call [fprintf]
                add esp, 12
                
                mov esi, [index_when_printing]
                inc esi
                cmp esi, [we_read_chr]
                jne write_word_to_file2
            
            mov esi, [index]
            
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
