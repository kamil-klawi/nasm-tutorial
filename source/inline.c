#include <stdio.h>

int x=11, y=12, sum, prod;
int subtract(void);
void multiply(void);

int main(void) {
    printf("Liczby to %d i %d\n", x, y);

    __asm__(
        "mov eax, %1;"
        "add eax, %2;"
        "mov %0, eax;"
        : "=m"(sum) // Operand wyjsciowy
        : "m"(x), "m"(y)  // Operand wejsciowy
        : "eax" // Lista rejestrow
        );

    printf("Suma to %d.\n", sum);
    printf("Roznica to %d.\n", subtract());
    multiply();
    printf("Iloczyn to %d.\n", prod);
}

int subtract(void) {
    int result;
    __asm__ (
        "mov eax, %1;"
        "sub eax, %2;"
        "mov %0, eax;"
        : "=r"(result)
        : "m"(x), "m"(y)
        : "eax"
    );
    return result;
}

void multiply(void) {
    __asm__ (
        "mov eax, %1;"
        "imul eax, %2;"
        "mov %0, eax;"
        : "=m"(prod)
        : "m"(x), "m"(y)
        : "eax"
    );
}