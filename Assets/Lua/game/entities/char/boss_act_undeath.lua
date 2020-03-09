

local guai = {

	Attack2 = {
		operation = {
			[1] = {
				warning = {rebound=2}
				--warning_end = {}
			},
			[65] = {
				fire_bullet = {}
			},
		},
	},

	Attack3 = {
		operation = {
			[1] = {
				warning = {}
			},
			[2] ={
				attack_speed = 0.5
			},
			[50] = {
				attack_speed = 1
			},
			[51] = {
				stop_aim = true
			},
			[60] = {
				fire_bullet = {
					weaponid=1010,
					skills={2000021}
				},
			},
		},
	},
}

return guai
