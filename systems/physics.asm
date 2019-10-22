update_physics
    call phy_move
    call phy_jump
    ret	

phy_jump:
    call frist_strite
_loop
    ld a, (ix+SP_JP_ON)
    cp 0
    jp z, _next             ; no jump
    ld a, (ix+SP_JP_C)
    ld b, (ix+SP_JP_ST)
    cp b
    jp z, _stop             ; jump finished
    ld c, (ix+SP_JP_DT)
    ld b, (ix+SP_JP_DT+1)
    ld a, (ix+SP_JP_C)
_a  cp 0
    jp z, _c
    inc bc
    dec a
    jp nz, _a
_c  ld a, (bc)
    ld (ix+SP_Y), a
    ld a, (ix+SP_JP_C)
    inc a
    ld (ix+SP_JP_C),a
    jp _next
_stop
    ld (ix+SP_JP_ON), 0
    ld (ix+SP_JP_C), 0
_next
    call next_sprite
    ret z
    jp _loop

phy_move:
    call frist_strite
_loop
    ld a, (ix+SP_VX)
    ld b, (ix+SP_X)
    add a, b
    ld (ix+SP_X), a
    ld b, %00000111
    and b
    cp 0
    jp nz, _end
    ld (ix+SP_VX), 0
_end
    call next_sprite
    ret z
    jp _loop
