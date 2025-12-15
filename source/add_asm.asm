; add_asm.asm
section .text
    global add_asm
add_asm:
    mov rax, rdi
    add rax, rsi
    ret