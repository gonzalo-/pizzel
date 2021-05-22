;
;
; WIP - Pizzel Podcast en asm para atari 6502
;
;
	processor 6502

	include "vcs.h"
	include "macro.h"

VSYNC		equ	0
VBLANK		equ	1
WSYNC		equ	2
COLUBK		equ	9

	seg
	org $F000

Start:
	lda #0
	tax
	txs

.clear
	sta $0,X
	inx
	bne .clear

	lda #$10
	sta 128

kernel_loop: subroutine
	sei
	lda #0
	sta VBLANK
	lda #2
	sta VSYNC
	lda #0
	sta WSYNC
	sta WSYNC
	sta WSYNC
	sta VSYNC

	ldx #45+50
.vblank
	sta WSYNC
	dex
	bne .vblank

	; Color byte in RAM
	lda #20

	sta WSYNC

PIZZEL_ADDR set pizzel
	; 6 Row
	.repeat 6

	ldy #8
apa set .
	; set bg color
	sta 8

	ldx PIZZEL_ADDR
	stx $0D
	ldx PIZZEL_ADDR+1
	stx $0E
	ldx PIZZEL_ADDR+2
	stx $0F

	nop
	nop

	ldx PIZZEL_ADDR+3
	stx $0D
	ldx PIZZEL_ADDR+4
	stx $0E
	ldx PIZZEL_ADDR+5
	stx $0F

	clc
	adc #3

	sta WSYNC

	dey
	bne apa

PIZZEL_ADDR set PIZZEL_ADDR + 6
	.repend

	ldy #0
	sty $D
	sty $E
	sty $F
	sty 10
	sty 9

	ldy #0
	ldx #45-16	; 165-36
.display
	sta WSYNC

	dex
	bne .display

	lda #2
	sta VBLANK

	ldx #36
.overscan
	sta WSYNC
	dex
	bne .overscan

	jmp kernel_loop

pizzel:
	dc.b %11100000,%01011110,%11101111,%00100000,%00000000,%01000000
	dc.b %10100000,%00000010,%00101000,%00100000,%00011111,%01000011
	dc.b %11100000,%01000100,%01100100,%00100000,%00001111,%01000001
	dc.b %00100000,%01001000,%00100010,%00100000,%00000101,%01000000
	dc.b %00100000,%01010000,%00100001,%00100000,%00000011,%00000000
	dc.b %00100000,%01011110,%11101111,%11100000,%00000001,%01000000
	dc.b %00000000,%00000000,%00000000,%00000000,%00000000,%00000000

	org $FFFC

	word Start
	word Start
