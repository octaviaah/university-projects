bits 32
global start

import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll
import gets msvcrt.dll

extern exit, printf, scanf, gets

%include "concatenate.asm"

segment data use32 class=data
    format_print db "result: %s", 0
    format_scan db "%s", 0
    string1 resb 100
    string2 resb 100
    string3 resb 100
    concatenated resb 300
    
segment code use32 class=code
start:

;6. Three strings (of characters) are read from the keyboard. 
;Identify and display the result of their concatenation.

    push dword string1
    call [gets]; we read the first string until new line
    add esp, 4 * 2
    
    push dword string2
    call [gets] ; we read the second string until new line
    add esp, 4 * 2
    
    push dword string3
    call [gets]; we read the third string until new line
    add esp, 4 * 2
    
    push dword string1
    push dword string2
    push dword string3
    push dword concatenated
    call concatenate; we call our external function
    
    push dword concatenated
    push dword format_print
    call [printf]; we print the result
    add esp, 4 * 2
    
    push dword 0
    call [exit]
    
    
    
    