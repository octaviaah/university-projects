bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, scanf, printf           ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import scanf msvcrt.dll
import printf msvcrt.dll
extern search

; our data is declared here (the variables needed by our program)
segment data use32 class=data public
    n db 0
    len equ 10
    wrd times len db 0
    message_n db "n=", 0
    message_words db "enter words:", 0
    dformat db "%d", 0
    sformat db "%s", 0
    first_wrd times len db 0
    substring db 1
    bad_message db "no substring", 0
    good_message db "yes substring", 0
; our code starts here
segment code use32 class=code public
    start:
    ;Multiple strings of characters are being read. Determine whether the first appears as a subsequence in each of the others and give an appropriate message.
        push dword message_n; announce we will read n
        call [printf]
        add esp, 4*1
        
        push dword n ;read the number of words we will read
        push dword dformat
        call [scanf]
        add esp, 4*2
        
        push dword message_words; announce we will read the words
        call [printf]
        add esp, 4*1
        
        push dword first_wrd; read first word
        push dword sformat
        call [scanf]
        add esp, 4*2
        sub byte [n], 1
        
        
        repeta:
            mov ecx, 0
            mov cl, [n] ;bc ecx gets different values when we read new words, we will use n as our limit
            cmp ecx, 0
            je done
            
            push dword wrd; read next word
            push dword sformat
            call [scanf]
            add esp, 4*2
           
            push dword wrd
            push dword first_wrd

            call search
            cmp edx, 0
            je not_good
            
            sub byte [n], 1
            jmp repeta
            
            not_good:
                mov byte [substring], 0
                sub byte [n], 1
                jmp repeta
        done:
            mov edx, 0
            mov dl, byte [substring]
            cmp edx, 1
            je good_m
            push dword bad_message
            call [printf]
            add esp, 4
            jmp fin
            good_m:
                push dword good_message
                call [printf]
                add esp, 4
        ; exit(0)
        fin:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
