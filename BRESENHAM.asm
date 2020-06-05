
org 100h
 mov ax,X2
 mov bx,X1
 sbb ax,bx 
 clc
 mov d_X, ax
 mov ax,Y2
 mov bx,Y1
 sbb ax,bx  
 clc
 mov d_Y, ax
 
 cmp d_Y,0
 jl Sino1
    mov incYi,1 
    jmp nxt 
 Sino1:
      neg d_Y  
      mov incYi,-1   
 nxt:     
 cmp d_X,0
 jl Sino2  
    mov incXi,1 
    jmp nxt1
 Sino2:
      neg d_X  
      mov incXi,-1 
 
 
 nxt1:  
    mov ax,d_X
    cmp ax,d_Y
    jl Sino3
      mov incYr,0 
      mov ax,incXi
      mov incXr,ax
      jmp nxt2
    Sino3:
      mov incXr,0 
      mov ax,incYi
      mov incYr,ax  
        
 nxt2: 
   mov ax,X1
   mov X,AX
   MOV AX,Y1
   MOV Y,AX
   mov ax, 0 
   mov bx, 0 
   
   mov ax,d_Y
   mov bx,2
   mul bx
   mov avr,ax
   
   mov bx,d_X
   sbb ax,bx
   mov av,ax
   
   sbb ax,bx
   mov avi,ax
         
         
         
	mov al, 13h  ;video mode
	mov ah, 0
	int 10h
   nxt3:
       mov al,1100b    ;set pixel
       mov cx,Y
       mov dx,X 
       mov ah,0ch
       int 10h
       
       
       cmp av,0
       jl nxt4
           mov ax,X
           mov bx,incXi
           add ax,bx
           mov X,ax
           
           
           mov ax,Y
           mov bx,incYi
           add ax,bx
           mov Y,ax
           
           
           
           mov ax,av
           mov bx,avi
           add ax,bx
           mov av,ax  
           
           jmp repetir
       nxt4:
            
           mov ax,X
           mov bx,incXr
           add ax,bx
           mov X,ax
           
           
           mov ax,Y
           mov bx,incYr
           add ax,bx
           mov Y,ax
           
           
           
           mov ax,av
           mov bx,avr
           add ax,bx
           mov av,ax
        repetir:   
           mov ax,X
           mov bx,2
           mul bx
           
           cmp X,ax
           jne nxt3
ret

X dw 0
Y dw 0
X1 dw 2
Y1 dw 0
X2 dw 5
Y2 dw 10
d_Y dw 0
d_X dw 0  
incYi dw 0
incXi dw 0
incYr dw 0
incXr dw 0 
avr dw 0
av dw 0
avi dw 0