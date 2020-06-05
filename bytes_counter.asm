name "P7"

org 100h
jmp start

createFile proc 
	mov ah, 3ch
	mov cx, 0
	mov dx, offset fin
	mov ah, 3ch
	int 21h
endCreate:
    ret
    createFile endp

TOSTRING macro num   
    push si
    push di   
    mov si,0 
    mov ax,num 
    mov bx,10000
    
        mov cx,0
        mov dx,0
        div bx  
        add al,48
        mov linesCount[si],al   
        inc si
        
    mov bx,1000
        mov ax,dx
        mov cx,0
        mov dx,0
        div bx 
        add al,48
        mov linesCount[si],al   
        inc si
        
        
    mov bx,100
        mov ax,dx
    
        mov cx,0
        mov dx,0
        div bx 
        add al,48
        mov linesCount[si],al   
        inc si
        
        
    mov bx,10
        mov ax,dx
    
        mov cx,0
        mov dx,0
        div bx  
        add al,48
        mov linesCount[si],al 
        inc si
        
        
    mov bx,1 
        mov ax,dx
    
        mov cx,0
        mov dx,0
        div bx 
        add al,48
        mov linesCount[si],al   
        inc si
        
    LOCAL final:             
        POP DI
        POP SI
        endm



PRINT macro text
    mov ah,9
    mov dx, offset text
    int 21h
  endm


MAKECOPY macro text  
    
    mov al,1
    mov dx, offset fin 
	mov ah, 3dh
	int 21h 
	jc error1_1
    mov handler2, ax 
        
     
    COPYFILE: 
        mov cx, lastCount 
        mov si,0
        mov di,0
        putCount:           
            mov ax,count
            add ax,lastCount
            mov lastCount,ax
            TOSTRING ax  
            mov bx,0
            copyCount:
                mov al,linesCount[bx]  
                mov linesCount[bx] ,0
                mov aux[di],ax 
                inc di 
                inc bx
                cmp bx,5
                jl copyCount
            mov count,0 
            mov ax,0
            inc di
        counting:
                cmp text[si],'$'
                je ENDCOPY
                inc count 
                mov al, text[si]
                mov aux[di],ax
                inc si
                inc di  
                cmp text[si-1],0ah 
                je putCount
                jmp counting
  
          
           
error2_1:
    PRINT error2MSG
error1_1:
    PRINT error1MSG             
ENDCOPY:       
    inc di
    mov aux[di],0DH
    inc di
    mov aux[di],0AH 
    inc di     
    ADD COUNT,2        
                          
            mov ax,count
            add ax,lastCount
            mov lastCount,ax
            TOSTRING ax  
            mov bx,0
            copyCount1:
                mov al,linesCount[bx]  
                mov linesCount[bx] ,0
                mov aux[di],ax
                inc di 
                inc bx
                cmp bx,5
                jl copyCount1
                  
   mov cx,0               
   cp:               
    mov ax,aux[di]
    mov data[di] ,ax 
    inc cx
    dec di
    cmp di,0
    jge cp
             
    mov bx, handler2
	mov dx, offset data
	;mov cx, data_size 
	mov ah, 40h
	int 21h
         
	mov al, 1
	mov bx, handler2
	mov cx, 0
	mov dx, 7
	mov ah, 42h
	int 21h
	
    mov ah,3eh  
    mov bx, handler2
    int 21h   
    endm


readFile proc
    mov al,0
    mov dx, offset fout 
	mov ah, 3dh
	int 21h 
	jc error1
    mov handler, ax 
    
    READING:
                
        mov ah, 3fh 
        MOV BX, handler
        mov dx,offset buffer 
        mov cx, 1023
        int 21h 
        jc error2
        cmp ax,0 ;END OF FILE     
        jz endRead  
        PRINT buffer
        
        MAKECOPY buffer
          
     CLEANBUFFER:  
        MOV SI,offset clean
        mov di,offset buffer
        mov cx,10 
        rep movsb
        jmp READING 
error2:
    PRINT error2MSG
error1:
    PRINT error1MSG  
endRead:   
    mov ah,3eh  
    mov bx, handler
    int 21h     
    
    ret
    readFile endp


 
start:  
  call createFile
  call readFile
ret

fout db "C:\original.txt",0
fin db "C:\copia.txt",0
handler dw ? 
handler2 dw ?
buffer db 1024 DUP('$')  
aux dw 1024 DUP(254)  
linesCount db 1024 DUP('$')    
clean  db 1024 DUP('$') 
error1MSG db 10,13,'ERROR DE APERTURA DE ARCHIVO... $'  
error2MSG db 10,13,'ERROR DE LECTURA DE ARCHIVO... $'
count dw 0 
lastCount dw 0

data dw 1024 DUP('$')
data_size db 0