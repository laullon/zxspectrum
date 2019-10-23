apply_scroll
    call first_sprite

    ld a, (ix+SP_X)
    and %11110000
    rrca
    rrca
    rrca
    rrca
    cpl
    inc a
    ld d, a

_loop
    call next_sprite
    ret z
    ld a, (ix+SP_FLGS)
    and FLG_SCROLL
	jp z, _next
	ld (ix+SP_VX), d

_next
    jp _loop
