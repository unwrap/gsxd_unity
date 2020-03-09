
local guai = {

	Attack2 = {
		operation = {
			[1] = {
				warning = {rebound=5}
			},
			[2] ={
				attack_speed = 0.1
			},
			[50] = {
				attack_speed = 1
			},
			[40] = {
				stop_aim = true
			},
			[65] = {
				fire_bullet = {}
			},
		},
	},

	Attack1 = {
	--only boss
		attack_end = false,
		operation = {
			[90] = {
				fire_bullet = {
					weaponid=4001,
					skills={1000004}
				},
			},
		},
	},

	Attack1_2 = {
		attack_end = false,
		attack_speed = 0.2,
		loop_times = 2,
	},

	Attack1_3 = {
	},
}

return guai
