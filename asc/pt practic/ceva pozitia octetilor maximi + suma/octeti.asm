bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fprintf, fclose               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fprintf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    string dd 1234A678h , 123456789h , 1AC3B47Dh, 0FEDC9876h
    len equ $-string
    sum dd 0
    access_mode db "w", 0
    file_name db "file.txt", 0
    file_descriptor dd -1
    max dd 0
    max_index dd 0
    byte_index dd 0
    byte_string resb 20
    index dd 3
    mult4 dd 4
    dformat db "%d", 0
    newline db 13
    

; our code starts here
segment code use32 class=code
    start:
        ;Se da un sir de dublucuvinte (in segmentul de date). 
        ;Se cere formarea si scrierea in fisier pozitiile octetilor de valoare maxima din fiecare dublucuvant. (evident considerandule fare semn).
        ;Sa se afiseze si suma acestor octeti (consideranduse cu semn).
        ;Exemplu: dd 1234A678h , 123456789h , 1AC3B47Dh, FEDC9876h .
        ;Sirul format din pozitiile octetilor este: "3421".
        push dword access_mode
        push dword file_name
        call [fopen]
        add esp, 8
        
        cmp eax, 0
        je fin
        
        mov [file_descriptor], eax
        mov esi, 0
        
        read_string:
            xor eax, eax
            mov al, [string+esi]
            cmp eax, dword [max]
            jle cont
            mov dword [max], eax
            mov ebx, [index]
            mov [max_index], ebx
            add dword [max_index], 1
            cont:
                inc esi
                sub dword [index], 1
                cmp esi, dword [mult4]
                jne read_string
                je redo
                
           redo:
                add dword [mult4], 4
                mov edi, [byte_index]
                mov ax, word [sum]
                cwd
                mov bx, ax
                mov cx, dx
                
                mov ax, word [max]
                cwd
                add bx, ax
                adc cx, dx
                
                mov word [sum], ax
                mov word [sum+2], dx
                
                mov al, byte [max_index]
                add al, 30h
                mov [byte_string+edi], al
                add dword [byte_index], 1
                
                mov dword [max], 0
                mov dword [max_index], 0
                mov dword [index], 3
                
                cmp esi, len
                jne read_string
             
           write_text:
                push dword byte_string
                push dword [file_descriptor]
                call [fprintf]
                add esp, 8
                
                push dword newline
                push dword [file_descriptor]
                call [fprintf]
                add esp, 8
                
                push dword [sum]
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
