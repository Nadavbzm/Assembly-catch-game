mov ah, 0
mov al, 13h
int 10h

len dw  0
offycol dw 0
offxrow dw 0
retadd dw 0

proc draw_frame
pop retadd
pop len

mov cx, 100
add cx, len
mov dx, 0

rw:
mov al, 11     ; blue
mov ah, 0ch    ; put pixel
int 10h
dec cx
cmp cx, 100
jne rw

rw1:
mov al, 11     ; blue
mov ah, 0ch    ; put pixel
int 10h
inc dx
cmp dx, len
jne rw1

mov cx, 100
add cx, len
xor dx, dx

rw2:
mov al, 11     ; blue
mov ah, 0ch    ; put pixel
int 10h
inc dx
cmp dx, len
jne rw2

mov dx, len
mov cx, 100
add cx, len
rw3:
mov al, 11    ; blue
mov ah, 0ch    ; put pixel
int 10h
dec cx
cmp cx, 100
jne rw3

push retadd
ret

proc draw_square
add sp, 2
;first push row, column, len
jmp s

s:
pop len
pop offycol   ;column
pop offxrow   ;row

mov dx, offycol
mov cx, offxrow

inc dx ;offset fix


;mov cx, 0     ; column
;mov dx, 0     ; row

rows:
mov al, 9     ; blue
mov ah, 0ch    ; put pixel
int 10h

INC cx
mov ax, offxrow
add ax, len
cmp cx, ax
jle rows

jmp new_col

new_col:

INC DX
MOV cx, offxrow
mov ax, offycol
add ax, len
CMP Dx, ax
JLE rows

sub sp, 8
pop ax
add sp, 4
push ax
ret
ENDP draw_square
ret

proc draw_black_square
add sp, 2
;first push row, column, len
jmp j

j:
pop len
pop offycol   ;column
pop offxrow   ;row

mov dx, offycol
mov cx, offxrow

inc dx ;offset fix


;mov cx, 0     ; column
;mov dx, 0     ; row

rows1:
mov al, 0     ; black
mov ah, 0ch    ; put pixel
int 10h

INC cx
mov ax, offxrow
add ax, len
cmp cx, ax
jle rows1

jmp new_col1

new_col1:

INC DX
MOV cx, offxrow
mov ax, offycol
add ax, len
CMP Dx, ax
JLE rows1
ret
ENDP draw_black_square
ret


proc draw_red_square
add sp, 2
;first push row, column, len
jmp s_red

s_red:
pop len
pop offycol   ;column
pop offxrow   ;row

mov dx, offycol
mov cx, offxrow

inc dx ;offset fix


;mov cx, 0     ; column
;mov dx, 0     ; row

rows_red:
mov al, 4     ; red
mov ah, 0ch    ; put pixel
int 10h

INC cx
mov ax, offxrow
add ax, len
cmp cx, ax
jle rows_red

jmp new_col_red

new_col_red:

INC DX
MOV cx, offxrow
mov ax, offycol
add ax, len
CMP Dx, ax
JLE rows_red

sub sp, 8
pop ax
add sp, 4
push ax
ret
ENDP draw_red_square
ret
