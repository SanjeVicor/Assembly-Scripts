name "P6-Villalobos Coronado Santiago Jesus 213552819"
org 100h
jmp start
msg1:     db "Escriba la ecuacion aritmetica : "
msg1END:
msg2:     db "Error "
msg2END:  
equation db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
digits: db "0","1","2","3","4","5","6","7","8","9"  
result dw ?
num1 dw 0
num2 dw 0
num3 dw 0
op1 db 0 
op2 db 0 
op3 db 0  
repeating db 0  
ten dw 10 

getArray proc  
        mov di,0 
        mov ax,0
    getKey:  
        mov si, 0  
        mov ah,0
        int 16h 
        
        cmp al,8
        je itsBackspace
        cmp al,13
        je endGetArrayFunction   
        
        cmp al, "+"
        je print  
        cmp al, "-"
        je print
        cmp al, "*"
        je print
        cmp al, "/"
        je print
        
        isDigit:
            cmp al, digits[si]
            je itsDig
            jmp compare
            itsDig:
                mov dx,1
                jmp print
            compare:    
                inc si   
                cmp si,9
                jg getKey
                jmp isDigit 
        print:
            mov ah, 0Eh
            int 10h
            cmp  dx,1
            je digit
            jmp takeIt   
            
            
        digit: 
             sbb al,48
        takeIt:
            mov dx,0 
            mov equation[di], al   
            inc di
            jmp getKey
                  
                  
        itsBackspace:
            cmp di,0
            jle  error
            dec di
            mov equation[di], 0  
        delete: 
            mov ah, 0Eh
            int 10h      
            mov al, 0 
            mov ah, 0Eh
            int 10h  
            mov al, 8 
            mov ah, 0Eh
            int 10h    
            jmp getKey
                       
         error:
            mov di,0   
            jmp getKey                           
endGetArrayFunction:  
    mov equation[di], al  
    ret
    getArray endp    

;**********************************************
getN1 proc
 xor bx, bx
 xor cx, cx
 xor ax, ax
 xor dx, dx
 mov si,0
 mov di,0 
 cmp equation[si],"-"
 je negative
 jmp n
 negative:
    inc si
 
 
 n:
   inc cx
   cmp  equation[si+1],"+"
   je getN  
   cmp  equation[si+1],"-"
   je getN
   cmp  equation[si+1],"/"
   je getN
   cmp  equation[si+1],"*"
   je getN  
   cmp  equation[si+1],13
   je getN
   inc si 
   jmp n
   
 getN:
    mov al, equation[si+1]
    mov op1,al 
    xor ax, ax
   cmp equation[di],"-"  
   jne followCap
   inc di
   followCap:     
      cmp cx,5
      je pos5     
      cmp cx,4
      je pos4     
      cmp cx,3
      je pos3     
      cmp cx,2
      je pos2     
      cmp cx,1
      je pos1
      
pos5:  
   mov ax,0
   mov al, equation[di]
   mov bx,10000 
   mul bx
   mov num1,ax  
   inc di 
pos4:         
   mov ax,0
   mov al, equation[di]
   mov bx,1000 
   mul bx
   add num1,ax
   inc di
pos3:  
   mov ax,0
   mov al, equation[di]
   mov bx,100 
   mul bx
   add num1,ax  
   inc di
pos2: 
   mov ax,0
   mov al, equation[di]
   mov bx,10 
   mul bx
   add num1,ax 
   inc di
pos1:     
   mov ax,0
   mov al, equation[di]
   mov bx,1 
   mul bx
   add num1,ax

cmp equation[0],"-"
je negN
jmp endgetN1

negN:
    neg num1
      
        
endgetN1:
    ret
    getN1 endp        
