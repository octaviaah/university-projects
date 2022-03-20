bits 32 ; assembling for the 32 bits architecture
; our data is declared here (the variables needed by our program) 
global _maxim

segment data public data use32


; our code starts here
segment code public code use32
    
    _maxim:
        ; create a stack frame
        push ebp
        mov ebp, esp
        ; retreive the function's arguments from the stack
        ; [ebp+4] contains the return value 
        ; [ebp] contains the ebp value for the caller
        mov ebx, [ebp + 8]        ;first number
        ;mov ebx, [ebx]
        mov ecx, [ebp + 12]       ;second number
        ;mov ecx, [ecx]

        cmp ebx, ecx
        jl ecx_max
        
        mov eax, ebx
        jmp end
        
        ecx_max:
        mov eax, ecx
        
        end:
        
        
        mov esp, ebp
        pop ebp

        ret
           
            
      