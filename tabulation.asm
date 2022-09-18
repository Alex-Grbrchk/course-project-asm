macro tabulation        
{                       
tab:            ; метка с циклом while
fld[xa] ; загружаем в стек начальную точку
fcomp[zero] ; сравниваем ее с нулем
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
function_value  ; вызов макроса с вычислением функции     
outputting:     ; метка вывода
output          ; макрос вывода числа
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
fstp [xa]       ; xs=st0  находим следующий х  

sub [num], 1    ; вычитаем из кол-ва шагов 1
cmp [num], 0    ; сравниваем кол-во шагов с нулем, если не равно, то продолжаем
jne tab         
}                       