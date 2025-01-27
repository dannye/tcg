MACRO dn
REPT _NARG / 2
	db ((\1) << 4) | (\2)
	SHIFT 2
ENDR
ENDM

MACRO dbw
	db \1
	dw \2
ENDM

MACRO dwb
	dw \1
	db \2
ENDM

MACRO dx
	DEF x = 8 * ((\1) - 1)
	REPT \1
		db ((\2) >> x) & $ff
		DEF x -= 8
	ENDR
ENDM

MACRO dt ; three-byte (big-endian)
	dx 3, \1
ENDM

MACRO dd ; four-byte (big-endian)
	dx 4, \1
ENDM

MACRO bigdw ; big-endian word
	dx 2, \1
ENDM

MACRO sgb
	db (\1) << 3 + (\2) ; sgb_command * 8 + length
ENDM

MACRO rgb
	dw ((\3) << 10 | (\2) << 5 | (\1))
ENDM

; poketcg specific macros below

MACRO textpointer
	dw (((\1) + ($4000 * (BANK(\1) - 1))) - (TextOffsets + ($4000 * (BANK(TextOffsets) - 1)))) & $ffff
	db (((\1) + ($4000 * (BANK(\1) - 1))) - (TextOffsets + ($4000 * (BANK(TextOffsets) - 1)))) >> 16
	const \1_
	EXPORT \1_
ENDM

MACRO energy
	DEF en = 0
	IF _NARG > 1
		REPT _NARG / 2
			DEF x = 4 - 8 * ((\1) % 2)
			DEF en += \2 << (((\1) * 4) + x)
			SHIFT 2
		ENDR
		REPT NUM_TYPES / 2
			db LOW(en)
			DEF en >>= 8
		ENDR
	ELSE
		db 0, 0, 0, 0
	ENDC
ENDM

MACRO gfx
	dw ($4000 * (BANK(\1) - BANK(CardGraphics)) + ((\1) - $4000)) / 8
ENDM

MACRO frame_table
	db BANK(\1) - BANK(AnimData1) ; maybe use better reference for Bank20?
	dw \1
ENDM

MACRO frame_data
	db \1 ; frame index
	db \2 ; anim count
	db \3 ; x translation
	db \4 ; y translation
ENDM

MACRO tx
	dw \1_
ENDM

MACRO textitem
	db \1, \2
	tx \3
ENDM

; cursor x / cursor y / attribute / idx-up / idx-down / idx-right / idx-left
; idx-[direction] means the index to get when the input is in the direction.
; its attribute is used for drawing a flipped cursor.
MACRO cursor_transition
	db \1, \2, \3, \4, \5, \6, \7
ENDM
