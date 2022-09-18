macro tabulation        
{                       
tab:            ; ����� � ������ while
fld[xa] ; ��������� � ���� ��������� �����
fcomp[zero] ; ���������� �� � �����
fstsw ax
sahf

jne succ

mov ah, 40h
mov bx, [descript]
mov dx, INF
mov cx, 3
int 21h

transition 

jmp fail

succ:
function_value  ; ����� ������� � ����������� �������     
outputting:     ; ����� ������
output          ; ������ ������ �����
jmp fail

overflow: 
mov ah, 40h
mov bx, [descript]
mov dx, OVER
mov cx, 3
int 21h

transition 
  
fail:

fld [xa]        ; st0 = xs 
fld [xd]        ; st0 = xd, st1 = xs
faddp st1, st0  ; st1 = st1 + st0 = xs + xd, st0 = st1, st1 = -
fstp [xa]       ; xs=st0  ������� ��������� �  

sub [num], 1    ; �������� �� ���-�� ����� 1
cmp [num], 0    ; ���������� ���-�� ����� � �����, ���� �� �����, �� ����������
jne tab         
}                       