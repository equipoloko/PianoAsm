model small
.386

.stack 
;--------------------------inicializacion de pila----------------------------

  org	100h

.data 
;-------------------------declaracion de variables---------------------------

  negro equ 0
  azul  equ 1
  verde equ 2
  cian  equ 3
  rojo  equ 4
  magenta equ 5
  cafe equ 6
  gris2 equ 7
  gris1 equ 8
  azul2 equ 9
  verde2 equ 10
  cian2 equ 11
  rojo2 equ 12
  magenta2 equ 13
  amarillo equ 14
  blanco equ 15

  mensag1 db 'iniciar modo grafico',13,10,'$'   
  mensag2 db 'regresando de modo grafico',13,10,'$'     
  enter1  db  13,10,'$'
 

  mensagx db 'datos'
  xi dw 1
  yi dw 1
  color db 0

.code
.startup
;----------------------------inicio de programa------------------------------

inicio:	
  mov ax,@data
  mov ds,ax		;obtenemos la direccion del segmento de datos

  mov ax, 0
  mov cx, 120
  mov al, cl
  mov cl, 80
  div cl
  mov cx, ax
  inc cx
  ;cuerpo principal

modo_texto1:
  call clrscr ;limpia la pantalla
   
  lea dx, mensag1 
  call viewmsg ;despliega cadena indexada por dx

  call espera ; espera una tecla (captura tecla en al sin eco)

  call mgrafico ; inicia modo grafico 640x480x16
modo_grafico:
  
;fondo de pantalla
mov bl,cian
call fondopantalla

; cargar datos del piano
  ;------------------------------------------------------------------------
  ;imprime una linea con ayuda de la ecuacion parametrica de la linea
  call doo
  call do2
  call re
  call re2
  call mi
  call fa
  call fa2
  call sol
  call sol2
  call la
  call la2
  call sii

  ;inicializamos el mouse y lo mostramos
  call MOUSE_INIT
  call MOUSE_SHOW
  call lim_hor
  call lim_vert

  ;ciclo infinito para saber que cliqueo
  cicloinfinito:

  	   ;preguntamos por el estado del MOUSE
  	   call MOUSE_STATUS
  	   ;bx = 1 => boton izq presionado

  	   cmp bx, 1
  	   je clic
  	   cmp bx, 2
  	   je fin
  	   jne cicloinfinito

  	   clic:
  	   call revisador


  jmp cicloinfinito

  call esperag; espera tecla modo grafico
;---------------------------------------------------------------
  call mtexto
modo_texto2:
  lea dx, mensag2
  call viewmsg

  call espera 
  fin:
  mov ax,4c00h    ;realizamos la salida al dos
  int 21h 
  
;-------------------------------fin de programa------------------------------

;PROCEDURES NUESTRAS
revisador proc NEAR
  ;Cx=x
  ;Dx=y 
  
  mov ax, 0
  mov al, cl
  mov cl, 80
  div cl
  mov cx, ax
  inc cx

  cmp cl, 1
  je si1
  jne no1
  si1:
    mov bl, ROJO
    call fondopantalla
  no1:

  cmp cl, 2
  je si2
  jne no2
  si2:
    mov bl, AZUL
    call fondopantalla
  no2:

ret
revisador ENDP

lim_hor proc NEAR
  mov ax, 07h
  mov cx, 40;min
  mov dx, 600;max
  int 33h
ret
lim_hor endp

lim_vert proc NEAR
  mov ax, 08h
  mov cx, 50;min
  mov dx, 250;max
  int 33h
ret
lim_vert endp


;PROCEDURES DE LA MAESTRA
clrscr proc near ;limpia la pantalla
  mov ah,00h 
  mov al,03h
  int 10h
 ret
clrscr endp

viewmsg proc near ;despliega cadena indexada por dx
 mov ah,09h
 int 21h
 ret
viewmsg endp

espera proc near ; espera una tecla (captura tecla en al sin eco)
  mov ah,08h 
  int 21h
  ret
espera endp

mgrafico proc near ; inicia modo grafico 640x480x16
  mov ah, 0
  mov al, 12h
  int 10h
 ret
mgrafico endp

