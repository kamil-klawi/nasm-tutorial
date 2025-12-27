; file.asm
section .data
    ; wyrazenia uzywane do asemblacji warunkowej
    CREATE      equ    1
    OVERWRITE   equ    1
    APPEND      equ    1
    O_WRITE     equ    1
    READ        equ    1
    O_READ      equ    1
    DELETE      equ    1

    ; symbole wywolan systemowych
    NR_read     equ    0
    NR_write    equ    1
    NR_open     equ    2
    NR_close    equ    3
    NR_lseek    equ    8
    NR_create   equ    85
    NR_unlink   equ    87

    ; flagi tworzenia i stanu
    O_CREAT     equ    00000100
    O_APPEND    equ    00002000

    ; tryb dostepu
    O_RDONLY    equ    000000
    O_WRONLY    equ    000001
    O_RDWR      equ    000002

    ; tryb tworzenia
    S_IRUSR     equ    00400 ; uprawnienia do odczytu
    S_IWUSR     equ    00200 ; uprawnienia do zapisu

    NL          equ    0xa
    bufferlen   equ    64

    filename    db     "testfile.txt", 0
    FD          dq     0 ; deskryptor pliku

    text1       db     "1. Witam... wszystkich!", NL, 0
    len1        equ    $-text1-1 ; usuwamy 0 na koncu
    text2       db     "2. Tu jestem!", NL, 0
    len2        equ    $-text2-1 ; usuwamy 0 na koncu
    text3       db     "3. Zyje i mam sie dobrze!", NL, 0
    len3        equ    $-text3-1 ; usuwamy 0 na koncu
    text4       db     "Adios !!!", NL, 0
    len4        equ    $-text4-1 ; usuwamy 0 na koncu

    error_Create      db    "Blad podczas tworzenia pliku", NL, 0
    error_Close       db    "Blad podczas zamykania pliku", NL, 0
    error_Write       db    "Blad podczas zapisywania pliku", NL, 0
    error_Open        db    "Blad podczas otwierania pliku", NL, 0
    error_Append      db    "Blad podczas dolaczania do pliku", NL, 0
    error_Delete      db    "Blad podczas usuwania pliku", NL, 0
    error_Read        db    "Blad podczas odczytywania pliku", NL, 0
    error_Print       db    "Blad podczas wypisywania lancucha", NL, 0
    error_Position    db    "Blad podczas ustawiania pozycji", NL, 0

    success_Create      db    "Utworzono i otwarto plik", NL, 0
    success_Close       db    "Zamknieto plik", NL, 0
    success_Write       db    "Zapisano plik", NL, 0
    success_Open        db    "Otwarto plik", NL, 0
    success_Append      db    "Otwarto plik do dolaczania", NL, 0
    success_Delete      db    "Usunieto plik", NL, 0
    success_Read        db    "Odczytano plik", NL, 0
    success_Position    db    "Ustawiono pozycje w pliku", NL, 0

section .bss
    buffer    resb    bufferlen

section .text
    global main
main:
    push rbp
    mov  rbp, rsp

    %IF CREATE
        ; tworzymy plik
        mov  rdi, filename
        call createFile
        mov  qword [FD], rax ; zapisujemy deskryptor

        ; pierwszy zapis do pliku
        mov  rdi, qword [FD]
        mov  rsi, text1
        mov  rdx, qword [len1]
        call writeFile

        ; zamykamy plik
        mov  rdi, qword [FD]
        call closeFile
    %ENDIF

    %IF OVERWRITE
        ; otwieramy plik
        mov  rdi, filename
        call openFile
        mov  qword [FD], rax ; zapisujemy deskryptor

        ; drugi zapis do pliku (NADPISANIE PLIKU)
        mov  rdi, qword [FD]
        mov  rsi, text2
        mov  rdx, qword [len2]
        call writeFile

        ; zamykamy plik
        mov  rdi, qword [FD]
        call closeFile
    %ENDIF

    %IF APPEND
        ; otwieramy plik do dolaczania
        mov  rdi, filename
        call appendFile
        mov  qword [FD], rax ; zapisujemy deskryptor

        ; trzeci zapis do pliku (DOLACZANIA DO PLIKU)
        mov  rdi, qword [FD]
        mov  rsi, text3
        mov  rdx, qword [len3]
        call writeFile

        ; zamykamy plik
        mov  rdi, qword [FD]
        call closeFile
    %ENDIF

    %IF O_WRITE
        ; otwieramy plik do zapisu
        mov  rdi, filename
        call openFile
        mov  qword [FD], rax ; zapisujemy deskryptor

        ; ustawiamy pozycje w pliku
        mov  rdi, qword [FD]
        mov  rsi, qword [len2]
        mov  rdx, 0
        call positionFile

        ; czwarty zapis do pliku (ZAPIS Z PRZESUNIECIEM)
        mov  rdi, qword [FD]
        mov  rsi, text4
        mov  rdx, qword [len4]
        call writeFile

        ; zamykamy plik
        mov  rdi, qword [FD]
        call closeFile
    %ENDIF

    %IF READ
        ; otwieramy plik do odczytu
        mov  rdi, filename
        call openFile
        mov  qword [FD], rax ; zapisujemy deskryptor

        ; czytamy z pliku
        mov  rdi, qword [FD]
        mov  rsi, buffer
        mov  rdx, bufferlen
        call readFile
        mov  rdi, rax
        call printString

        ; zamykamy plik
        mov  rdi, qword [FD]
        call closeFile
    %ENDIF

    %IF O_READ
        ; otwieramy plik do odczytu
        mov  rdi, filename
        call openFile
        mov  qword [FD], rax ; zapisujemy deskryptor

        ; ustawiamy pozycje w pliku
        mov  rdi, qword [FD]
        mov  rsi, qword [len2] ; pomijamy pierwszy wiersz
        mov  rdx, 0
        call positionFile

        ; czytamy z pliku
        mov  rdi, qword [FD]
        mov  rsi, buffer
        mov  rdx, 10 ; liczba znakow do odczytania
        call readFile
        mov  rdi, rax
        call printString

        ; zamykamy plik
        mov  rdi, qword [FD]
        call closeFile
    %ENDIF

    %IF DELETE
        ; usuwamy plik
        mov  rdi, filename
        call deleteFile
    %ENDIF

    leave
    ret

    ;---------------------------------------
    global readFile
