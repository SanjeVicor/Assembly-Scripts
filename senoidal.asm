org 100h
 jmp start  
 
 array1 db 127d ,143d ,159d ,174d ,188d ,202d ,214d ,225d ,234d ,242d ,248d ,252d ,254d ,254d ,252d ,248d ,242d ,234d ,225d ,214d ,202d ,188d ,174d ,159d ,143d ,127d ,111d ,95d ,80d ,66d ,52d ,40d ,29d ,20d ,12d ,6d ,2d ,0d ,0d ,2d ,6d ,12d ,20d ,29d ,40d ,52d ,66d ,80d ,95d ,111d ,127d ,143d ,159d ,174d ,188d ,202d ,214d ,225d ,234d ,242d ,248d ,252d ,254d ,254d ,252d ,248d ,242d ,234d ,225d ,214d ,202d ,188d ,174d ,159d ,143d ,127d ,111d ,95d ,80d ,66d ,52d ,40d ,29d ,20d ,12d ,6d ,2d ,0d ,0d ,2d ,6d ,12d ,20d ,29d ,40d ,52d ,66d ,80d ,95d ,111d 
 num dw 100d
 ciclo db ?
increment proc
   mov bx, 0
   mov dl,135
   
   looping:
   
    mov dl, array1[bx]
    mov al, 1110b
    mov ah, 0ch 
    int 10h ;set pixel 
    
    cmp cx, num
    jz fin 

    inc cx  
    inc bx 
     
    jmp looping 
    
fin:   
    increment endp
    ret

 
 
start:
mov cx,1  
mov bx,06h
mov dx,1


mov al, 13h
mov ah, 0
int 10h ; set graphics video mode.
            
mov cx,0  
dec ciclo
senoidal:
    call increment 
    add num, 100d 
    cmp ciclo,0
    jz final    
    dec ciclo
    jmp senoidal   
    
final:
    ret