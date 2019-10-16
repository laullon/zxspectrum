main: org 33000					; stay above ULA-contended memory
	jp start					; jump to the beginning of our program

	include "systems/render.asm"
	include "systems/physics.asm"
	include "systems/animations.asm"
	include "systems/buffer.asm"
	include "systems/kbs.asm"
	include "systems/scroll.asm"
	include "game/sprites.asm"
	include "resources/player.asm"
	include "resources/floor.asm"
	include "resources/wall.asm"

man_sprite_frame:	db  0
floor_frame:	db  0
x_coordinate:	db	24*3
y_coordinate:	db	100

COLOUR_BLACK equ 0
COLOUR_BLUE equ 1
COLOUR_RED equ 2
COLOUR_MAGENTA equ 3
COLOUR_GREEN equ 4
COLOUR_CYAN equ 5
COLOUR_YELLOW equ 6
COLOUR_WHITE equ 7
ROM_ROUTINE_SET_BORDER_COLOUR equ 8859

VISIBLE_VIDEO_MEMORY equ 16384	; start of the video ram
VISIBLE_ATTRIBUTES_MEMORY equ VISIBLE_VIDEO_MEMORY + 3*VIDEO_SEGMENT_SIZE
VIDEO_SEGMENT_SIZE equ 2048		; size in bytes of a third of a screen


start:

loop:
	; call wait
	halt

	call update_buffer

	; halt 

	ld a, COLOUR_BLUE					; change border colour to red, to 
	call ROM_ROUTINE_SET_BORDER_COLOUR	; illustrate amount of CPU time spent

	call keyboard_update
	call update_animations
	call apply_scroll
	call update_physics

	; halt
	call render_sprites

	ld a, COLOUR_WHITE
	call ROM_ROUTINE_SET_BORDER_COLOUR


	; call movefloor
	; call drawfloor
	jr loop

tiles db 0
tile_x db 0
drawfloor:
	ld a, 10
	ld (tiles), a
	ld a, 0
	ld (tile_x), a
drawfloorloop
	call getfloor
	ld a, 126
	ld b, a
	ld a, (tile_x)
	ld c, a
	ld a, 3
	call draw3sprite
	
	ld a, (tile_x)
	ld b, 24
	add a, b
	ld (tile_x), a
	
	ld a, (tiles)
	dec a
	ld (tiles), a
	cp 0
	jp nz, drawfloorloop
	ret

;;
;; draw3Tile
;;
;; input:
;;			A = lines
;;			C = x
;;			B = y
;;			HL= data
;; destroy: A,D,C

lines db 0
draw3sprite:
	ld (lines), a
	call yx2pix		;point DE at corresponding screen position
draw3spriteloop
	ld bc, 3
	ldir
	call nextlinedown
	dec e
	dec e
	dec e
	ld a, (lines)
	dec a
	ld (lines), a
	cp 0
	jp nz, draw3spriteloop
	ret

nextlinedown:			;don't worry about how this works yet!
	inc d			;just arrive with DE in the display file
	ld a,d			;and it gets moved down one line
	and 7
	ret nz
	ld a,e
	add a,32
	ld e,a
	ret c
	ld a,d
	sub 8
	ld d,a
	ret

yx2pix:		;don't worry about how this works yet! just arrive with arrive with B=y 0-192, C=x 0-255
	ld a,b	;return with DE at corresponding place on the screen
	rra
	rra
	rra
	and 24
	or 64
	ld d,a
	ld a,b
	and 7
	or d
	ld d,a
	ld a,b
	rla
	rla
	and 224
	ld e,a
	ld a,c
	rra
	rra
	rra
	and 31
	or e
	ld e,a
	ret
	;

movefloor:		
	ld	a,(floor_frame)	;but we still need to find which preshifted sprite to draw
	inc a
	cp	3
	jp	nz, no_floor_reset
	ld	a, 0
no_floor_reset
	ld	(floor_frame), a
	ret

getfloor:		
	ld	a,(floor_frame)
	add a,a		;multiplay a by 2, this converts a single byte number 0-7 into a 2 byte table entry
	ld h,0
	ld l,a
	ld bc,floor_addresses
	add hl,bc	;HL is now pointing at the correct table entry
	ld c,(hl)
	inc hl
	ld b,(hl)	;get table address spritegraphic0, spritegraphic1 etc in BC
	ld l,c
	ld h,b		;now HL is pointing at the correct sprite graphic
	ret


wait   ld hl,pretim        ; previous time setting
       ld a,(23672)        ; current timer setting.
       sub (hl)            ; difference between the two.
       cp 3                ; have two frames elapsed yet?
       jr nc,wait0         ; yes, no more delay.
       jp wait
wait0  ld a,(23672)        ; current timer.
       ld (hl),a           ; store this setting.
       ret
pretim defb 0

; Input:
; 		B - row
;	    C - column
;       D - attribute byte
bitmaps_colours_set:
	ld h, 0
	ld l, b
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl					; HL := row x 32
	
	ld b, 0						; BC := column
	add hl, bc					; HL := (row x 32) + column
	
	ld bc, VISIBLE_ATTRIBUTES_MEMORY
	add hl, bc					; offset HL into the attributes memory area
	
	ld (hl), d					; store attribute byte
	ret

	end main
