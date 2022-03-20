bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    sir_cuv dw 21520, -6, "xy", 0f5b2h, -129
    len equ $-sir_cuv
    max dd 0
    min dd 99999
    mult2 dd 0
    message db "catul = %x; restul = %x", 0

; our code starts here
segment code use32 class=code
    start:
        ;Se da un sir de N cuvinte. Sa se tipareasca in baza 16 catul si restul impartirii fara semn A/B, unde A este maximul valorilor octetilor inferiori ai sirului de cuvinte date, iar B este minimul valorilor octetilor superiori ai sirului de cuvinte date. 
        ;sir_cuv dw 21520, -6, "xy", 0f5b2h, -129.
        ;Exemplu: A=194 si B=10, la iesire se va afisa pe ecran catul = 13h si restul = 04h.
        mov esi, 0
        read_string:
            add dword [mult2], 2
            xor eax, eax
            mov al, [sir_cuv+esi]
            cmp eax, [min]
            jge cont
            mov [min], eax
            cont:
                inc esi
                xor eax, eax
                mov al, [sir_cuv+esi]
                cmp eax, [max]
                jle cont2
                mov [max], eax
                cont2:
                    inc esi
                    cmp esi, len
                    je print_value
                    cmp esi, dword [mult2]
                    je read_string
        
        print_value:
            mov eax, [max]
            mov edx, 0
            mov ebx, [min]
            div ebx
            
            push edx
            push eax
            push dword message
            call [printf]
            add esp, 12
         
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
