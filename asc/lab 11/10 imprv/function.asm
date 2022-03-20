bits 32 ; assembling for the 32 bits architecture
; our data is declared here (the variables needed by our program) 

segment data use32

; our code starts here
segment code use32 class=code public 
global search
    
    search:
        mov esi, [esp + 4]        ;first word
        mov edi, [esp+8]        ; ;the word to search into
        mov edx, 0
        mov ecx, 0

        cauta_in_search_word:
            cmp byte [esi], 0
            je done
            
            cmp byte [edi], 0
            je back
            
            mov al, [esi]
            cmp al, [edi]
            jne cont
            
            inc esi
            inc edi
            jmp cauta_in_search_word
        
        cont:
            mov esi, [esp+4]
            inc ecx
            mov edi, [esp+8]
            add edi, ecx
            jmp cauta_in_search_word
                
        done:
            mov edx, 1
            ret
            
        back:
            mov edx, 0
            ret