fondopantalla proc near
  mov ah,0bh;peticion
  mov bh,00h
  int 10h
fondopantalla endp

esperag proc near ; espera una tecla en modo grafico
  mov ah,10h 
  int 16h
  ret
esperag endp

mtexto proc near ; inicia modo texto con colores
  mov ah, 0
  mov al, 03h
  int 10h
 ret
mtexto endp

; PROCEDURES PARA EL USO DEL MOUSE ============

MOUSE_INIT PROC NEAR ; inicializa mouse, Regresa Ax=0 si hay error, Ax=FFFF si ok, BX=N botones
  MOV AX,0
  INT 33H
RET 
MOUSE_INIT ENDP

MOUSE_SHOW PROC NEAR ; muestra puntero de mouse
  MOV AX,1
  INT 33H
RET 
MOUSE_SHOW ENDP

MOUSE_HIDE PROC NEAR ; esconde puntero de mouse
  MOV AX,2
  INT 33H
RET 
MOUSE_HIDE ENDP

; detecta el estado del mouse
; Regresa: Bx=1, Boton izq presionado
;          Bx=2, Boton der presionado
;          Bx=3, Ambos presionados
;          Cx=x
;          Dx=y 
MOUSE_STATUS PROC NEAR 
  MOV AX,3
  INT 33H
RET 
MOUSE_STATUS ENDP



; PROCEDURES PARA DIBUJAR EL PIANO ======================

doo proc near
  mov al,rojo; color
  mov dx,50 ; renglon
  mov cx,40 ; columna
  mov bh,0 ; pagina

  linea1:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc cx
    cmp cx, 100
  jne linea1

  mov dx,50 ; renglon
  mov cx,100 ; columna
  linea2:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc dx
    cmp dx, 170
  jne linea2

  mov dx,50 ; renglon
  mov cx,40 ; columna
  linea3:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc dx
    cmp dx, 250
  jne linea3

  mov dx,250 ; renglon
  mov cx,40 ; columna
  linea4:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc cx
    cmp cx, 120
  jne linea4

  mov dx,170 ; renglon
  mov cx,100 ; columna
  linea5:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc cx
    cmp cx, 120
  jne linea5

  mov dx,170 ; renglon
  mov cx,120 ; columna
  linea6:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc dx
    cmp dx, 250
  jne linea6

  mov al,blanco; color
  mov dx,51 ; renglon
  mov cx,41 ; columna

  columna:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc cx
    cmp cx, 99
    jne columna
    mov cx, 41
    inc dx
    cmp dx, 171
  jne columna

  mov dx,171 ; renglon
  mov cx,41 ; columna
  
  columna2:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc cx
    cmp cx, 119
    jne columna2
    mov cx, 41
    inc dx
    cmp dx, 249
  jne columna2

  ret
doo endp

do2 proc near
  mov al,gris1; color
  mov dx,50 ; renglon
  mov cx,101 ; columna

  columna3:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc cx
    cmp cx, 139
    jne columna3
    mov cx, 101
    inc dx
    cmp dx, 169
  jne columna3
  ret
do2 endp

re proc near
  mov al,rojo; color

  mov dx,50 ; renglon
  mov cx,140 ; columna
  linea7:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc cx
    cmp cx, 180
  jne linea7

  mov dx,50 ; renglon
  mov cx,180 ; columna
  linea8:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc dx
    cmp dx, 170
  jne linea8

  mov dx,50 ; renglon
  mov cx,140 ; columna
  linea9:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc dx
    cmp dx, 170
  jne linea9

  mov dx,170 ; renglon
  mov cx,120 ; columna
  linea10:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc cx
    cmp cx, 140
  jne linea10

  mov dx,170 ; renglon
  mov cx,180 ; columna
  linea11:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc cx
    cmp cx, 200
  jne linea11

  mov dx,170 ; renglon
  mov cx,200 ; columna
  linea12:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc dx
    cmp dx, 250
  jne linea12

  mov dx,250 ; renglon
  mov cx,120 ; columna
  linea13:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc cx
    cmp cx, 200
  jne linea13

  mov al,blanco; color

  mov dx,51 ; renglon
  mov cx,141 ; columna
  columna4:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc cx
    cmp cx, 179
    jne columna4
    mov cx, 141
    inc dx
    cmp dx, 171
  jne columna4
  
  mov dx,171 ; renglon
  mov cx,121 ; columna
  columna5:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc cx
    cmp cx, 199
    jne columna5
    mov cx, 121
    inc dx
    cmp dx, 249
  jne columna5
  ret