;******************************************************  
getN2 proc 
     
 inc si
 inc si
 xor bx, bx
 xor cx, cx
 xor ax, ax
 xor dx, dx
 mov di,si 
 
 
 n2:
   inc cx
   cmp  equation[si+1],"+"
   je getN_2  
   cmp  equation[si+1],"-"
   je getN_2
   cmp  equation[si+1],"/"
   je getN_2
   cmp  equation[si+1],"*"
   je getN_2  
   cmp  equation[si+1],13
   je getN_2
   inc si 
   jmp n2
   
 getN_2:
    mov al, equation[si+1]
    mov op2,al 
    xor ax, ax
   cmp equation[di],"-"  
   jne followCap2
   inc di
   followCap2:     
      cmp cx,5
      je pos5_2     
      cmp cx,4
      je pos4_2     
      cmp cx,3
      je pos3_2     
      cmp cx,2
      je pos2_2     
      cmp cx,1
      je pos1_2
      
pos5_2:  
   mov ax,0
   mov al, equation[di]
   mov bx,10000 
   mul bx
   mov num2,ax  
   inc di 
pos4_2:         
   mov ax,0
   mov al, equation[di]
   mov bx,1000 
   mul bx
   add num2,ax
   inc di
pos3_2:  
   mov ax,0
   mov al, equation[di]
   mov bx,100 
   mul bx
   add num2,ax  
   inc di
pos2_2: 
   mov ax,0
   mov al, equation[di]
   mov bx,10 
   mul bx
   add num2,ax 
   inc di
pos1_2:     
   mov ax,0
   mov al, equation[di]
   mov bx,1 
   mul bx
   add num2,ax


      
        
endgetN2:
    ret
    getN2 endp   
;*******************************************************
                                                         
getN3 proc 
     
 inc si
 inc si
 xor bx, bx
 xor cx, cx
 xor ax, ax
 xor dx, dx
 mov di,si 
 
 
 n3:
   inc cx
   cmp  equation[si+1],"+"
   je getN_3  
   cmp  equation[si+1],"-"
   je getN_3
   cmp  equation[si+1],"/"
   je getN_3
   cmp  equation[si+1],"*"
   je getN_3  
   cmp  equation[si+1],13
   je getN_3
   inc si 
   jmp n3
   
 getN_3:
    mov al, equation[si+1]
    mov op3,al 
    xor ax, ax
   cmp equation[di],"-"  
   jne followCap3
   inc di
   followCap3:     
      cmp cx,5
      je pos5_3     
      cmp cx,4
      je pos4_3     
      cmp cx,3
      je pos3_3     
      cmp cx,2
      je pos2_3     
      cmp cx,1
      je pos1_3
      
pos5_3:  
   mov ax,0
   mov al, equation[di]
   mov bx,10000 
   mul bx
   mov num3,ax  
   inc di 
pos4_3:         
   mov ax,0
   mov al, equation[di]
   mov bx,1000 
   mul bx
   add num3,ax
   inc di
pos3_3:  
   mov ax,0
   mov al, equation[di]
   mov bx,100 
   mul bx
   add num3,ax  
   inc di
pos2_3: 
   mov ax,0
   mov al, equation[di]
   mov bx,10 
   mul bx
   add num3,ax 
   inc di
pos1_3:     
   mov ax,0
   mov al, equation[di]
   mov bx,1 
   mul bx
   add num3,ax
            
endgetN3:
    ret
    getN3 endp
;*******************************************************   

calculateN2_N3 proc   
    cmp op2,"*"
    je mulN2N3
    cmp op2,"/"
    je divN2N3  
    
    mulN2N3:
        mov ax,num2 
        mov bx,num3
        mul bx
        jmp finCalculateN2_N3
    divN2N3: 
        mov ax,num2 
        mov bx,num3 
        div bx 
        jmp finCalculateN2_N3    
             
    finCalculateN2_N3:
        mov num2,ax
           
        ret
        calculateN2_N3 endp

;*******************************************************   

