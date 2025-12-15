; add.asm
extern printf
section .note.GNU-stack
section .data
    fmt db "%s %ld", 10, 0
    fmtint db "The numbers are %ld and %ld", 10, 0
    sum db "Sum =", 0
    number1 dq 22
    number2 dq 18
    neg_number dq -12
section .bss
    result resq 1
section .text
    global main
main:
    push rbp
    mov rbp, rsp

    mov rdi, fmtint
    mov rsi, [number1]
    mov rdx, [number2]
    mov rax, 0
    call printf

    mov rax, [number1]
    add rax, [number2]
    mov [result], rax

    mov rdi, fmt
    mov rsi, sum
    mov rdx, [result]
    mov rax, 0
    call printf

    mov rsp, rbp
    pop rbp
    ret