Sfx_Needles_Ch1:
	sfx_pan %00010001
	sfx_duty 2
	sfx_loop 3
	sfx_env 7, -7
	sfx_freq $77b
	sfx_env 0, 0
	sfx_pitch_offset 0
	sfx_wait 1
	sfx_pitch_offset -1
	sfx_env 7, -7
	sfx_freq $7df
	sfx_env 0, 0
	sfx_pitch_offset 0
	sfx_wait 1
	sfx_pitch_offset -1
	sfx_env 7, -7
	sfx_env 0, 0
	sfx_pitch_offset 0
	sfx_wait 1
	sfx_pitch_offset -1
	sfx_env 7, -7
	sfx_env 0, 0
	sfx_pitch_offset 0
	sfx_wait 10
	sfx_pitch_offset -1
	sfx_env 7, -7
	sfx_endloop
	sfx_end
