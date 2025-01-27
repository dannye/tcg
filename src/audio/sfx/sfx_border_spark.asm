Sfx_BorderSpark_Ch1:
	sfx_pan %00010001
	sfx_env 6, 1
	sfx_loop 2
	sfx_freq $f
	sfx_env 0, 0
	sfx_pitch_offset 0
	sfx_wait 1
	sfx_pitch_offset -1
	sfx_env 6, 1
	sfx_freq $2d
	sfx_env 0, 0
	sfx_pitch_offset 0
	sfx_wait 1
	sfx_pitch_offset -1
	sfx_env 6, 1
	sfx_endloop
	sfx_env 8, 1
	sfx_freq $f
	sfx_env 0, 0
	sfx_pitch_offset 0
	sfx_wait 1
	sfx_pitch_offset -1
	sfx_env 8, 1
	sfx_env 4, 1
	sfx_freq $2d
	sfx_env 0, 0
	sfx_pitch_offset 0
	sfx_wait 1
	sfx_pitch_offset -1
	sfx_env 4, 1
	sfx_env 2, 1
	sfx_freq $f
	sfx_end
