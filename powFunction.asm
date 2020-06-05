name "Practica 4 - Villalobos Coronado Santiago Jesus - D05"

org 100h
 jmp start
 num1 db ? ; numero
 num2 dw ? ; potencia
 num3 dw 0h  ; resultado

 

powFunction proc
    
    loop1:          ;inicio de loop
        mov bl,num1 ;mover el valor a elevar
        mul bx      ;ax=ax*bx
        mov num3,ax ;guardar resultado
    loop loop1      ;cx--
     
endFunction:
                 
    mov ax,num3     ;guardar resultado
    powFunction endp  ;final del proceso o funcion  
    ret                ;fin del programa
                    




uno proc
    mov num3,ax   ;ya que la potencia es uno, movemos el valor por default
    uno  endp
    ret
 
  
  
 
 
cero proc
    cmp num1,0  ;si el numero a elevar es 0:
    je zero    ; ir a etiqueta zero   
    

        
    mov num3,1  ;si no el valor por default es 1
    mov ax,num3 ; mover al registro ax el valor  
    jmp  endCeroFunc
     
    zero:
        mov num3,0   ;resultado igual a 0
        mov ax,num3   
        
endCeroFunc:  
    cero endp  
    ret
       
     
     

start:
       mov al, num1 ;numero base
          
       cmp num2,0 ; comparar potencia con 0
       je num2EQUALzero
       
       cmp num2,1 ;Comparar potencia con 1
       je  num2EQUALone
       
       jmp num2Different   
       
num2EQUALzero:
   call cero    ; Si num2=0 entonces, llamar a subrutina cero  
   jmp finish
    
num2EQUALone: 
    call uno     ; Si num2=1 entonces, llamar a subrutina uno  
    jmp finish
    
num2Different:    
       dec num2   ;Si no se cumplieron las condiciones anteriores, enctonces decrementamos la potencia para el ciclo loop
       mov cx, num2  ;movemos la potencia al contador
       call powFunction  ;llamamos a la subrutina    
           
finish:                        
ret  
