; console.asm
section .data
    msg1 db "Hello, world!", 10, 0
    msg1len equ $-msg1
    msg2 db "Your turn: ", 0
    msg2len equ $-msg2
    msg3 db "Your answer: ", 0
    msg3len equ $-msg3
    inputlen equ 10
section .bss
    input resb inputlen+1
section .text
    global main
main:
    push rbp
    mov rbp, rsp

    mov rsi, msg1
    mov rdx, msg1len
    call prints

    mov rsi, msg2
    mov rdx, msg2len
    call prints

    mov rsi, input
    mov rdx, inputlen
    call reads

    mov rsi, msg3
    mov rdx, msg3len
    call prints

    mov rsi, input
    mov rdx, inputlen
    call prints

    leave
    ret

prints:
    push rbp
    mov rbp, rsp

    mov rax, 1
    mov rdi, 1
    syscall

    leave
    ret

reads:
    push rbp
    mov rbp, rsp

    mov rax, 0
    mov rdi, 1
    syscall

    leave
    ret