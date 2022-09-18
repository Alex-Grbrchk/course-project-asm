macro steps          
{                       
fld [xb]        ; st0 = xe
fld [xa]        ; st0 = xs, st1 = xe
fsubp st1, st0  ; st0 = st1 = st1 - st0 = xe - xs
fld [xd]        ; st0 = xd, st1 = xe - xs
fdivp st1, st0  ; st0 = st1 = st1/st0 = (xe - xs)/xd
fstp [num]      ; num = st0
cmp [num], 0    ; ���������� ���-�� ����� � 0
fld [num]       ; st0 = num
fld1            ; st0 = 1, st1 = num
fld st1         ; st0 = num, st = 1, st2 = num
fprem           ; st0 = st0 - Q * st1, Q = st0/st1, st1 = 1, st2 = num
fsub st2, st0   ; st0 = ������� ����� num, st1 = 1, st2 = num, st2 = st2 - st0
fxch st2        ; st0 = ����� ����� num, st1 = 1, st2 = ������� ����� num
fistp [num]   ; st0 = 1, st2 = ������� ����� num
fstp st0        ; st0 = ������� ����� num
fstp st0        ; st0 = -
add [num], 1   ; � ���� ������� ���������� ������� ���-�� �����, ������ �� ����� ����, ��������� � �������� �����
}                       