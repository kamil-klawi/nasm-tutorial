cmake_minimum_required(VERSION 4.1)
project(nasm_tutorial C CXX ASM_NASM)

set(CMAKE_C_STANDARD 17)
set(CMAKE_CXX_STANDARD 20)

enable_language(ASM_NASM)

add_executable(nasm_tutorial
        source/main.c
        source/lib.cc
        source/add_asm.asm
)
