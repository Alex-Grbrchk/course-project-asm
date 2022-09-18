macro output            
{                       
local ex6, ex7, ex8,ex9,exx          ; Объявление локальных меток

fld [y]         
ftst            
fstsw ax        
sahf           
jnc ex6 ; Переход к метке ex6, если число оказалось дробным

fld [y] 
fcom[min]                   
fstsw ax        
sahf           
jbe overflow ; Если число меньше чем -32000, то переход к метке overflow

fld [y]
fcomp[max]                   
fstsw ax        
sahf           
jae overflow ; Если число больше чем 32000, то переход к метке overflow

mov byte ptr STRING, '-'         ; 

mov ah, 40h     ; запись символа в файл        
mov bx, [descript]         
mov dx, STRING          
mov cx, 1               
int 21h              

fchs            ; Смена знака на противоположный
ex6:            ; Локальная метка, в которой идет выделение целой части 
fld [y]
fcomp[min]                   
fstsw ax        
sahf           
jbe overflow 

fld [y]
fcomp[max]                   
fstsw ax        
sahf           
jae overflow  

fld1            
fld st1         
fprem           
fsub st2, st0    
fxch st2        
fistp [sim]     

mov bx, [ten]   

mov ax, [sim]
xor cx, cx  
   
ex7:            ; Реализация цикла do-while, от целой части выделяется последняя цифра и заносится в стек


xor dx, dx      
div bx          
push dx         
inc cx          
test ax, ax     
jnz ex7         ; Возврат к метке ex7, если целая часть не закончилась

ex8:            ; Реализация цикла do-while, ввод целой части числа в файл

mov [temp], cx  

pop dx          
add dl, '0'     
mov byte ptr STRING, dl       

mov ah, 40h     ; запись символа в файл       
mov bx, [descript]         
mov dx, STRING          
mov cx, 1               
int 21h             

mov cx, [temp]  

loop ex8        ; Уменьшение сx на единицу, и если cx!=0, то возврат к ex8


fxch st1        
ftst            
fstsw ax        
sahf            
jz ex9          ; Если нет дробной части, то переход к ex9


mov byte ptr STRING, '.'       

mov ah, 40h       ; запись символа в файл       
mov bx, [descript]         
mov dx, STRING          
mov cx, 1               
int 21h            

mov [temp], 0   

exx:            ; Вывод дробной части в файл

cmp [temp], 8   
jz ex9          

fild [ten]       
fmulp st1, st0   
fxch st1        
fld st1         
fprem           
fsub st2, st0   
fxch st2        
fistp [sim]      

mov dx, [sim]   
add dl, '0'     
mov byte ptr STRING, dl     

mov ah, 40h      ; запись символа в файл       
mov bx, [descript]         
mov dx, STRING          
mov cx, 1               
int 21h           

inc [temp]    

fxch st1       
ftst            
fstsw ax        
sahf            
jne exx         ; Если осталась дробная часть, переходим к метке exx

ex9:            ; Очищаем стек сопроцессора

fstp st0        
fstp st0        

transition      ; Переход на новую строку в файле
}                       