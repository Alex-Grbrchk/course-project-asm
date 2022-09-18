macro output            
{                       
local ex6, ex7, ex8,ex9,exx          ; ���������� ��������� �����

fld [y]         
ftst            
fstsw ax        
sahf           
jnc ex6 ; ������� � ����� ex6, ���� ����� ��������� �������

fld [y] 
fcom[min]                   
fstsw ax        
sahf           
jbe overflow ; ���� ����� ������ ��� -32000, �� ������� � ����� overflow

fld [y]
fcomp[max]                   
fstsw ax        
sahf           
jae overflow ; ���� ����� ������ ��� 32000, �� ������� � ����� overflow

mov byte ptr STRING, '-'         ; 

mov ah, 40h     ; ������ ������� � ����        
mov bx, [descript]         
mov dx, STRING          
mov cx, 1               
int 21h              

fchs            ; ����� ����� �� ���������������
ex6:            ; ��������� �����, � ������� ���� ��������� ����� ����� 
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
   
ex7:            ; ���������� ����� do-while, �� ����� ����� ���������� ��������� ����� � ��������� � ����


xor dx, dx      
div bx          
push dx         
inc cx          
test ax, ax     
jnz ex7         ; ������� � ����� ex7, ���� ����� ����� �� �����������

ex8:            ; ���������� ����� do-while, ���� ����� ����� ����� � ����

mov [temp], cx  

pop dx          
add dl, '0'     
mov byte ptr STRING, dl       

mov ah, 40h     ; ������ ������� � ����       
mov bx, [descript]         
mov dx, STRING          
mov cx, 1               
int 21h             

mov cx, [temp]  

loop ex8        ; ���������� �x �� �������, � ���� cx!=0, �� ������� � ex8


fxch st1        
ftst            
fstsw ax        
sahf            
jz ex9          ; ���� ��� ������� �����, �� ������� � ex9


mov byte ptr STRING, '.'       

mov ah, 40h       ; ������ ������� � ����       
mov bx, [descript]         
mov dx, STRING          
mov cx, 1               
int 21h            

mov [temp], 0   

exx:            ; ����� ������� ����� � ����

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

mov ah, 40h      ; ������ ������� � ����       
mov bx, [descript]         
mov dx, STRING          
mov cx, 1               
int 21h           

inc [temp]    

fxch st1       
ftst            
fstsw ax        
sahf            
jne exx         ; ���� �������� ������� �����, ��������� � ����� exx

ex9:            ; ������� ���� ������������

fstp st0        
fstp st0        

transition      ; ������� �� ����� ������ � �����
}                       