readFile:
    mov rax, NR_read
    syscall ; rax zawiera liczbe odczytanych znakow
    cmp rax, 0
    jl  readerror
    mov byte [rsi+rax], 0 ; dodajemy koncowe zero do lancucha
    mov rax, rsi

    mov  rdi, success_Read
    push rax ; rejestr zapisywany przez wywolujacego
    call printString
    pop  rax  ; rejestr zapisywany przez wywolujacego
    ret
readerror:
    mov  rdi, error_Read
    call printString
    ret

    ;---------------------------------------
    global deleteFile
deleteFile:
    mov  rax, NR_unlink
    syscall
    cmp  rax, 0
    jl   deleteerror
    mov  rdi, success_Delete
    call printString
    ret
deleteerror:
    mov  rdi, error_Delete
    call printString
    ret

    ;---------------------------------------
    global appendFile
appendFile:
    mov  rax, NR_open
    mov  rsi, O_RDWR|O_APPEND
    syscall
    cmp  rax, 0
    jl   appenderror
    mov  rdi, success_Append
    push rax ; rejestr zapisywany przez wywolujacego
    call printString
    pop  rax  ; rejestr zapisywany przez wywolujacego
    ret
appenderror:
    mov  rdi, error_Append
    call printString
    ret

    ;---------------------------------------
    global openFile
openFile:
    mov  rax, NR_open
    mov  rsi, O_RDWR
    syscall
    cmp  rax, 0
    jl   openerror
    mov  rdi, success_Open
    push rax ; rejestr zapisywany przez wywolujacego
    call printString
    pop  rax  ; rejestr zapisywany przez wywolujacego
    ret
openerror:
    mov  rdi, error_Open
    call printString
    ret

    ;---------------------------------------
    global writeFile
writeFile:
    mov  rax, NR_write
    syscall
    cmp  rax, 0
    jl   writeerror
    mov  rdi, success_Write
    call printString
    ret
writeerror:
    mov  rdi, error_Write
    call printString
    ret

    ;---------------------------------------
    global positionFile
positionFile:
    mov  rax, NR_lseek
    syscall
    cmp  rax, 0
    jl   positionerror
    mov  rdi, success_Position
    call printString
    ret
positionerror:
    mov  rdi, error_Position
    call printString
    ret

    ;---------------------------------------
    global closeFile
closeFile:
    mov  rax, NR_close
    syscall
    cmp  rax, 0
    jl   closeerror
    mov  rdi, success_Close
    call printString
    ret
closeerror:
    mov  rdi, error_Close
    call printString
    ret

    ;---------------------------------------
    global createFile
createFile:
    mov  rax, NR_create
    mov  rsi, S_IRUSR|S_IWUSR
    syscall
    cmp  rax, 0
    jl   createerror
    mov  rdi, success_Create
    push rax  ; rejestr zapisywany przez wywolujacego
    call printString
    pop  rax  ; rejestr zapisywany przez wywolujacego
    ret
createerror:
    mov  rdi, error_Create
    call printString
    ret

    ;---------------------------------------
    global printString
printString:
    ; Liczenie znakow
    mov r12, rdi
    mov rdx, 0
strLoop:
    cmp byte [r12], 0
    je  strDone
    inc rdx ; dlugosc w rdx
    inc r12
    jmp strLoop
strDone:
    cmp rdx, 0 ; dlugosc = 0 (brak lancucha)
    je  prtDone
    mov rsi, rdi
    mov rax, 1
    mov rdi, 1
    syscall
prtDone:
    ret