calculate proc        

 call getN1
  
 cmp op1,13
 je endCal
 call getN2 
 jmp fllw          
 
 repeat:
        mov repeating,1     
       mov al,op2
       mov op1,al
       mov ax,num2
       mov result,ax
       mov num1,ax
       mov num2,0
       call getN2 
  
 fllw:     
 cmp op2,"*"
 je getNum3
 cmp op2,"/"
 je getNum3  
 ;cmp op3,"*"
 ;je getNum3
 ;cmp op3,"/"
 ;je getNum3  

  jmp calN1_N2
  getNum3:
    call getN3 
    call calculateN2_N3
  cmp equation[si+1],"/" 
  je getNum3_1 
  cmp equation[si+1],"*" 
  je getNum3_1
  
  jmp calN1_N2
  getNum3_1:
    mov al,op3
    mov op2,al
    mov num3,0 
    jmp getNum3
    
  calN1_N2: 
    cmp op1, "*" 
    je mulF2
    cmp op1, "/" 
    je divF2  
    cmp op1, "+" 
    je addF2
    cmp op1, "-" 
    je subF2
               

addF2:
    mov ax,num1
    mov bx,num2
    add ax,bx  
    mov num2,ax
    JMP endCal
subF2:
    mov ax,num1
    mov bx,num2
    sub ax,bx  
    mov num2,ax 
    JMP endCal
mulF2:
    mov ax,num1
    mov bx,num2
    imul bx    
    mov num2,ax  
    JMP endCal
divF2:
    mov ax,num1
    mov bx,num2
    idiv bx    
    mov num2,ax  
    
    jmp endCal 
    
       
       
       
endCal:    
        cmp op2,"*"
        je change
        cmp op2,"/"
        je change
        jmp f
        change:
            mov al,op3
            mov op2,al
       f:    
       mov num3,0 
       mov al,op3
       mov op1,al 
       cmp equation[si+1],13
       jne repeat   
       mov ax, num2 
       mov result, ax
       ret
       calculate endp
;*********************************************  

PUTC    MACRO   char
        PUSH    AX
        MOV     AL, char
        MOV     AH, 0Eh
        INT     10h     
        POP     AX
ENDM

printResult proc
        PUSH    DX
        PUSH    AX

        CMP     AX, 0
        JNZ     not_zero

        PUTC    '0'
        JMP     printed

not_zero:
        CMP     AX, 0
        JNS     positive
        NEG     AX

        PUTC    '-'

positive:
        CALL    PRINT_NUM_UNS
printed:
        POP     AX
        POP     DX
        RET

finPrint:
    ret
    printResult endp

;***************************

PRINT_NUM_UNS proc
      PUSH    AX
        PUSH    BX
        PUSH    CX
        PUSH    DX

        MOV     CX, 1

        
        MOV     BX, 10000       

        
        CMP     AX, 0
        JZ      print_zero

begin_print:

        
        CMP     BX,0
        JZ      finUnNum

        
        CMP     CX, 0
        JE      calc
        
        CMP     AX, BX
        JB      skip
calc:
        MOV     CX, 0   

        MOV     DX, 0
        DIV     BX      

        ADD     AL, 30h    
        PUTC    AL


        MOV     AX, DX  

skip:
        PUSH    AX
        MOV     DX, 0
        MOV     AX, BX
        DIV     CS:ten 
        MOV     BX, AX
        POP     AX

        JMP     begin_print
        
print_zero:
        PUTC    '0'

finUnNum: 

        POP     DX
        POP     CX
        POP     BX
        POP     AX
    ret
    PRINT_NUM_UNS endp

;********************************************
start: 
 xor bx, bx
 xor cx, cx
 xor ax, ax
 xor dx, dx
  
 mov al, 1 
 mov bh, 0
 mov bl, 1111b
 mov cx, msg1END - offset msg1
 mov dl, 1
 mov dh, 1
 mov bp, offset msg1
 mov ah, 13h
 int 10h
 
 call getArray 
 
 call calculate

    
  mov dh, 9
  mov dl, 1
  mov bh, 0
  mov ah,02h
  int 10h  
  PUTC "="
  mov ax, result
  call printResult  
 end:
    mov ax,0
    int 20h  

ret


