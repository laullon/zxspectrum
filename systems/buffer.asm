screen defs 32*61,0
screen_end db 0

update_buffer:
	; ld a, COLOUR_RED					; change border colour to red, to 
	; call ROM_ROUTINE_SET_BORDER_COLOUR	; illustrate amount of CPU time spent

    ld a, 0
    ld (_line), a
    ld hl, screen
    
    ld a, (_line)
    add a, 110
    ld b, a
    ld a, 60
_loop
    ld c, 32                    ; ldi messup wirh BC
    call coords_to_address

    ldi
    ldi
    ldi
    ldi
    ldi
    ldi
    ldi
    ldi

    ldi
    ldi
    ldi
    ldi
    ldi
    ldi
    ldi
    ldi

    ldi
    ldi
    ldi
    ldi
    ldi
    ldi
    ldi
    ldi

    ldi
    ldi
    ldi
    ldi
    ldi
    ldi
    ldi
    ldi

    inc b
    dec a
    jp nz, _loop

	; ld a, COLOUR_GREEN					; change border colour to red, to 
	; call ROM_ROUTINE_SET_BORDER_COLOUR	; illustrate amount of CPU time spent

    ; ld hl, screen
    ; ld de, screen+1
    ; ld (hl), 0
    ; ld bc, 32*60-1
    ; ldir

    call Clear_Screen_Fast

	; ld a, COLOUR_WHITE					; change border colour to red, to 
	; call ROM_ROUTINE_SET_BORDER_COLOUR	; illustrate amount of CPU time spent

    ret
_line db 0

; Fast clear-screen routine
; Uses the stack to block clear memory
;
Clear_Screen_Fast:
    ; Save the stack pointer
    ld (SAVE_SP),sp        ; Only remove if you're sure you don't need the stack
    ld sp,screen_end       ; e.g. to fill from &C000 to &FFFF (&4000 bytes), set SP to &FFFF+1 = &0000

    ; Define the region of RAM to be filled
    ld hl,$0000              ; Use HL or whichever 16-bit register you prefer
    ld de,32*61/2                    ; divided by 2 because DE is 2 bytes wide and PUSH pushes both

    ; Set up a fast 16-bit loop counter
    ld b,e                 ; This method takes advantage of the fact that DJNZ leaves B as 0, which subsequent DJNZs see as 256
    dec de                 ; B = (length/2) MOD 256, so 0 = a 512-byte block
    inc d                  ; D = the number of 512-byte blocks to write, or just = 1 if the length is <512
                            ; Of course, if you know the length ahead of run-time, you can set B and D directly in your ASM

    ; Fill the memory
PUSHLOOP:
    push hl                ; Writes HL to (SP-2) and DECs SP by 2.
                        ; For even more speed, use multiple PUSH HLs in a row (I like 8, = &10 bytes) and adjust counters to match
    djnz PUSHLOOP
    dec d
    jr nz,PUSHLOOP

; Restore the stack pointer
    SAVE_SP equ $+1
    ld SP,&9999            ; &9999 will be replaced by the actual previous value
    ret




sprite_xy2buff:
    push hl

    ld a, (ix+SP_X)
    rra
    rra
    rra
    and %00011111
    ld b, 0
    ld c, a
    
    ld hl, screen
    add hl, bc

    ld a, (ix+SP_Y)
    cp 0
    jp z, _end
    ld b, 0
    ld c, 32
_y_loop
    add hl, bc
    dec a
    jp nz, _y_loop
_end
    ld d, h
    ld e, l

    pop hl
    ret

; IN  -   B = pixel row (0..191)
; OUT -  HL = screen address
; OUT -  DE = trash
coords_to_address:  
    push hl
    push af
    ld  h, 0
    ld  l, b            ; hl = row
    add hl, hl          ; hl = row number * 2
    ld  de, screen_map  ; de = screen map
    add hl, de          ; de = screen_map + (row * 2)
    ld  a, (hl)         ; implements ld hl, (hl)
    inc hl
    ld  h, (hl)         
    ld  l, a            ; hl = address of first pixel in screen map
ex de,hl
    pop af
    pop hl
    ret                 ; return screen_map[pixel_row]

screen_map:		
	dw $4000, $4100, $4200,  $4300 
	dw $4400, $4500, $4600,  $4700 
	dw $4020, $4120, $4220,  $4320 
	dw $4420, $4520, $4620,  $4720 
	dw $4040, $4140, $4240,  $4340 
	dw $4440, $4540, $4640,  $4740 
	dw $4060, $4160, $4260,  $4360 
	dw $4460, $4560, $4660,  $4760 
	dw $4080, $4180, $4280,  $4380 
	dw $4480, $4580, $4680,  $4780 
	dw $40A0, $41A0, $42A0,  $43A0 
	dw $44A0, $45A0, $46A0,  $47A0 
	dw $40C0, $41C0, $42C0,  $43C0 
	dw $44C0, $45C0, $46C0,  $47C0 
	dw $40E0, $41E0, $42E0,  $43E0 
	dw $44E0, $45E0, $46E0,  $47E0 
	dw $4800, $4900, $4A00,  $4B00 
	dw $4C00, $4D00, $4E00,  $4F00 
	dw $4820, $4920, $4A20,  $4B20 
	dw $4C20, $4D20, $4E20,  $4F20 
	dw $4840, $4940, $4A40,  $4B40 
	dw $4C40, $4D40, $4E40,  $4F40 
	dw $4860, $4960, $4A60,  $4B60 
	dw $4C60, $4D60, $4E60,  $4F60 
	dw $4880, $4980, $4A80,  $4B80 
	dw $4C80, $4D80, $4E80,  $4F80 
	dw $48A0, $49A0, $4AA0,  $4BA0 
	dw $4CA0, $4DA0, $4EA0,  $4FA0 
	dw $48C0, $49C0, $4AC0,  $4BC0 
	dw $4CC0, $4DC0, $4EC0,  $4FC0 
	dw $48E0, $49E0, $4AE0,  $4BE0 
	dw $4CE0, $4DE0, $4EE0,  $4FE0 
	dw $5000, $5100, $5200,  $5300 
	dw $5400, $5500, $5600,  $5700 
	dw $5020, $5120, $5220,  $5320 
	dw $5420, $5520, $5620,  $5720 
	dw $5040, $5140, $5240,  $5340 
	dw $5440, $5540, $5640,  $5740 
	dw $5060, $5160, $5260,  $5360 
	dw $5460, $5560, $5660,  $5760 
	dw $5080, $5180, $5280,  $5380 
	dw $5480, $5580, $5680,  $5780 
	dw $50A0, $51A0, $52A0,  $53A0 
	dw $54A0, $55A0, $56A0,  $57A0 
	dw $50C0, $51C0, $52C0,  $53C0 
	dw $54C0, $55C0, $56C0,  $57C0 
	dw $50E0, $51E0, $52E0,  $53E0 
	dw $54E0, $55E0, $56E0,  $57E0 
