;graphics mode
mov ah, 0
mov al, 13h
int 10h

push 99

W EQU 119
A EQU 97
S EQU 115
D EQU 100
O EQU 111
K EQU 107
L EQU  108
semicolon EQU 59

jmp set
px dw 170
py dw 70
temps dw 0
px2 dw 170
py2 dw 70
msg db "GAME OVER!", '$'  ;string to be printed
set:
mov px, 170
mov px2, 100
mov py, 70
mov py2, 10
main:


mov cx, px
sub cx, 5
cmp px2, cx
jle continue

add cx, 10
cmp px2, cx
jge continue

mov cx, py
sub cx, 5
cmp py2, cx
jl continue

add cx, 10
cmp py2, cx
jle game_over



continue:

push px
push py
push 5
call draw_square

push px2
push py2
push 5
call draw_red_square

push 120
call draw_frame

;Getting Input
MOV AH,00h
INT 16h

mov b.temps, al

;print char
;mov dl, b.temps
;mov ah,2
;int 21h


;EVENTS
cmp b.temps, 'a'
je dleft

cmp b.temps, D
je dright

cmp b.temps, W
je dup

cmp b.temps, S
je ddown

cmp b.temps, K
je dleft2

cmp b.temps, semicolon
je dright2

cmp b.temps, O
je dup2

cmp b.temps, L
je ddown2


done:
jmp main
include 'draw.asm'


dright:
call cls
add px, 5
jmp done

dleft:
call cls
sub px, 5
jmp done

dup:
call cls
sub py, 5
jmp done

ddown:
call cls
add py, 5
jmp done

cls:
push px
push py
push 5
call draw_black_square
ret


dright2:
call cls2
add px2, 5
jmp done

dleft2:
call cls2
sub px2, 5
jmp done

dup2:
call cls2
sub py2, 5
jmp done

ddown2:
call cls2
add py2, 5
jmp done

cls2:
push px2
push py2
push 5
call draw_black_square
ret

game_over:
mov dx, "a" ;lea dx,msg
mov ah,9 
int 21h

;wait for input
MOV AH,00h
INT 16h
