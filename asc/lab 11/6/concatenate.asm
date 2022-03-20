%ifndef _CONCATENATE_ASM_
%define _CONCATENATE_ASM_

concatenate:
    mov esi, [esp + 4 * 4]; we save as source index the adress of string1
    mov edi, [esp + 4]; we save as destination index the adress of concatenate
    
    repeat:
        cmp byte [ESI], 0; if we finished the string
        je string2_add; jump to the next string
        movsb
        jmp repeat
        
    string2_add:
        mov esi, [esp + 4 * 3]; we save now the next string
            repeat_string_2:
                cmp byte [ESI], 0; if we finished the string
                je string3_add;jump to the next string
                movsb
                jmp repeat_string_2
    
    string3_add:
        mov esi, [esp + 4 * 2]; we save now the last string
            repeat_string_3:
                cmp byte[ESI], 0
                je end
                movsb
                jmp repeat_string_3
    
    end:
        ret 4*4; we return the number of bytes that must be cleaned from stack
%endif