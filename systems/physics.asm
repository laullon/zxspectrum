update_physics
    call phy_move
    call phy_jump
    ret	

phy_jump:
    ld a, 0
    ld (act_sprite), a
    ld ix, sprites
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
    ld a, (act_sprite)
    inc a
    ld (act_sprite), a
    cp num_sprites
    ret z                   ; no more sprites
    ld a, 0
    ld b, a
    ld a, SP_SIZE
    ld c, a
    add ix, bc
    jp _loop
    ret

phy_move:
    ld a, 0
    ld (act_sprite), a
    ld ix, sprites
_update_physics_loop
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
    jp _update_physics_loop
