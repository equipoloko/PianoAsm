revisador proc NEAR
  ;Cx=x
  ;Dx=y 
 
 ;primero revisaremos la parte superior
 
 ;comparamos que estemos en la parte superior Y < 170
 mov ax, 170
 cmp dx, ax
 jb zonaArriba
 jae zonaAbajo



 zonaArriba:
    mov bl,rojo
    call fondopantalla

    ;compararemos las coordenadas x de la zona de arriba

    cmp cx, 100
    jb nota1
    cmp cx, 140
    jb nota2
    cmp cx, 180
    jb nota3
    cmp cx, 220
    jb nota4
    cmp cx, 280
    jb nota5
    cmp cx, 340
    jb nota6
    cmp cx, 380
    jb nota7
    cmp cx, 420
    jb nota8
    cmp cx, 460
    jb nota9
    cmp cx, 500
    jb nota10
    cmp cx, 540
    jb nota11
    cmp cx, 600
    jb nota12


    jmp saltarEnd
 zonaAbajo:
    mov bl,verde
    call fondopantalla

 saltarEnd:
 ret


    nota1:
      mov bl, negro
      jmp acabar
    nota2:
      mov bl, negro
      jmp acabar
    nota3:
     mov bl, negro
      jmp acabar
    nota4:
     mov bl, negro
      jmp acabar
    nota5:
     mov bl, negro
      jmp acabar
    nota6:
      mov bl, negro
      jmp acabar
    nota7:
      mov bl, negro
      jmp acabar
    nota8:
      mov bl, negro
      jmp acabar
    nota9:
      mov bl, negro
      jmp acabar
    nota10:
      mov bl, negro
      jmp acabar
    nota11:
      mov bl, negro
      jmp acabar
    nota12:
      mov bl, negro
      jmp acabar

    acabar:
    call fondopantalla
    ret
revisador ENDP