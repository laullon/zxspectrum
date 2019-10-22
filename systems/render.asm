

render_sprites:
    ld a, 0
    ld (_act_sprite), a
    ld ix, sprites
_render_sprites_loop
    ld a, (ix+SP_F)
    ld c, (ix+SP_DT)
    ld b, (ix+SP_DT+1)
    call find_frame     ;point HL to the sprite frame

    ld a, %00000111
    ld b, (ix+SP_X)
    and b
    ld (_num_shifts), a
    cp 0
    jp z, _shift_done
    ld a, (ix+SP_H)
    ld b, a
    ld a, (_num_shifts)
    call shift_sprite_1px
_shift_done
    call draw_sprite

    ld a, (_act_sprite)
    inc a
    ld (_act_sprite), a
    cp num_sprites
    ret z

    ld a, 0
    ld b, a
    ld a, SP_SIZE
    ld c, a
    add ix, bc
    jp _render_sprites_loop
_act_sprite  db 0
_num_shifts  db 0


shift_sprite_buff defs 4*26,0

;; input:
;;      A - pixels to shift
;;      B - lines
;;      HL - sprite frame
;; output:
;;      HL - new sprite frame
shift_sprite_1px
    ld (_pixles), a
    ld de, shift_sprite_buff    ; copy frame to the buffer
    ld b, 0
    ld c, (ix+SP_SZ)
    ldir

_1px_loop
    ld b, (ix+SP_SZ)            ; number of bytes
    ld hl, shift_sprite_buff
_loop
    rr (hl)
    inc hl
    djnz _loop

    ld a, (_pixles)
    dec a
    jp z, _done
    ld (_pixles), a
    jp _1px_loop
_done
    ld hl, shift_sprite_buff
    ret
_pixles db 0

;; input:
;;      IX - sprite
;;      HL - sprite frame
draw_sprite:
    ld a, 32
    sub (ix+SP_W)
    ld (_offset), a     ; bites up to the next line
    
    ld a, (ix+SP_H)     ; last line
    ld (_lines), a
    
    call sprite_xy2buff ;point DE at corresponding screen position
_loop
    push de

	ld a, (ix+SP_W) ; bytes on x
	ld b, a
_nb ld a,(de)
    or (hl)
    ld (de),a
    inc de
    inc hl
    djnz _nb        ; next byte x

    pop de          ; next line on buffer
    ld b, 0
    ld c, 32
    ex de,hl
    add hl,bc
    ex de,hl

    ld a, (_lines)   ; next sprint line
    dec a
    ret z
    ld (_lines), a
    jp  _loop
_lines db 0
_offset db 0

;; input:
;;      A  - frame
;;      BC - frame list
;; return:
;;      HL - frame
find_frame
	add a,a		;multiplay a by 2, this converts a single byte number 0-7 into a 2 byte table entry
	ld h,0
	ld l,a
	add hl,bc	;HL is now pointing at the correct table entry
	ld c,(hl)
	inc hl
	ld b,(hl)	;get table address spritegraphic0, spritegraphic1 etc in BC
	ld l,c
	ld h,b		;now HL is pointing at the correct sprite graphic
	ret