; stack.asm
extern printf
section .note.GNU-stack
section .data
    strng db "ABCDE",0
    strngLen equ $ - strng-1
    fmt1 db "Pierwotny lancuch %s",10,0
    fmt2 db "Odwrocony lancuch %s",10,0
section .bss
section .text
    global main
main:
    push rbp
    mov rbp, rsp

    mov rdi, fmt1
    mov rsi, strng
    mov rax, 0
    call printf

    xor rax, rax
    mov rbx, strng
    mov rcx, strngLen
    mov r12, 0

pushLoop:
    mov al, byte[rbx+r12]
    push rax
    inc r12
    loop pushLoop

    mov rbx, strng
    mov rcx, strngLen
    mov r12, 0

popLoop:
    pop rax
    mov byte[rbx+r12], al
    inc r12
    loop popLoop
    mov byte[rbx+r12], 0

    mov rdi, fmt2
    mov rsi, strng
    mov rax, 0
    call printf

    mov rsp, rbp
    pop rbp
    ret