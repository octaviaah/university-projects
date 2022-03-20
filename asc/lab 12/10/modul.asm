bits 32 ; assembling for the 32 bits architecture
; our data is declared here (the variables needed by our program) 
global _search
extern _printf
; this is a module similar to strcmp: it compares 2 strings of the same size and returns 1 if they are the same and 0 otherwise
; parameters: 2 strings and their length

segment data public data use32
    format db "%s", 10, 0
    first times 100 db 0
    search_word times 100 db 0
; our code starts here
segment code public code use32
    
    _search:
        ; create a stack frame
        push ebp
        mov ebp, esp
        
        ; retreive the function's arguments from the stack
        ; [ebp+4] contains the return value 
        ; [ebp] contains the ebp value for the caller
        ; we work with the characters of the string, which is located at the address given through the parameters
        mov ebx, [ebp + 8]        ;first word
        mov ebx, [ebx]
        mov eax, [ebp + 12]       ;the word to search into
        mov eax, [eax]
        mov [first], ebx
        mov [search_word], eax
        mov ecx, [ebp + 16] ;the lenght
        mov esi, 0
        
        
        
        compare_letters:
        cmp ecx, esi ;if all letters are the same (no difference had been found), then we return 1
        je done
        mov al, [first+esi]
        mov bl, [search_word+esi]
        cmp al,bl ;comparing 2 characters
        jne back ;if they are different it means that the whole 2 strings are different, thus we return 0
        inc esi
        jmp compare_letters
        
        
        done:
            mov eax, 1
            mov esp, ebp
            pop ebp

            ret
            jmp end
            
        back:
            mov eax, 0
            mov esp, ebp
            pop ebp

            ret
        end:
