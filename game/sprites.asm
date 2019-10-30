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
FLG_EMPTY   equ %1000000

NUM_SLOTS equ 32

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

slots:
    defs NUM_SLOTS*SP_SIZE,0

    dw #FFFF, #FFFF

;; init
init_sprites
    ld b, 0
    ld c, SP_SIZE
    ld ix, slots
_loop
    ld (ix+SP_X), #FF
    ld (ix+SP_Y), #FF
    ld (ix+SP_FLGS), FLG_EMPTY
    add ix, bc                  ; next slot
    ld a, (ix)
    and (ix+1)
    cp #ff                      ; end ?
    ret z
    jp _loop

;; output:
;;      ix - point to the frist sprite
first_sprite
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

    ld a, (ix)  ; end ?
    and (ix+1)
    cp #ff
    ret z

    ld a, (ix+SP_FLGS) ; is empty?
    and FLG_EMPTY
    jp nz, next_sprite
    or 1               ; reset z 
    ret


;; input:
;;      iy - point to the new sprite data
;; output:
;;      ix - point to the new sprite
add_sprite
    call first_empty_slot   ; go to sprite array end
    ret z

    push ix
    ld b, SP_SIZE
_copy
    ld a, (iy)
    ld (ix), a
    inc ix
    inc	iy
    djnz _copy

    pop ix
    ret

;; first_empty_slot:
;; output:
;;      ix - point to the first empty sprite
;;      z - set if no more sprites
first_empty_slot
    ld ix, slots
_loop
    ld a, (ix+SP_FLGS)
    and FLG_EMPTY
    ret nz
    call next_slot
    ret z
    jp _loop

;; input:
;;      ix - point to the actual sprite
;; output:
;;      ix - point to the next sprite
;;      z - set if no more sprites
next_slot
    push bc
    ld b, 0
    ld c, SP_SIZE
    add ix, bc
    pop bc
    ld a, (ix)
    and (ix+1)
    and (ix+2)
    cp #ff
    ret