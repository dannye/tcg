Sfx_Lure_Ch1:
	sfx_pan %00010001
	sfx_env 15, -7
	sfx_duty 0
	sfx_env 0, 0
	sfx_pitch_offset 0
	sfx_wait 8
	sfx_pitch_offset -1
	sfx_env 15, -7
	sfx_loop 4
	sfx_freq $7df
	sfx_pitch_offset 0
	sfx_wait 1
	sfx_freq $7db
	sfx_wait 1
	sfx_endloop
	sfx_pan %00010001
	sfx_env 8, -7
	sfx_duty 0
	sfx_loop 4
	sfx_freq $7df
	sfx_wait 1
	sfx_freq $7db
	sfx_wait 1
	sfx_endloop
	sfx_pan %00010001
	sfx_env 4, -7
	sfx_duty 0
	sfx_loop 4
	sfx_freq $7df
	sfx_wait 1
	sfx_freq $7db
	sfx_wait 1
	sfx_endloop
	sfx_pan %00010001
	sfx_env 1, -7
	sfx_duty 0
	sfx_loop 4
	sfx_freq $7df
	sfx_wait 1
	sfx_freq $7db
	sfx_wait 1
	sfx_endloop
	sfx_end
