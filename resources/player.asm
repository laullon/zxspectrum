man_sprite_addresses:
	dw	man_sprite
	dw	man_sprite_1
	dw	man_sprite_2
	dw	man_sprite_3
	dw	man_sprite_4

man_jump_squence:
	db 16, 8, 4, 2, 1, 0, 0, 1, 2, 4, 8, 16, 32

man_sprite:
; 23 x 26
	db %00000000, %00000001, %00000000, %00000000
	db %00000000, %00000000, %11110000, %00000000
	db %00000000, %11000111, %11111000, %00000000
	db %00000000, %01111111, %11111000, %00000000
	db %00000000, %01111111, %11111100, %00000000
	db %00000000, %11111111, %00001100, %00000000
	db %00000000, %01111100, %00000100, %00000000
	db %00000000, %01111000, %01000100, %00000000
	db %00000000, %00110000, %00010100, %00000000
	db %00000000, %01111000, %00001000, %00000000
	db %00000111, %10011100, %00010000, %00000000
	db %00011000, %00011111, %00100000, %00000000
	db %00100000, %00011111, %11000000, %00000000
	db %00100111, %11111111, %10100000, %00000000
	db %00011000, %11111111, %00100110, %00000000
	db %00000001, %11111111, %00011010, %00000000
	db %00000001, %11111111, %11000010, %00000000
	db %00000011, %11111101, %00111100, %00000000
	db %00000101, %11111101, %00000000, %00000000
	db %00001000, %11111111, %00000000, %00000000
	db %00010000, %01111111, %10011000, %00000000
	db %00100000, %11111111, %11111000, %00000000
	db %01000001, %00011111, %11111000, %00000000
	db %01000010, %00000111, %11111000, %00000000
	db %00100001, %00000001, %11110000, %00000000
	db %00011110, %00000000, %01100000, %00000000

man_sprite_1:
	db %00000000, %00000000, %00000000, %00000000
	db %00000000, %00000001, %11110000, %00000000
	db %00000000, %00000111, %11111000, %00000000
	db %00000000, %11111111, %11111000, %00000000
	db %00000000, %01111111, %11111100, %00000000
	db %00000000, %11111111, %00001100, %00000000
	db %00000000, %01111100, %00000100, %00000000
	db %00000000, %01111000, %01000100, %00000000
	db %00000000, %00110000, %00010100, %00000000
	db %00000000, %01111000, %00001000, %00000000
	db %00000000, %11001100, %00010000, %00000000
	db %00000000, %10000111, %01100000, %00000000
	db %00000000, %10000111, %11000000, %00000000
	db %00000000, %10001111, %11000000, %00000000
	db %00000001, %10001111, %10100000, %00000000
	db %00000001, %00011111, %00010000, %00000000
	db %00000011, %00011111, %00010000, %00000000
	db %00000011, %00111111, %11100000, %00000000
	db %00000010, %11111100, %10000000, %00000000
	db %00000010, %01111100, %10000000, %00000000
	db %00000010, %00111111, %00000000, %00000000
	db %00000001, %11111100, %00000000, %00000000
	db %00000000, %11111100, %00000000, %00000000
	db %00000000, %11111000, %00000000, %00000000
	db %00000000, %11111100, %00000000, %00000000
	db %00000000, %11111100, %00000000, %00000000

man_sprite_2:
	db %00000000, %00000001, %00000000, %00000000
	db %00000000, %00000000, %11110000, %00000000
	db %00000000, %11000111, %11111000, %00000000
	db %00000000, %01111111, %11111100, %00000000
	db %00000000, %01111111, %11111100, %00000000
	db %00000000, %11111111, %10000100, %00000000
	db %00000000, %01111110, %00000100, %00000000
	db %00000000, %01111100, %00100100, %00000000
	db %00000000, %00111000, %00000100, %00000000
	db %00000000, %00111000, %00001000, %00000000
	db %00000000, %01000100, %00010000, %00000000
	db %00000000, %11000111, %00100000, %00000000
	db %00000000, %11000010, %11000000, %00000000
	db %00000000, %11000010, %01000000, %00000000
	db %00000000, %11100011, %11100000, %00000000
	db %00000001, %11110000, %00100000, %00000000
	db %00000001, %11111000, %01100000, %00000000
	db %00000011, %11111111, %11100000, %00000000
	db %00000111, %11111100, %00100000, %00000000
	db %00001111, %11111000, %01000000, %00000000
	db %00011111, %11110000, %10000000, %00000000
	db %00111111, %11010001, %00000000, %00000000
	db %01111111, %00001111, %00000000, %00000000
	db %11111110, %00000000, %00000000, %00000000
	db %11111100, %00000000, %00000000, %00000000
	db %01111100, %00000000, %00000000, %00000000

man_sprite_3:
	db %00000000, %00000001, %00000000, %00000000
	db %00000000, %00000000, %11110000, %00000000
	db %00000000, %11000111, %11111000, %00000000
	db %00000000, %11111111, %11111100, %00000000
	db %00000000, %01111111, %11111100, %00000000
	db %00000000, %11111111, %10000100, %00000000
	db %00000000, %01111110, %00000100, %00000000
	db %00000000, %01111100, %00100100, %00000000
	db %00000000, %00111000, %00000100, %00000000
	db %00000001, %11111000, %00001000, %00000000
	db %00000010, %01110100, %00010000, %00000000
	db %00000100, %11100011, %01100000, %00000000
	db %00001001, %11100000, %11011000, %00000000
	db %00010011, %11100000, %01100100, %00000000
	db %00010101, %11111110, %00001000, %00000000
	db %00001001, %11111111, %00010000, %00000000
	db %00000001, %11111111, %11100000, %00000000
	db %00000001, %11111111, %00000000, %00000000
	db %00000000, %11111111, %10000000, %00000000
	db %00000011, %00000111, %10000000, %00000000
	db %00000011, %11111111, %01000000, %00000000
	db %00000111, %11111110, %00100000, %00000000
	db %00000111, %10000100, %00010000, %00000000
	db %00000111, %00000010, %00001100, %00000000
	db %00000000, %00000001, %00000100, %00000000
	db %00000000, %00000000, %11111100, %00000000

man_sprite_4:
	db %00000000, %00000001, %00000000, %00000000
	db %00000000, %00000000, %11110000, %00000000
	db %00000000, %11000111, %11111000, %00000000
	db %00000000, %01111111, %11111000, %00000000
	db %00000000, %01111111, %11111100, %00000000
	db %00000000, %11111111, %00000100, %00000000
	db %00000000, %01111100, %00000100, %00000000
	db %00000000, %01111000, %01000100, %00000000
	db %00000000, %00110000, %00010100, %00000000
	db %00000000, %01111000, %00001000, %00000000
	db %00000000, %11001100, %00010000, %00000000
	db %00000000, %10000111, %00100000, %00000000
	db %00000001, %10000111, %11000000, %00000000
	db %00000001, %11000011, %11000000, %00000000
	db %00000001, %11000000, %11000000, %00000000
	db %00000001, %11110000, %11000000, %00000000
	db %00000001, %11111111, %10000000, %00000000
	db %00000001, %11111111, %00000000, %00000000
	db %00000000, %11111110, %00000000, %00000000
	db %00000000, %00001111, %00000000, %00000000
	db %00000000, %01111111, %10000000, %00000000
	db %00000000, %11111111, %10000000, %00000000
	db %00000000, %10011110, %00000000, %00000000
	db %00000000, %10001110, %00000000, %00000000
	db %00000000, %10000100, %00000000, %00000000
	db %00000000, %11111100, %00000000, %00000000
