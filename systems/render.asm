
act_sprite  db 0
num_shifts  db 0

render_sprites:
    ld a, 0
    ld (act_sprite), a
    ld ix, sprites
render_sprites_loop
    ld a, (ix+SP_F)
    ld c, (ix+SP_DT)
    ld b, (ix+SP_DT+1)
    call find_frame     ;point HL to the sprite frame

    ld a, %00000111
    ld b, (ix+SP_X)
    and b
    ld (num_shifts), a
    cp 0
    jp z, shift_done
    ld a, (ix+SP_H)
    ld b, a
    ld a, (num_shifts)
    call shift_sprite_1px
shift_done
    call draw_sprite

    ld a, (act_sprite)
    inc a
    ld (act_sprite), a
    cp num_sprites
    ret z

    ld a, 0
    ld b, a
    ld a, SP_SIZE
    ld c, a
    add ix, bc
    jp render_sprites_loop


shift_sprite_buff defs 4*26,0
shift_sprite_buff2 defs 4*26,0

delete_sprites:
    ld a, 0
    ld (act_sprite), a
    ld ix, sprites
_loop
    ld a, (ix+SP_Y)
	ld b, a
    ld a, (ix+SP_X)
	ld c, a
    ld a, (ix+SP_H)
    call delete_sprite

    ld a, (act_sprite)
    inc a
    ld (act_sprite), a
    cp num_sprites
    ret z

    ld a, 0
    ld b, a
    ld a, SP_SIZE
    ld c, a
    add ix, bc
    jp _loop


;; input:
;;      A - pixels to shift
;;      B - lines
;;      HL - sprite frame
;; output:
;;      HL - new sprite frame
pending_lines db 0
pending_pixles db 0
shift_sprite_1px
    ld (pending_pixles), a
    ld a, b
    ld (pending_lines), a

    ld de, shift_sprite_buff
    ld bc, 4*26
    ldir

_1px_loop
    ld a, (pending_lines)
    ld hl, shift_sprite_buff
_line_loop
    rr (hl)
    inc hl
    rr (hl)
    inc hl
    rr (hl)
    inc hl
    rr (hl)
    inc hl

    dec a
    cp 0
    jp nz, _line_loop

    ld a, (pending_pixles)
    dec a
    ld (pending_pixles), a
    cp 0
    jp nz, _1px_loop
    
    ld hl, shift_sprite_buff
    ret

;; input:
;;      IX - sprite
;;      HL - sprite frame
draw_sprite:
    ld a, 0
	ld (_line), a
	call xy2buff		;point DE at corresponding screen position
_loop
	ld a, (ix+SP_W)
	ld b, 0 
	ld c, a
	ldir

    push hl
	ld a, 32
    sub (ix+SP_W)
	ld b, 0 
	ld c, a
    ld h, d
    ld l, e
    add hl, bc
    ld d, h
    ld e, l
    pop hl

	ld a, (_line)
    inc a
	ld (_line), a
	cp (ix+SP_H)
	jp nz, _loop
	ret
_line db 0

;; input:
;;      A - h
;;      C - x
;;      B - Y
delete_sprite:
_lines db 0
	ld (_lines), a
	call yx2pix		;point DE at corresponding screen position
_loop
    ld a, &0
	ld (de), a        ; TODO: ojo
    inc de
	ld (de), a        ; TODO: ojo
    inc de
	ld (de), a        ; TODO: ojo
    inc de
	ld (de), a        ; TODO: ojo
    inc de
	call nextlinedown
	dec e
	dec e
	dec e
	dec e
	ld a, (_lines)
	dec a
	ld (_lines), a
	cp 0
	jp nz, _loop
	ret

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

;; input:
;;      IX - sprite
;;      A  - line
;;      DE - screen addr
;; destroy:
;;      A
sprite2pix:
    ld (_line), a
	add a, (ix+SP_Y)
	rra
	rra
	rra
	and 24
	or 64
	ld d,a
    ld a, (_line)
	add a, (ix+SP_Y)
	and 7
	or d
	ld d,a
    ld a, (_line)
	add a, (ix+SP_Y)
	rla
	rla
	and 224
	ld e,a
	ld a, (ix+SP_X)
	rra
	rra
	rra
	and 31
	or e
	ld e,a
	ret
_line db 0