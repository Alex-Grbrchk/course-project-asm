format mz      

entry code_seg:start
include 'allMacros.asm'
include_macro      ; подключение макросов из файла AllMarcos.asm     
finit           ; инициализация арифметического сопроцессора

segment data_seg

        xa dq 0.0       ; константы введенных точек
        xb dq 0.0
        xd dq 0.0
        y dt 0.0

        START db 'Enter a: $'         ; Ввод начальной точки
        FINISH db 'Enter b: $'          ; Ввод конечной точки
        STEP db 'Enter dx: $'         ; Ввод шага

        INF db 'Inf$'

        OVER db 'NaN $'

        FUNCTION db 'x^2*sqrt(ln(x/2)) $'         ; Вычисляемая функция

        FILENAME db 'result.txt',0        ; Адрес файла

        PROBEL db 0dh, 0ah, 0        ; Символ перехода на новую строку

        STRING db 12,14 dup(?)          ; Ввод и вывод данных

        ten dw 10       ; константы чисел
        two dw 2
        one dw 1
        zero dd 0
        max dq 32768.0
        min dq -32768.0

        sim dw 0
        num dd 0 ; количество шагов табулирования
        descript dw 0
        temp dw 0

segment code_seg
start:          
        mov ax, data_seg ;Инициализация регистра DS
        mov ds, ax

        input xa, START
        input xb, FINISH
        input xd, STEP

        steps

        jump

        mov ah, 41h ;удаление файла
        mov dx, FILENAME
        int 21h

        mov ah, 3ch   ;создать файл
        mov dx, FILENAME
        mov cx, 1
        int 21h

        mov [descript], ax

        mov ah, 42h
        mov bx, [descript]
        xor dx, dx
        xor cx, cx
        int 21h

        mov ah, 40h
        mov bx, [descript]
        mov dx, FUNCTION
        mov cx, 16
        int 21h

        transition

        tabulation

        mov ah, 3eh
        mov bx, [descript]
        int 21h
               
        mov ax, 4C00h
        int 21h
