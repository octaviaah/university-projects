bits 32 ; assembling for the 32 bits architecture
; our data is declared here (the variables needed by our program) 

segment data use32
    len equ 20
    first times len db 0
    length1 dd 0
    search_word times len db 0

; our code starts here
segment code use32 class=code public 
global _search
    
    _search:
        ; create a stack frame
        push ebp
        mov ebp, esp
        
        ; retreive the function's arguments from the stack
        ; [ebp+4] contains the return value 
        ; [ebp] contains the ebp value for the caller
        mov ebx, [ebp + 8]        ;first word
    
        mov eax, [ebp + 12]        ; ;the word to search into
        mov dword [first], ebx
        mov dword [search_word], eax
        
        mov esi, 0
        real_length1:
            mov al, [first+esi]
            cmp al, 0h
            je delete1
            inc esi
            jmp real_length1
            delete1:
                mov dword [length1], esi
        
        mov esi, 0 ;loop in search_word ltr
        
        cauta_in_search_word:
            mov ecx, dword [length1]
            cmp esi, ecx
            je back ;program jumps to done when this loop finishes
            mov dl, 0 ;dl acts as an ok
            cauta_in_first_word:
                cmp esi, dword [length1]
                jz redo
                mov al, [first+esi]
                mov bl, [search_word+esi]
                cmp al, bl
                jne not_eq
                    add dl, 1
                    inc esi
                    cmp dl, [length1]
                    je done
                    jmp cauta_in_first_word
                    not_eq:
                        inc esi
                        jmp cauta_in_first_word
        done:
            mov eax, 1
            mov esp, ebp
            pop ebp

            ret
            
        back:
            mov eax, 0
            mov esp, ebp
            pop ebp

            ret
