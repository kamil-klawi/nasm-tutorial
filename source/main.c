#include <stdio.h>
#include "../include/lib.h"

int main(void) {
    const int x = 5, y = 7;
    const int cc_result = add_cc(x, y);
    const int asm_result = add_asm(x, y);

    printf("C++ add result: %d\n", cc_result);
    printf("ASM add result: %d\n", asm_result);
    return 0;
}