hello: hello.o
	gcc -o build/hello build/hello.o -no-pie
hello.o: asm/hello.asm | build
	nasm -f elf64 -g -F dwarf asm/hello.asm -o build/hello.o -l build/hello.lst

alive: alive.o
	gcc -o build/alive build/alive.o -no-pie
alive.o: asm/alive.asm | build
	nasm -f elf64 -g -F dwarf asm/alive.asm -o build/alive.o -l build/alive.lst

hello2: hello2.o
	gcc -o build/hello2 build/hello2.o -no-pie
hello2.o: asm/hello2.asm | build
	nasm -f elf64 -g -F dwarf asm/hello2.asm -o build/hello2.o -l build/hello2.lst

jump: jump.o
	gcc -o build/jump build/jump.o -no-pie
jump.o: asm/jump.asm | build
	nasm -f elf64 -g -F dwarf asm/jump.asm -o build/jump.o -l build/jump.lst

betterloop: betterloop.o
	gcc -o build/betterloop build/betterloop.o -no-pie
betterloop.o: asm/betterloop.asm | build
	nasm -f elf64 -g -F dwarf asm/betterloop.asm -o build/betterloop.o -l build/betterloop.lst

add: add.o
	gcc -o build/add build/add.o -no-pie
add.o: asm/add.asm | build
	nasm -f elf64 -g -F dwarf asm/add.asm -o build/add.o -l build/add.lst

stack: stack.o
	gcc -o build/stack build/stack.o -no-pie
stack.o: asm/stack.asm | build
	nasm -f elf64 -g -F dwarf asm/stack.asm -o build/stack.o -l build/stack.lst

fcalc: fcalc.o
	gcc -o build/fcalc build/fcalc.o -no-pie
fcalc.o: asm/fcalc.asm | build
	nasm -f elf64 -g -F dwarf asm/fcalc.asm -o build/fcalc.o -l build/fcalc.lst

function: function.o
	gcc -o build/function build/function.o -no-pie
function.o: asm/function.asm | build
	nasm -f elf64 -g -F dwarf asm/function.asm -o build/function.o -l build/function.lst

function2: function2.o
	gcc -o build/function2 build/function2.o -no-pie
function2.o: asm/function2.asm | build
	nasm -f elf64 -g -F dwarf asm/function2.asm -o build/function2.o -l build/function2.lst

macro: macro.o
	gcc -o build/macro build/macro.o -no-pie
macro.o: asm/macro.asm | build
	nasm -f elf64 -g -F dwarf asm/macro.asm -o build/macro.o -l build/macro.lst

console: console.o
	gcc -o build/console build/console.o -no-pie
console.o: asm/console.asm | build
	nasm -f elf64 -g -F dwarf asm/console.asm -o build/console.o -l build/console.lst

clean:
	rm -rf build

build:
	mkdir -p build