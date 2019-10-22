update_animations
    call frist_strite
_loop
    ld a, (ix+SP_F)
    ld b, (ix+SP_FC)
    inc a
    cp b
    jp nz, _end
    ld a, 0                 ;; back to first frame
_end
    ld (ix+SP_F), a

    call next_sprite
    ret z
    jp _loop
_act_sprite db 0