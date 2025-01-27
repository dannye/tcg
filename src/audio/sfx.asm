SFX_PlaySFX:
	jp SFX_Play

SFX_UpdateSFX:
	jp SFX_Update

SFX_Play:
	ld hl, NumberOfSFX
	cp [hl]
	jr nc, .invalidID
	add a
	ld c, a
	ld b, $0
	ld a, [wSFXIsPlaying]
	or a
	jr z, .no_sfx_playing
	call Func_fc279
.no_sfx_playing
	ld a, TRUE
	ld [wSFXIsPlaying], a
	ld hl, SFXHeaderPointers
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [hli]
	ld [wdd8c], a
	ld [wde54], a
	ld de, wSFXCommandPointers
	ld c, $0
.loop_cmd_ptrs
	ld a, [wde54]
	rrca
	ld [wde54], a
	jr nc, .skip_cmd_ptr
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	push hl
	ld hl, wSFXPitchOffsets
	add hl, bc
	ld [hl], $0
	ld hl, wde33
	add hl, bc
	ld [hl], $1
	pop hl
	jr .next_cmd_ptr
.skip_cmd_ptr
	inc de
	inc de
.next_cmd_ptr
	inc c
	ld a, $4
	cp c
	jr nz, .loop_cmd_ptrs
.invalidID
	ret

SFX_Update:
	ld a, [wdd8c]
	or a
	jr nz, .asm_fc063
	call Func_fc26c
	ret
.asm_fc063
	xor a
	ld b, a
	ld c, a
	ld a, [wdd8c]
	ld [wde54], a
.asm_fc06c
	ld hl, wde54
	ld a, [hl]
	rrca
	ld [hl], a
	jr nc, .asm_fc08d
	ld hl, wde33
	add hl, bc
	ld a, [hl]
	dec a
	jr z, .asm_fc082
	ld [hl], a
	call SFX_ApplyPitchOffset
	jr .asm_fc08d
.asm_fc082
	ld hl, wSFXCommandPointers
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call ExecuteNextSFXCommand
.asm_fc08d
	inc c
	ld a, c
	cp $4
	jr nz, .asm_fc06c
	ret

ExecuteNextSFXCommand:
	ld a, [hl]
	and $f0
	swap a
	add a
	ld e, a
	ld d, $0
	ld a, [hli]
	push hl
	and $f
	ld hl, SFX_CommandTable
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld h, d
	ld l, e
	jp hl

SFX_CommandTable:
	dw SFX_frequency
	dw SFX_envelope
	dw SFX_duty
	dw SFX_loop
	dw SFX_endloop
	dw SFX_pitch_offset
	dw SFX_wait
	dw SFX_wave
	dw SFX_pan
	dw SFX_unused
	dw SFX_unused
	dw SFX_unused
	dw SFX_unused
	dw SFX_unused
	dw SFX_unused
	dw SFX_end

SFX_unused:
	jp ExecuteNextSFXCommand

SFX_frequency:
	ld d, a ; high
	pop hl
	ld a, [hli] ; low
	ld e, a
	push hl
	ld hl, wde37
	add hl, bc
	add hl, bc
	push bc
	ld b, [hl]
	ld [hl], e
	inc hl
	ld [hl], d
	ld a, c
	cp $3
	jr nz, .not_noise_channel
	ld a, b
	xor e
	and $8
	swap a
	ld d, a
.not_noise_channel
	pop bc
	ld hl, wde2b
	add hl, bc
	ld a, [hl]
	ld [hl], $0
	or d
	ld d, a
	ld hl, rNR11
	ld a, c
	add a
	add a
	add c
	add l
	ld l, a
	ld a, [hl]
	and $c0
	ld [hli], a
	inc hl
	ld a, e
	ld [hli], a
	ld [hl], d
	pop de
Func_fc105:
	ld hl, wSFXCommandPointers
	add hl, bc
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], d
	ret

SFX_envelope:
	ld hl, wde2b
	add hl, bc
	ld a, $80
	ld [hl], a
	pop hl
	ld a, [hli]
	ld e, a
	push hl
	ld hl, rNR12
	ld a, c
	add a
	add a
	add c
	add l
	ld l, a
	ld [hl], e
	pop hl
	jp ExecuteNextSFXCommand

