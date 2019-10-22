SP_X	equ 0
SP_Y	equ 1
SP_VX	equ 2
SP_VY	equ 3
SP_FLGS equ 4
SP_DT	equ 5   ;2
SP_W	equ 7
SP_W_PX	equ 8
SP_H	equ 9
SP_SZ   equ 10
SP_FC	equ 11
SP_F	equ 12
SP_JP_DT    equ 13  ;2
SP_JP_ON    equ 15
SP_JP_C     equ 16
SP_JP_ST    equ 17
SP_SIZE equ 18

FLG_SCROLL  equ %0000001

;; x, y, vx, vy, flags
;; data
;; width, width_px, height, n_bytes, frames, frame
;; jump sequece
;; jumping?, jump frame, jump frames
sprites:
player:
	db 0, 32, 0, 0, 0
    dw man_sprite_addresses
    db 4, 24, 26, 104, 5, 0
    dw man_jump_squence
    db 0, 0, 13

blocks:
    db 200, 50, 0, 0, FLG_SCROLL
    dw wall_sprite_addresses
    db 2, 8, 8, 16, 1, 0
    dw 0
    db 0, 0, 0

    db 100, 42, 0, 0, FLG_SCROLL
    dw wall_sprite_addresses
    db 2, 8, 16, 32, 1, 0
    dw 0
    db 0, 0, 0

    db $ff

;; output:
;;      ix - point to the frist sprite
frist_strite
    ld ix, sprites
    ret

;; input:
;;      ix - point to the actual sprite
;; output:
;;      ix - point to the next sprite
;;      z - set if no more sprites
next_sprite
    push bc
    ld b, 0
    ld c, SP_SIZE
    add ix, bc
    pop bc
    ld a, (ix)
    cp #ff
    ret

