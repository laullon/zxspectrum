apply_scroll
    ld a, 0
    ld (act_sprite), a
    ld ix, sprites
_loop
    ld a, (ix+SP_FLGS)
    and FLG_SCROLL
	jp z, _next
	ld (ix+SP_VX), -3

_next
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
