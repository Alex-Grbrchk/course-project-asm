macro transition        
{                       
mov ah, 40h             
mov bx, [descript]         
mov dx, PROBEL          
mov cx, 2               
int 21h                 
}                      