; alive.asm
section .note.GNU-stack
section .data
    msg1 db "Hello, world!",10,0
    msg1Len equ $-msg1-1
    msg2 db "We are fine!",10,0
    msg2Len equ $-msg2-1
    radius dq 357
    pi dq 3.14
section .bss
section .text
    global main
main:
    push rbp
    mov rbp, rsp

    mov rax, 1
    mov rdi, 1
    mov rsi, msg1
    mov rdx, msg1Len
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, msg2
    mov rdx, msg2Len
    syscall

    mov rsp, rbp
    pop rbp
    mov rax, 60
    mov rdi, 0
    syscall