SFX_duty:
	swap a
	ld e, a
	ld hl, rNR11
	ld a, c
	add a
	add a
	add c
	add l
	ld l, a
	ld [hl], e
	pop hl
	jp ExecuteNextSFXCommand

SFX_loop:
	ld hl, wde43
	add hl, bc
	add hl, bc
	pop de
	ld a, [de]
	inc de
	ld [hl], e
	inc hl
	ld [hl], d
	ld hl, wde3f
	add hl, bc
	ld [hl], a
	ld l, e
	ld h, d
	jp ExecuteNextSFXCommand

SFX_endloop:
	ld hl, wde3f
	add hl, bc
	ld a, [hl]
	dec a
	jr z, .asm_fc162
	ld [hl], a
	ld hl, wde43
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop de
	jp ExecuteNextSFXCommand
.asm_fc162
	pop hl
	jp ExecuteNextSFXCommand

SFX_pitch_offset:
	ld hl, wSFXPitchOffsets
	add hl, bc
	ld e, l
	ld d, h
	pop hl
	ld a, [hli]
	ld [de], a
	jp ExecuteNextSFXCommand

SFX_wait:
	ld a, c
	cp $3
	jr nz, .not_noise_channel
	call Func_fc1cd
	jr .applied_pitch_offset
.not_noise_channel
	call SFX_ApplyPitchOffset
.applied_pitch_offset
	ld hl, wde33
	add hl, bc
	ld e, l
	ld d, h
	pop hl
	ld a, [hli]
	ld [de], a
	ld e, l
	ld d, h
	jp Func_fc105

SFX_ApplyPitchOffset:
	ld hl, wSFXPitchOffsets
	add hl, bc
	ld a, [hl]
	or a
	jr z, .no_pitch_offset
	ld hl, wde37
	add hl, bc
	add hl, bc
	bit 7, a
	jr z, .positive
; negative
	xor $ff ; cpl
	inc a
	ld d, a
	ld a, [hl]
	sub d
	ld [hli], a
	ld e, a
	ld a, [hl]
	sbc b ; b is 0
	jr .got_result
.positive
	ld d, a
	ld a, [hl]
	add d
	ld [hli], a
	ld e, a
	ld a, [hl]
	adc b
.got_result
	ld [hl], a
	ld hl, wde2b
	add hl, bc
	ld d, [hl]
	ld [hl], $0
	or d
	ld d, a
	ld hl, rNR11
	ld a, c
	add a
	add a
	add c
	add l
	ld l, a
	ld a, [hl]
	and $c0
	ld [hli], a
	inc hl
	ld a, e
	ld [hli], a
	ld [hl], d
.no_pitch_offset
	ret

Func_fc1cd:
	ld hl, wde32
	ld a, [hl]
	or a
	jr z, .no_pitch_offset
	ld hl, wde3d
	bit 7, a
	jr z, .positive
	xor $ff ; cpl
	inc a
	ld d, a
	ld e, [hl]
	ld a, e
	sub d
	ld [hl], a
	jr .asm_fc1ea
.positive
	ld d, a
	ld e, [hl]
	ld a, e
	add d
	ld [hl], a
.asm_fc1ea
	ld d, a
	xor e
	and $8
	swap a
	ld hl, wde2e
	ld e, [hl]
	ld [hl], $0
	or e
	ld e, a
	ld hl, rNR41
	xor a
	ld [hli], a
	inc hl
	ld a, d
	ld [hli], a
	ld [hl], e
.no_pitch_offset
	ret

SFX_wave:
	add a
	ld d, $0
	ld e, a
	ld hl, SFX_WaveInstruments
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, $0
	ldh [rNR30], a
	ld b, d
	ld de, $ff30
.asm_fc215
	ld a, [hli]
	ld [de], a
	inc de
	inc b
	ld a, b
	cp $10
	jr nz, .asm_fc215
	ld a, $1
	ld [wMusicWaveChange], a
	ld a, $80
	ldh [rNR30], a
	ld b, $0
	pop hl
	jp ExecuteNextSFXCommand

