main: org 33000					; stay above ULA-contended memory
	jp start					; jump to the beginning of our program

	include "systems/render.asm"
	include "systems/physics.asm"
	include "systems/animations.asm"
	include "systems/buffer.asm"
	include "systems/kbs.asm"
	include "systems/scroll.asm"
	include "systems/collisions.asm"

	include "game/game.asm"
	include "game/sprites.asm"

	include "resources/player.asm"
	include "resources/floor.asm"
	include "resources/wall.asm"

COLOUR_BLACK equ 0x0
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
	call init_sprites
	call game_init
	
loop:
	; call wait
	halt

	; ld a, COLOUR_BLUE					; change border colour to red, to 
	; call ROM_ROUTINE_SET_BORDER_COLOUR	; illustrate amount of CPU time spent

	call update_buffer

	; ld a, COLOUR_WHITE
	; call ROM_ROUTINE_SET_BORDER_COLOUR

	; halt 


	call keyboard_update
	call game_update
	call update_animations
	call apply_scroll
	call update_physics
	call check_for_collisions


	call render_sprites



	; call movefloor
	; call drawfloor
	jr loop



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
