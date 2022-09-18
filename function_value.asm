macro function_value
{                       
fld [xa]  	; st0 = x 
fild [two]	; st0 = 2, st1 = x
fdivp st1, st0	; st0 = x/2
fld1            ; st0=1, st1=x/2
fld st1         ; st0=x/2, st1=1
fyl2x           ; st0=st1*ln(st1)=1*ln(x/2), 
fldln2          ; st0=ln2, st1 = 1*ln(x/2)
fmulp           ; st0=ln(x/2), st1 = - 
fsqrt           ; st0=sqrt(ln(x/2))
fld [xa]	; st0 = x, st1 = sqrt(ln(x/2))
fld [xa]	; st0 = x, st1 = x, st2 = sqrt(ln(x/2))
fmulp		; st0 = x^2, st1 = sqrt(ln(x/2))
fmulp		; st0 = x^2*sqrt(ln(x/2))
fstp [y]        ; y = st0 = x^2*sqrt(ln(x/2))
jmp outputting
}                     