SFX_pan:
	pop hl
	ld a, [hli]
	push hl
	push bc
	inc c
	ld e, %11101110
.loop_rotate_masks
	dec c
	jr z, .got_masks
	rlca
	rlc e
	jr .loop_rotate_masks
.got_masks
	ld d, a
	ld hl, wdd85
	ld a, [hl]
	and e
	or d
	ld [hl], a
	pop bc
	pop hl
	jp ExecuteNextSFXCommand

SFX_end:
	ld e, c
	inc e
	ld a, $7f
.asm_fc24d
	rlca
	dec e
	jr nz, .asm_fc24d
	ld e, a
	ld a, [wdd8c]
	and e
	ld [wdd8c], a
	ld a, c
	rlca
	rlca
	add c
	ld e, a
	ld d, b ; 0
	ld hl, rNR12
	add hl, de
	ld a, $8
	ld [hli], a
	inc hl
	swap a
	ld [hl], a
	pop hl
	ret

Func_fc26c:
	xor a
	ld [wSFXIsPlaying], a
	ld [wSfxPriority], a
	ld a, $80
	ld [wCurSfxID], a
	ret

Func_fc279:
	ld a, $8
	ldh a, [rNR12]
	ldh a, [rNR22]
	ldh a, [rNR32]
	ldh a, [rNR42]
	ld a, $80
	ldh a, [rNR14]
	ldh a, [rNR24]
	ldh a, [rNR44]
	xor a
	ld [wdd8c], a
	ret

INCLUDE "audio/sfx_headers.asm"

SFX_WaveInstruments:
INCLUDE "audio/wave_instruments.asm"