re endp

re2 proc near
  mov al,gris1; color
  mov dx,50 ; renglon
  mov cx,181 ; columna

  columna6:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc cx
    cmp cx, 219
    jne columna6
    mov cx, 181
    inc dx
    cmp dx, 169
  jne columna6
  ret
re2 endp

mi proc near
  mov al,rojo; color

  mov dx,50 ; renglon
  mov cx,220 ; columna
  linea14:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc cx
    cmp cx, 280
  jne linea14

  mov dx,170 ; renglon
  mov cx,200 ; columna
  linea15:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc cx
    cmp cx, 220
  jne linea15

  mov dx,250 ; renglon
  mov cx,200 ; columna
  linea16:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc cx
    cmp cx, 280
  jne linea16

  mov dx,50 ; renglon
  mov cx,280 ; columna
  linea17:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc dx
    cmp dx, 250
  jne linea17

  mov dx,50 ; renglon
  mov cx,220 ; columna
  linea18:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc dx
    cmp dx, 170
  jne linea18

  mov al,blanco; color

  mov dx,51 ; renglon
  mov cx,221 ; columna
  columna7:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc cx
    cmp cx, 279
    jne columna7
    mov cx, 221
    inc dx
    cmp dx, 171
  jne columna7
  
  mov dx,171 ; renglon
  mov cx,201 ; columna
  columna8:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc cx
    cmp cx, 279
    jne columna8
    mov cx, 201
    inc dx
    cmp dx, 249
  jne columna8
  ret
mi endp

fa proc near
  mov al,rojo; color
  
  mov dx,50 ; renglon
  mov cx,280 ; columna
  linea19:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc cx
    cmp cx, 340
  jne linea19

  mov dx,50 ; renglon
  mov cx,340 ; columna
  linea20:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc dx
    cmp dx, 170
  jne linea20

  mov dx,50 ; renglon
  mov cx,280 ; columna
  linea21:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc dx
    cmp dx, 250
  jne linea21

  mov dx,250 ; renglon
  mov cx,280 ; columna
  linea22:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc cx
    cmp cx, 360
  jne linea22

  mov dx,170 ; renglon
  mov cx,340 ; columna
  linea23:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc cx
    cmp cx, 360
  jne linea23

  mov dx,170 ; renglon
  mov cx,360 ; columna
  linea24:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc dx
    cmp dx, 250
  jne linea24

  mov al,blanco; color
  mov dx,51 ; renglon
  mov cx,281 ; columna

  columna9:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc cx
    cmp cx, 339
    jne columna9
    mov cx, 281
    inc dx
    cmp dx, 171
  jne columna9

  mov dx,171 ; renglon
  mov cx,281 ; columna
  
  columna10:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc cx
    cmp cx, 359
    jne columna10
    mov cx, 281
    inc dx
    cmp dx, 249
  jne columna10

  ret
fa endp

fa2 proc near
  mov al,gris1; color
  mov dx,50 ; renglon
  mov cx,341 ; columna

  columna11:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc cx
    cmp cx, 379
    jne columna11
    mov cx, 341
    inc dx
    cmp dx, 169
  jne columna11
  ret
fa2 endp

