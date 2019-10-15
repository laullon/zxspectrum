zSquareState: db KEY_RELEASED
xSquareState: db KEY_RELEASED
mSquareState: db KEY_RELEASED

KEY_PUSHED		equ %01101000 ; PAPER_GREEN
KEY_RELEASED 	equ %01100000 ; PAPER_RED

	KEY_X equ %00000100
	KEY_Z equ %00000010
	KEY_M equ %00000100

keyboard_update:
	call check_Z_key			; check the status of all keys,
	call check_X_key			; settings the states of the squares
	call check_M_key			; appropriately
	
	call display_Z_key_square	; display each of the squares
	call display_X_key_square
	call display_M_key_square
	
; Checks the Z key, and sets state of corresponding square appropriately
;
check_Z_key:
	ld bc,&FEFE        ; Load BC with the row port address
	in a,(C)           ; Read the port into the accumulator
	and KEY_Z
	jp z, z_key_is_pressed		; if Z is pressed, turn square green
	ld hl, zSquareState			; else turn it red
	ld (hl), KEY_RELEASED
	ret
z_key_is_pressed:
	ld hl, zSquareState
	ld (hl), KEY_PUSHED
	
	ld ix, player
	ld (ix+SP_VX), -2

	ret


; Checks the X key, and sets state of corresponding square appropriately
;
check_X_key:
	ld bc,&FEFE        ; Load BC with the row port address
	in a,(C)           ; Read the port into the accumulator
	and KEY_X
	jp z, x_key_is_pressed		; if X is pressed, turn square green
	ld hl, xSquareState			; else turn it red
	ld (hl), KEY_RELEASED
	ret
x_key_is_pressed:
	ld hl, xSquareState
	ld (hl), KEY_PUSHED

	ld ix, player
	ld (ix+SP_VX), 2

	ret


; Checks the M key, and sets state of corresponding square appropriately
;
check_M_key:
	ld bc,&7FFE        ; Load BC with the row port address
	in a,(C)           ; Read the port into the accumulator
	and KEY_M
	jp z, m_key_is_pressed		; if X is pressed, turn square green
	ld hl, mSquareState			; else turn it red
	ld (hl), KEY_RELEASED
	ret
m_key_is_pressed:
	ld hl, mSquareState
	ld (hl), KEY_PUSHED

	ld ix, player
	ld (ix+SP_JP_ON), 1

	ret
	

; Sets the attributes on the Z square, according to its state
;
display_Z_key_square:
	ld a, (zSquareState)
	ld d, a						; D := attributes of square
	ld b, 23						; row
	ld c, 1						; column
	call bitmaps_colours_set	; call routine
	ret


; Sets the attributes on the X square, according to its state
;	
display_X_key_square:
	ld a, (xSquareState)
	ld d, a							; D := attributes of square
	ld b, 23						; row
	ld c, 3							; column
	call bitmaps_colours_set		; call routine
	ret
	

; Sets the attributes on the M square, according to its state
;
display_M_key_square:
	ld a, (mSquareState)
	ld d, a							; D := attributes of square
	ld b, 23						; row
	ld c, 5							; column
	call bitmaps_colours_set		; call routine
	ret
	