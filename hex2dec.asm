name "p5    -   Villalobos Coronado Santiago Jesus "
include 'emu8086.inc'

org 0100h  

ini:    

        xor ax,ax
        lea     di,cadnum  ;cargar la direccion del primer caracter
        lea     si,n32     ;cargar la direccion del primer caracter
        mov     dx,9       ;longitud de la variable cadnum
        call    get_string  
        
        
        ;Medir la longitud del numero hexadecimal introducido por teclado
        xor bx,bx
        loop1:
            cmp cadnum[bx],0
            je last
            inc bx
            jmp loop1
            
        last:  
        
        ;la variable len es la longitud del numero asi podemos hacer usi de ella en comparaciones futuras
        mov len, bl       
        mov al,[di] ;obtiene el valor ascii del primer elemento en el arreglo cadnum  
        
        cmp len,4  ;nuestro numero tiene la longitud 0000
        je  four  
        
        cmp len,3  ;nuestro numero tiene la longitud 000
        je  three 
        
        cmp len,2  ;nuestro numero tiene la longitud 00
        je  two  
        
        cmp len,1  ;nuestro numero tiene la longitud 0
        je  one               
         
        
                  
        four:
            call    numbyte1
            call adding
            
            mov     al,[b]     ;se recupera el valor binario
          ;se incrementan los arreglos
            inc     si    
            inc     di
            mov     al,[di]  ; al toma el valor ascii del arreglo
        
        three:
            
            f0:
            call    numbyte2   
            
            cmp len, 3
            call adding
            
            mov     al,[b]
            inc     si
            inc     di
            mov     al,[di] 
        
        two: 
            
            f1:
            call    numbyte3 
            
            cmp len, 2 
            call adding  
            
            
            mov     al,[b]   
            inc     si
            inc     di
            mov     al,[di] 
        
        one: 
               
            f2:
            call    numbyte4  
            
            cmp len, 1  
            call adding 
            
            mov     al,[b]    
            
            ;se carga la posicion inicial de la variable n32
            lea     di,n32
        
        
        
         ;MOVER CURSOR
        mov dh,3
        mov dl,0
        mov bh,0
        mov ah,2
        int 10h
        
        
         ;IMPRIMIR NUMERO
        MOV AX, n32  
       CALL  PRINT_NUM_UNS  
        
       MOV AH, 0
       int 20h
        
        ret
  
  
        
adding:   
      add n32,ax       ;se suma el resultado a la variable final
      ;add     al,[b]
      mov     [b],al  ;verificar la parte baja del registro
      ret        
  
 
        
numbyte1: ;*000
        call    asc2num
        mov     bx,4096
        mul     bx     ;al multiplicar con este numero se mueve en el registro el numero a su posicion original introducida
        mov     [b],ah  ;se ingresa el valor en la variable b
        ret              
        
numbyte2: ;0*00
        call    asc2num
        mov     bx,256
        mul     bx  
        mov     [b],ah
        ret  
        
        
numbyte3: ;00*0
        call    asc2num
        mov     bl,16
        mul     bl     
        mov     [b],al  
        ret                  


numbyte4:  ;000*
        call    asc2num
        mov     bl,1
        mul     bl 
        mov     [b],al 
        ret  
  
  
        
asc2num:
        sub     al,48 ;se resta para convertir el valor en al en el valor original del numero introducido
        cmp     al,9
        jle     f_asc  ;si es menor o igual a 9 se puede finalizar la funcion, rango 0-9
        sub     al,7   ;se restan 7 al valor restante
        cmp     al,15
        jle     f_asc  ;si es menor o igual a 15 se finaliza, rango: A-F
        sub     al,32  ;es otro caracter ascii
f_asc:  ret 




cadnum  db      "000000000"
n32     dw      0,0,0,0
b       db      0
len     db      0

  
  
DEFINE_GET_STRING 
DEFINE_PRINT_NUM_UNS   
END        
        