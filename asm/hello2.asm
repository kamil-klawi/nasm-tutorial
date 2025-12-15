; hello2.asm
section .note.GNU-stack
extern printf
section .data
    msg db "Hello, world!", 0
    fmtstr db "It is our string: %s", 10, 0
section .bss
section .text
    global main
main:
    push rbp
    mov rbp, rsp

    mov rdi, fmtstr
    mov rsi, msg
    mov rax, 0
    call printf

    mov rsp, rbp
    pop rbp
    mov rax, 60
    mov rdi, 0
    syscall