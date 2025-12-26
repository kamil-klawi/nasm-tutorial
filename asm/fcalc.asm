; fcalc.asm
extern printf
section .data
    number1 dq 9.0
    number2 dq 73.0
    fmt db "Liczby to %f i %f", 10, 0
    fmtfloat db "%s %f", 10, 0
    f_sum db "Zmiennoprzecinkowa suma %f i %f to %f", 10, 0
    f_dif db "Zmiennoprzecinkowa roznica %f i %f to %f", 10, 0
    f_mul db "Zmiennoprzecinkowa iloczyn %f i %f to %f", 10, 0
    f_div db "Zmiennoprzecinkowa iloraz %f i %f to %f", 10, 0
    f_sqrt db "Pierwiastek kwadratowy z %f to %f", 10, 0
section .bss
section .text
    global main
main:
    push rbp
    mov rbp, rsp

    ; wypisujemy liczby
    movsd xmm0, [number1]
    movsd xmm1, [number2]
    mov rdi, fmt
    mov rax, 2 ; wartosc zmiennoprzecinkowa = 2
    call printf

    ; suma
    movsd xmm2, [number1]
    addsd xmm2, [number2]
    movsd xmm0, [number1]
    movsd xmm1, [number2]
    mov rdi, f_sum
    mov rax, 3
    call printf

    ; roznica
    movsd xmm2, [number1]
    subsd xmm2, [number2]
    movsd xmm0, [number1]
    movsd xmm1, [number2]
    mov rdi, f_dif
    mov rax, 3
    call printf

    ; mnozenie
    movsd xmm2, [number1]
    mulsd xmm2, [number2]
    movsd xmm0, [number1]
    movsd xmm1, [number2]
    mov rdi, f_mul
    mov rax, 3
    call printf

    ; dzielenie
    movsd xmm2, [number1]
    divsd xmm2, [number2]
    movsd xmm0, [number1]
    movsd xmm1, [number2]
    mov rdi, f_div
    mov rax, 3
    call printf

    ; pierwiastek kwadratowy
    sqrtsd xmm1, [number1]
    mov rdi, f_sqrt
    movsd xmm0, [number1]
    mov rax, 2
    call printf

    mov rsp, rbp
    pop rbp
    ret