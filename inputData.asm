macro input x, BUFFER           
{                               

        local ex, ex0, ex1, ex2, ex3, ex4, ex5, ending, negative, end0          ; Метки

        jump                    ; Переход на новую строку в консоли

        mov dx, BUFFER          
        mov ah, 9               
        int 21h                 

        mov ah, 0ah             
        mov dx, STRING          
        int 21h                 

        mov si, STRING+2       
        cmp byte ptr si,'-'     
        jne ex                  
        mov di, 1              
        inc si                  ; Переход к следующему символу

        ex:                     

        fild [ten]              
        fldz                    

        ex0:                    ; Перевод целой части в число

        mov dl, [si]            
        cmp dl, 0dh             
        je ending               ; Переход к этой метке, если число не имеет дробной части


        cmp dl, '.'             
        je ex1                  ; Переход к ex1, если символ - точка

        cmp dl, ','             
        je ex1                  ; Переход к ex1, если символ - запятая

        cmp dl, '0'             

        cmp dl, '9'             

        sub dl, '0'             
        mov byte ptr sim, dl    
        fiadd [sim]             
        fmul st0, st1           

        inc si                  ; Переход к следующему символу

        jmp ex0                 ; Переход к ex0

        ex1:                    ; Делим число на 10, т.к после ex0 число в 10 раз больше, чем изначальное

        inc si                  
        fdiv st0, st1           
        fxch st1                

        ex2:                    

        mov dl, [si]            
        cmp dl, 0dh             
        je ex3                  ; Переход к ex3, если символ равен символу конца строки

        inc si                 

        jmp ex2                 

        ex3:                    ; Переход к следующему символу 


        dec si                  
        fldz                    

        ex4:                    ; Перевод дробной части в число


        mov dl, [si]           
        cmp dl, '.'             
        je ex5                  ; Если символ точка, то переход к ex5

        cmp dl, ','             
        je ex5                  ; Если символ запятая, то переход к ex5

        cmp dl, '0'             

        cmp dl, '9'             

        sub dl, '0'             
        mov byte ptr sim, dl    
        fiadd [sim]             
        fdiv st0, st1           

        dec si                  

        jmp ex4                 

        ex5:                    ; Формирование изначального числа с дробной и целой частью


        fxch st1                
        fxch st2                
        faddp st1, st0          
        fxch st1                
        fstp st0                
        jmp negative            ; Переходим к метке negative

        ending:                 ; Метка, если число имеет только целую часть

        fdiv st0, st1           
        fxch st1                
        fstp st0                

        negative:               ; Проверка на отрицательное

        cmp di, 1               
        jne end0                ; Если неотрицательное, то метка end0
        fchs                    ; Если отрицательное, то делаем его отрицательным

        end0:                   ; 

        fstp [x]                

        mov di, 0               

}                               