sol proc near
  mov al,rojo; color

  mov dx,50 ; renglon
  mov cx,380 ; columna
  linea31:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc cx
    cmp cx, 420
  jne linea31

  mov dx,50 ; renglon
  mov cx,420 ; columna
  linea25:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc dx
    cmp dx, 170
  jne linea25

  mov dx,50 ; renglon
  mov cx,380 ; columna
  linea26:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc dx
    cmp dx, 170
  jne linea26

  mov dx,170 ; renglon
  mov cx,360 ; columna
  linea27:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc cx
    cmp cx, 380
  jne linea27

  mov dx,170 ; renglon
  mov cx,420 ; columna
  linea28:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc cx
    cmp cx, 440
  jne linea28

  mov dx,170 ; renglon
  mov cx,440 ; columna
  linea29:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc dx
    cmp dx, 250
  jne linea29

  mov dx,250 ; renglon
  mov cx,360 ; columna
  linea30:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc cx
    cmp cx, 440
  jne linea30

  mov al,blanco; color

  mov dx,51 ; renglon
  mov cx,381 ; columna
  columna12:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc cx
    cmp cx, 419
    jne columna12
    mov cx, 381
    inc dx
    cmp dx, 171
  jne columna12
  
  mov dx,171 ; renglon
  mov cx,361 ; columna
  columna13:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc cx
    cmp cx, 439
    jne columna13
    mov cx, 361
    inc dx
    cmp dx, 249
  jne columna13
  ret
sol endp

sol2 proc near
  mov al,gris1; color
  mov dx,50 ; renglon
  mov cx,421 ; columna

  columna14:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc cx
    cmp cx, 459
    jne columna14
    mov cx, 421
    inc dx
    cmp dx, 169
  jne columna14
  ret
sol2 endp

la proc near
  mov al,rojo; color

  mov dx,50 ; renglon
  mov cx,460 ; columna
  linea32:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc cx
    cmp cx, 500
  jne linea32

  mov dx,50 ; renglon
  mov cx,500 ; columna
  linea33:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc dx
    cmp dx, 170
  jne linea33

  mov dx,50 ; renglon
  mov cx,460 ; columna
  linea34:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc dx
    cmp dx, 170
  jne linea34

  mov dx,170 ; renglon
  mov cx,440 ; columna
  linea35:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc cx
    cmp cx, 460
  jne linea35

  mov dx,170 ; renglon
  mov cx,500 ; columna
  linea36:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc cx
    cmp cx, 520
  jne linea36

  mov dx,170 ; renglon
  mov cx,520 ; columna
  linea37:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc dx
    cmp dx, 250
  jne linea37

  mov dx,250 ; renglon
  mov cx,440 ; columna
  linea38:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc cx
    cmp cx, 520
  jne linea38

  mov al,blanco; color

  mov dx,51 ; renglon
  mov cx,461 ; columna
  columna15:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc cx
    cmp cx, 499
    jne columna15
    mov cx, 461
    inc dx
    cmp dx, 171
  jne columna15
  
  mov dx,171 ; renglon
  mov cx,441 ; columna
  columna16:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc cx
    cmp cx, 519
    jne columna16
    mov cx, 441
    inc dx
    cmp dx, 249
  jne columna16
  ret
la endp

la2 proc near
  mov al,gris1; color
  mov dx,50 ; renglon
  mov cx,501 ; columna

  columna17:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc cx
    cmp cx, 539
    jne columna17
    mov cx, 501
    inc dx
    cmp dx, 169
  jne columna17
  ret
la2 endp

sii proc near
  mov al,rojo; color

  mov dx,50 ; renglon
  mov cx,540 ; columna
  linea39:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc cx
    cmp cx, 600
  jne linea39

  mov dx,170 ; renglon
  mov cx,520 ; columna
  linea40:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc cx
    cmp cx, 540
  jne linea40

  mov dx,250 ; renglon
  mov cx,520 ; columna
  linea41:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc cx
    cmp cx, 600
  jne linea41

  mov dx,50 ; renglon
  mov cx,600 ; columna
  linea42:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc dx
    cmp dx, 250
  jne linea42

  mov dx,50 ; renglon
  mov cx,540 ; columna
  linea43:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc dx
    cmp dx, 170
  jne linea43

  mov al,blanco; color

  mov dx,51 ; renglon
  mov cx,541 ; columna
  columna18:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc cx
    cmp cx, 599
    jne columna18
    mov cx, 541
    inc dx
    cmp dx, 171
  jne columna18
  
  mov dx,171 ; renglon
  mov cx,521 ; columna
  columna19:
    mov ah, 0ch ; pintar pixel
    int 10h
    inc cx
    cmp cx, 599
    jne columna19
    mov cx, 521
    inc dx
    cmp dx, 249
  jne columna19
  ret
sii endp

end inicio