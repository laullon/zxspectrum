SP_X	equ 0
SP_Y	equ 1
SP_VX:	equ 2
SP_VY	equ 3
SP_FLGS equ 4
SP_DT	equ 5   ;2
SP_W	equ 7
SP_H	equ 8
SP_SZ   equ 9
SP_FC	equ 10
SP_F	equ 11
SP_JP_DT    equ 12  ;2
SP_JP_ON    equ 14
SP_JP_C     equ 15
SP_JP_ST    equ 16
SP_SIZE equ 17

FLG_SCROLL  equ %0000001

;; x, y, vx, vy, flags
;; data
;; width, height, frames, frame
;; jump sequece
;; jumping?, jump frame, jump frames
sprites:
player:
	db 0, 32, 0, 0, 0
    dw man_sprite_addresses
    db 4, 26, 104, 5, 0
    dw man_jump_squence
    db 0, 0, 13

	db 200, 50, 0, 0, FLG_SCROLL
    dw wall_sprite_addresses
    db 2, 8, 16, 1, 0
    dw 0
    db 0, 0, 0

	db 100, 42, 0, 0, FLG_SCROLL
    dw wall_sprite_addresses
    db 2, 16, 32, 1, 0
    dw 0
    db 0, 0, 0

num_sprites equ 3