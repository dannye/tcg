Sfx_Warp_Ch1:
	sfx_pan %00010001
	sfx_loop 2
	sfx_env 14, 1
	sfx_freq $42
	sfx_freq $42
	sfx_freq $42
	sfx_freq $42
	sfx_freq $42
	sfx_freq $42
	sfx_freq $42
	sfx_env 0, 0
	sfx_pitch_offset 0
	sfx_wait 8
	sfx_pitch_offset -1
	sfx_env 14, 1
	sfx_endloop
	sfx_env 14, -7
	sfx_freq $41
	sfx_freq $41
	sfx_freq $41
	sfx_freq $41
	sfx_env 8, -7
	sfx_freq $42
	sfx_freq $42
	sfx_env 4, -7
	sfx_freq $42
	sfx_freq $42
	sfx_end
