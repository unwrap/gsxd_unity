
local guai = {

	Attack1 = {
		operation = {
			[15] = {
				move_speed = 5,
			},
			[20] = {
				melee_attack = true
			},
			[39] = {
				move_speed = 0
			},
			[40] = {
				melee_attack = false
			}
		},
	},

	Attack2 = {
		operation = {
			[50] = {
				melee_attack = true
			},
			[80] = {
				melee_attack = false
			}
		},
	},

	Attack3 = {
		operation = {
			[28] = {
				move_speed = 5,
				jump_speed = 2
			},
			[50] = {
				melee_attack = true
			},
			[60] = {
				move_speed = 0
			},
			[70] = {
				melee_attack = false
			}
		},
	},

}

return guai
