;graphics mode
mov ah, 0
mov al, 13h
int 10h

push 99

;ascii code for player 1 buttons
W EQU 119
A EQU 97
S EQU 115
D EQU 100

;ascii code for player 2 buttons
O EQU 111
K EQU 107
L EQU  108
semicolon EQU 59

jmp set     ;Skipping over variable declaration
px dw 170   ; x location of player 1
py dw 70    ; y location of player 1
temps dw 0  ;temporary variable for input comparison
px2 dw 170 ; x location of player 2
py2 dw 70   ; y location of player 2
msg db "GAME OVER!", '$' ; Game over string
filename dw "scores.txt", 0h ; scoreboard file - 0 terminated
counter dw  0 ; Move counter

; setting player sarting point and reseting move counter
set:
mov counter, 0
mov px, 170
mov px2, 100
mov py, 70
mov py2, 10

main:

;Colision check for the 2 players - is game over?
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
;drawing player 1
push px
push py
push 5
call draw_square

;drawing player 2
push px2
push py2
push 5
call draw_red_square

;drawing game frame
;push 120
;call draw_frame

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
jmp done ;no valid option pressed

;player1 options
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

;player2 options
dright2:
inc counter
call cls2
add px2, 5
jmp done

dleft2:
inc counter
call cls2
sub px2, 5
jmp done

dup2:
inc counter
call cls2
sub py2, 5
jmp done

ddown2:
inc counter
call cls2
add py2, 5
jmp done

;restarting loop
done:
jmp main

;this file includes functions for drawing
include 'draw.asm'

;clearing first player
cls:
push px
push py
push 5
call draw_black_square
ret

;clearing second player
cls2:
push px2
push py2
push 5
call draw_black_square
ret

;game over function
game_over:
call print_msg

mov     cx, 1              ; flag for writeonly access mode (O_WRONLY)
mov     bx, filename       ; filename of the file to open
mov     ax, 5              ; invoke SYS_OPEN (kernel opcode 5)
int     80h                 ; call the kernel
int 21h
mov     dx, 2              ; whence argument (SEEK_END)
mov     cx, 0              ; move the cursor 0 bytes
mov     bx, ax            ; move the opened file descriptor into EBX
mov     ax, 19             ; invoke SYS_LSEEK (kernel opcode 19)
int     80h                 ; call the kernel

mov     dx, 9              ; number of bytes to write - LEN * CHARSIZE
mov     cx, counter       ; move the memory address of contents string into ecx
mov     bx, bx            ; move the opened file descriptor into EBX (not required as EBX already has the FD)
mov     ax, 4              ; invoke SYS_WRITE (kernel opcode 4)
int     80h                 ; call the kernel
;print char
mov dl, 'a'
mov ah,2
int 21h
call    quit
;print char
mov dl, 'a'
mov ah,2
int 21h

;quitting
quit:
mov     bx, 0
mov     ax, 1
int     80h
ret

;prints "game over"
print_msg:
;print char
mov dl, 'G'
mov ah,2
int 21h
;print char
mov dl, 'A'
mov ah,2
int 21h
;print char
mov dl, 'M'
mov ah,2
int 21h
;print char
mov dl, 'E'
mov ah,2
int 21h
;print char
mov dl, ' '
mov ah,2
int 21h
;print char
mov dl, 'O'
mov ah,2
int 21h
;print char
mov dl, 'V'
mov ah,2
int 21h
;print char
mov dl, 'E'
mov ah,2
int 21h
;print char
mov dl, 'R'
mov ah,2
int 21h
;print char
mov dl, '!'
mov ah,2
int 21h
ret
