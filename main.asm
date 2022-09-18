format mz      

entry code_seg:start
include 'allMacros.asm'
include_macro      ; ����������� �������� �� ����� AllMarcos.asm     
finit           ; ������������� ��������������� ������������

segment data_seg

        xa dq 0.0       ; ��������� ��������� �����
        xb dq 0.0
        xd dq 0.0
        y dt 0.0

        START db 'Enter a: $'         ; ���� ��������� �����
        FINISH db 'Enter b: $'          ; ���� �������� �����
        STEP db 'Enter dx: $'         ; ���� ����

        INF db 'Inf$'

        OVER db 'NaN $'

        FUNCTION db 'x^2*sqrt(ln(x/2)) $'         ; ����������� �������

        FILENAME db 'result.txt',0        ; ����� �����

        PROBEL db 0dh, 0ah, 0        ; ������ �������� �� ����� ������

        STRING db 12,14 dup(?)          ; ���� � ����� ������

        ten dw 10       ; ��������� �����
        two dw 2
        one dw 1
        zero dd 0
        max dq 32768.0
        min dq -32768.0

        sim dw 0
        num dd 0 ; ���������� ����� �������������
        descript dw 0
        temp dw 0

segment code_seg
start:          
        mov ax, data_seg ;������������� �������� DS
        mov ds, ax

        input xa, START
        input xb, FINISH
        input xd, STEP

        steps

        jump

        mov ah, 41h ;�������� �����
        mov dx, FILENAME
        int 21h

        mov ah, 3ch   ;������� ����
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
