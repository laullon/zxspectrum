game_init
    call new_block
    ret

game_update
    ; call need_new_block
    ; call delete_blocks
    ret

delete_blocks
    call first_sprite
_loop
    call next_sprite
    ret z
    
    ld a, (ix+SP_X)
    rra
    rra
    rra
    and %00011111
    cp 31
    jp nz, _loop
    
    ret

; need_new_block
;     call last_sprite
;     ld a, (ix+SP_X)
;     cp 200
;     jp p, _end
;     call new_block
; _end
;     ret

new_block
    ld iy, basic_block
    call add_sprite
    ld (ix+SP_X), 255-8
    ld (ix+SP_Y), 58-16
    ld (ix+SP_H), 16
    ld (ix+SP_SZ), 16*2

    ld iy, basic_block
    call add_sprite
    ld (ix+SP_X), 255-16
    ld (ix+SP_Y), 58-8
    ld (ix+SP_H), 8
    ld (ix+SP_SZ), 8*2

    ld iy, basic_block
    call add_sprite
    ld (ix+SP_X), 255-24
    ld (ix+SP_Y), 58-8
    ld (ix+SP_H), 8
    ld (ix+SP_SZ), 8*2

    ld iy, basic_block
    call add_sprite
    ld (ix+SP_X), 255-32
    ld (ix+SP_Y), 58-8
    ld (ix+SP_H), 8
    ld (ix+SP_SZ), 8*2

    ld iy, basic_block
    call add_sprite
    ld (ix+SP_X), 255-40
    ld (ix+SP_Y), 58-8
    ld (ix+SP_H), 8
    ld (ix+SP_SZ), 8*2

    ld iy, basic_block
    call add_sprite
    ld (ix+SP_X), 255-48
    ld (ix+SP_Y), 58-8
    ld (ix+SP_H), 8
    ld (ix+SP_SZ), 8*2
    ret	

basic_block
    db 0, 0, 0, 0, FLG_SCROLL
    dw wall_sprite_addresses
    db 2, 8, 8, 16, 1, 0
    dw 0
    db 0, 0, 0
