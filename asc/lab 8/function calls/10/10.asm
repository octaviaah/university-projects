bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, scanf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    n dd 0
    message db "n=", 0
    dformat db "%d", 0
    hformat db "%x", 0

; our code starts here
segment code use32 class=code
    start:
    ;Read a number in base 10 from the keyboard and display the value of that number in base 16 Example: Read: 28; display: 1C
        push dword message ; place the address of the string on the stack
        call [printf] ;call function to print message
        add esp, 4*1 ; clear the stack
        
        push dword n ;place address of n on the stack
        push dword dformat
        call [scanf] ; call function for reading
        add esp, 4*2 ; clear stack
        
        mov eax, [n]; move number to register for printing
        push dword eax ; push address of register on the stack
        push dword hformat ; push format(hexa)
        call [printf];print number in hexa
        add esp, 4*2;clear stack
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
