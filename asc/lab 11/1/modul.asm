bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global rotate     

; declare external functions needed by our program
extern start, printf
import printf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data public
    xformat db "%x", 0
    a dd 0
    ccx dd 0
    newline db 13,10
; our code starts here
segment code use32 class=code public
rotate:
    mov eax, [esp+4]
    mov dword[a], eax
    mov dword [ccx], 7
    mov ecx, 7
    the_loop:
            push dword newline
            call [printf]
            add esp, 4
            
            mov eax, [a]
            rol eax, 4
            mov dword [a], eax
            
            push eax
            push dword xformat
            call [printf]
            add esp, 4*2

            sub dword [ccx],1
            mov ecx, [ccx]
            jnz the_loop
    ret