INCLUDE "audio/sfx/sfx_cursor.asm"
INCLUDE "audio/sfx/sfx_confirm.asm"
INCLUDE "audio/sfx/sfx_cancel.asm"
INCLUDE "audio/sfx/sfx_denied.asm"
INCLUDE "audio/sfx/sfx_unused_05.asm"
INCLUDE "audio/sfx/sfx_unused_06.asm"
INCLUDE "audio/sfx/sfx_card_shuffle.asm"
INCLUDE "audio/sfx/sfx_place_prize.asm"
INCLUDE "audio/sfx/sfx_unused_09.asm"
INCLUDE "audio/sfx/sfx_unused_0a.asm"
INCLUDE "audio/sfx/sfx_coin_toss.asm"
INCLUDE "audio/sfx/sfx_warp.asm"
INCLUDE "audio/sfx/sfx_unused_0d.asm"
INCLUDE "audio/sfx/sfx_unused_0e.asm"
INCLUDE "audio/sfx/sfx_pokemon_dome_doors.asm"
INCLUDE "audio/sfx/sfx_legendary_cards.asm"
INCLUDE "audio/sfx/sfx_glow.asm"
INCLUDE "audio/sfx/sfx_paralysis.asm"
INCLUDE "audio/sfx/sfx_sleep.asm"
INCLUDE "audio/sfx/sfx_confusion.asm"
INCLUDE "audio/sfx/sfx_poison.asm"
INCLUDE "audio/sfx/sfx_single_hit.asm"
INCLUDE "audio/sfx/sfx_big_hit.asm"
INCLUDE "audio/sfx/sfx_thunder_shock.asm"
INCLUDE "audio/sfx/sfx_lightning.asm"
INCLUDE "audio/sfx/sfx_border_spark.asm"
INCLUDE "audio/sfx/sfx_big_lightning.asm"
INCLUDE "audio/sfx/sfx_small_flame.asm"
INCLUDE "audio/sfx/sfx_big_flame.asm"
INCLUDE "audio/sfx/sfx_fire_spin.asm"
INCLUDE "audio/sfx/sfx_dive_bomb.asm"
INCLUDE "audio/sfx/sfx_water_jets.asm"
INCLUDE "audio/sfx/sfx_water_gun.asm"
INCLUDE "audio/sfx/sfx_whirlpool.asm"
INCLUDE "audio/sfx/sfx_hydro_pump.asm"
INCLUDE "audio/sfx/sfx_blizzard.asm"
INCLUDE "audio/sfx/sfx_psychic.asm"
INCLUDE "audio/sfx/sfx_leer.asm"
INCLUDE "audio/sfx/sfx_beam.asm"
INCLUDE "audio/sfx/sfx_hyper_beam.asm"
INCLUDE "audio/sfx/sfx_rock_throw.asm"
INCLUDE "audio/sfx/sfx_stone_barrage.asm"
INCLUDE "audio/sfx/sfx_punch.asm"
INCLUDE "audio/sfx/sfx_stretch_kick.asm"
INCLUDE "audio/sfx/sfx_slash.asm"
INCLUDE "audio/sfx/sfx_sonicboom.asm"
INCLUDE "audio/sfx/sfx_fury_swipes.asm"
INCLUDE "audio/sfx/sfx_drill.asm"
INCLUDE "audio/sfx/sfx_pot_smash.asm"
INCLUDE "audio/sfx/sfx_bonemerang.asm"
INCLUDE "audio/sfx/sfx_seismic_toss.asm"
INCLUDE "audio/sfx/sfx_needles.asm"
INCLUDE "audio/sfx/sfx_white_gas.asm"
INCLUDE "audio/sfx/sfx_powder.asm"
INCLUDE "audio/sfx/sfx_goo.asm"
INCLUDE "audio/sfx/sfx_bubbles.asm"
INCLUDE "audio/sfx/sfx_string_shot.asm"
INCLUDE "audio/sfx/sfx_boyfriends.asm"
INCLUDE "audio/sfx/sfx_lure.asm"
INCLUDE "audio/sfx/sfx_toxic.asm"
INCLUDE "audio/sfx/sfx_confuse_ray.asm"
INCLUDE "audio/sfx/sfx_sing.asm"
INCLUDE "audio/sfx/sfx_supersonic.asm"
INCLUDE "audio/sfx/sfx_petal_dance.asm"
INCLUDE "audio/sfx/sfx_protect.asm"
INCLUDE "audio/sfx/sfx_barrier.asm"
INCLUDE "audio/sfx/sfx_speed.asm"
INCLUDE "audio/sfx/sfx_whirlwind.asm"
INCLUDE "audio/sfx/sfx_cry.asm"
INCLUDE "audio/sfx/sfx_question_mark.asm"
INCLUDE "audio/sfx/sfx_selfdestruct.asm"
INCLUDE "audio/sfx/sfx_big_selfdestruct.asm"
INCLUDE "audio/sfx/sfx_heal.asm"
INCLUDE "audio/sfx/sfx_drain.asm"
INCLUDE "audio/sfx/sfx_dark_gas.asm"
INCLUDE "audio/sfx/sfx_healing_wind.asm"
INCLUDE "audio/sfx/sfx_bench_whirlwind.asm"
INCLUDE "audio/sfx/sfx_expand.asm"
INCLUDE "audio/sfx/sfx_cat_punch.asm"
INCLUDE "audio/sfx/sfx_thunder_wave.asm"
INCLUDE "audio/sfx/sfx_firegiver.asm"
INCLUDE "audio/sfx/sfx_thunderpunch.asm"
INCLUDE "audio/sfx/sfx_fire_punch.asm"
INCLUDE "audio/sfx/sfx_coin_toss_heads.asm"
INCLUDE "audio/sfx/sfx_coin_toss_tails.asm"
INCLUDE "audio/sfx/sfx_save_game.asm"
INCLUDE "audio/sfx/sfx_player_walk_map.asm"
INCLUDE "audio/sfx/sfx_intro_orb.asm"
INCLUDE "audio/sfx/sfx_intro_orb_swoop.asm"
INCLUDE "audio/sfx/sfx_intro_orb_title.asm"
INCLUDE "audio/sfx/sfx_intro_orb_scatter.asm"
INCLUDE "audio/sfx/sfx_firegiver_start.asm"
INCLUDE "audio/sfx/sfx_receive_card_pop.asm"
INCLUDE "audio/sfx/sfx_pokemon_evolution.asm"
INCLUDE "audio/sfx/sfx_unused_5f.asm"
