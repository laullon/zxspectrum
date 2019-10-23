check_for_collisions
    ld iy, player
    call first_sprite

_loop
    call next_sprite
    ret z

    ld a, (ix+SP_X)
    add a, (ix+SP_W_PX)
    sub (iy+SP_X)
    jp m, _no_collision ; a<0

    ld a, (iy+SP_X)
    add a, (iy+SP_W_PX)
    sub (ix+SP_X)
    jp m, _no_collision

    ld a, (ix+SP_Y)
    add a, (ix+SP_H)
    sub (iy+SP_Y)
    jp m, _no_collision

    ld a, (iy+SP_Y)
    add a, (iy+SP_H)
    sub (ix+SP_Y)
    jp m, _no_collision

    ld d, KEY_PUSHED
	ld b, 23						; row
	ld c, 7							; column
	call bitmaps_colours_set		; call routine
    ret
    
_no_collision
	ld d, KEY_RELEASED
	ld b, 23						; row
	ld c, 7							; column
	call bitmaps_colours_set		; call routine

    jp _loop

