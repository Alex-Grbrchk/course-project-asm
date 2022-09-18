macro input x, BUFFER           
{                               

        local ex, ex0, ex1, ex2, ex3, ex4, ex5, ending, negative, end0          ; �����

        jump                    ; ������� �� ����� ������ � �������

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
        inc si                  ; ������� � ���������� �������

        ex:                     

        fild [ten]              
        fldz                    

        ex0:                    ; ������� ����� ����� � �����

        mov dl, [si]            
        cmp dl, 0dh             
        je ending               ; ������� � ���� �����, ���� ����� �� ����� ������� �����


        cmp dl, '.'             
        je ex1                  ; ������� � ex1, ���� ������ - �����

        cmp dl, ','             
        je ex1                  ; ������� � ex1, ���� ������ - �������

        cmp dl, '0'             

        cmp dl, '9'             

        sub dl, '0'             
        mov byte ptr sim, dl    
        fiadd [sim]             
        fmul st0, st1           

        inc si                  ; ������� � ���������� �������

        jmp ex0                 ; ������� � ex0

        ex1:                    ; ����� ����� �� 10, �.� ����� ex0 ����� � 10 ��� ������, ��� �����������

        inc si                  
        fdiv st0, st1           
        fxch st1                

        ex2:                    

        mov dl, [si]            
        cmp dl, 0dh             
        je ex3                  ; ������� � ex3, ���� ������ ����� ������� ����� ������

        inc si                 

        jmp ex2                 

        ex3:                    ; ������� � ���������� ������� 


        dec si                  
        fldz                    

        ex4:                    ; ������� ������� ����� � �����


        mov dl, [si]           
        cmp dl, '.'             
        je ex5                  ; ���� ������ �����, �� ������� � ex5

        cmp dl, ','             
        je ex5                  ; ���� ������ �������, �� ������� � ex5

        cmp dl, '0'             

        cmp dl, '9'             

        sub dl, '0'             
        mov byte ptr sim, dl    
        fiadd [sim]             
        fdiv st0, st1           

        dec si                  

        jmp ex4                 

        ex5:                    ; ������������ ������������ ����� � ������� � ����� ������


        fxch st1                
        fxch st2                
        faddp st1, st0          
        fxch st1                
        fstp st0                
        jmp negative            ; ��������� � ����� negative

        ending:                 ; �����, ���� ����� ����� ������ ����� �����

        fdiv st0, st1           
        fxch st1                
        fstp st0                

        negative:               ; �������� �� �������������

        cmp di, 1               
        jne end0                ; ���� ���������������, �� ����� end0
        fchs                    ; ���� �������������, �� ������ ��� �������������

        end0:                   ; 

        fstp [x]                

        mov di, 0               

}                               