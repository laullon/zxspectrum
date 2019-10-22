update_animations
    ld a, 0
    ld (_act_sprite), a
    ld ix, sprites          ;; first sprite
_update
    ld a, (ix+SP_F)
    ld b, (ix+SP_FC)
    inc a
    cp b
    jp nz, _end
    ld a, 0                 ;; back to first frame
_end
    ld (ix+SP_F), a

    ld a, (_act_sprite)     ;; more sprites?
    inc a
    ld (_act_sprite), a
    cp num_sprites
    ret z

    ld a, 0                 ;; next sprite
    ld b, a
    ld a, SP_SIZE
    ld c, a
    add ix, bc
    jp _update
_act_sprite db 0