bits 32
global start

import printf msvcrt.dll
import exit msvcrt.dll
import scanf msvcrt.dll
import fopen msvcrt.dll
import fprintf msvcrt.dll
import fclose msvcrt.dll
extern printf, exit, scanf, fopen, fclose, fprintf

extern factorial

segment data use32
	file_descriptor dd -1
    access_mode db "w", 0
    file_name db "min.txt", 0
    message_n db "n=", 0
    message_no db "enter numbers:", 0
    dformat db "%d", 0
    n dd 0
    number dd 0
    minimum dd 0
    message_min db "the minimum is: %x", 0

segment code use32 public code
start:
    ;Read a string of signed numbers in base 10 from keyboard. Determine the minimum value of the string and write it in the file min.txt (it will be created) in 16 base.
    push dword message_n ;announce we will read n
    call [printf]
    add esp, 4
    
    push dword n
    push dword dformat
    call [scanf]
    add esp, 4*2
    
    push dword message_no ;announce we will read numbers
    call [printf]
    add esp, 4
    
    push dword number ;read first number
    push dword dformat
    call [scanf]
    add esp, 4*2
    
    sub dword [n], 1
    
    mov edx, dword [number]
    mov dword [minimum], edx
    
    repeta:
        mov ecx, 0
        mov cl, [n] ;bc ecx gets different values when we read new numbers, we will use n-1 as our limit
        cmp ecx, 0
        je done
            
        push dword number; read next number
        push dword dformat
        call [scanf]
        add esp, 4*2
            
        mov eax, dword [minimum]
        mov ebx, dword [number]
        push ebx
        push eax
            
        call factorial
        mov dword [minimum], edx
        
        sub dword [n], 1
        jmp repeta
    
    done:
        push dword access_mode ;create file
        push dword file_name
        call [fopen]
        add esp, 4*2
        
        mov [file_descriptor], eax ;move the descriptor of the created file
        
        cmp eax, 0 ;verify if the file was creted
        je final
        
        push dword [minimum] ;write minimum to file
        push dword message_min
        push dword [file_descriptor]
        call [fprintf]
        add esp, 4*3
        
        cont:
        push dword [file_descriptor] ;close the file
        call [fclose]
        add esp, 4
        
        final:
	push 0
	call [exit]