bits 32 ; assembling for the 32 bits architecture
; our data is declared here (the variables needed by our program) 
global search_word, first, length1, length2
segment data use32
    len equ 20
    first times len db 0
    length1 dd 0
    search_word times len db 0
    length2 dd 0
    keep_track dd 0

; our code starts here
segment code use32 class=code public 
global search
    
    search:
        mov ebx, [esp+4];first word
        mov eax, [esp+8] ;the word to search into
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
                
        mov edi, 0
        real_length2:
            mov al, [search_word+edi]
            cmp al, 0h
            je delete2
            inc edi
            jmp real_length2
            delete2:
                mov dword [length2], edi
        
        mov eax, [length1]
        mov ebx, [length2]
        cmp eax, ebx ;if the length of the first word is bigger than the length of the next one, then it can't be a substring
        jg back
        
        mov edi, 0 ;loop in search_word ltr
        
        cauta_in_search_word:
            mov ecx, dword [length2]
            sub ecx, dword [length1];no of indexes possible for comparing
            cmp edi, ecx
            je back ;program jumps to done when this loop finishes
            mov esi, 0 ;loop in first_word ltr
            mov dl, 0 ;dl acts as an ok
            cauta_in_first_word:
                cmp esi, dword [length1]
                jz redo
                cmp edi, dword [length2]
                jz redo
                mov al, [first+esi]
                mov bl, [search_word+edi]
                cmp al, bl
                jne not_eq
                    add dl, 1
                    inc esi
                    inc edi
                    jmp cauta_in_first_word
                    redo:
                        add byte [keep_track], 1
                        mov edi, dword [keep_track]
                        cmp dl, [length1]
                        je done
                        jmp cauta_in_search_word
                    not_eq:
                        inc edi
                        jmp cauta_in_first_word
        done:
            mov edx, 1
            ret
            
        back:
            mov edx, 0
            ret
