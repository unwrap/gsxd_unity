
local guai = {

	Attack1 = {
		operation = {
			[20] = {
				melee_attack = true
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
			[50] = {
				melee_attack = true
			},
			[70] = {
				melee_attack = false
			}
		},
	},

	Attack4 = {
		operation = {
			[35] = {
				melee_attack = true
			},
			[65] = {
				melee_attack = false
			}
		},
	},

	Attack_bow = {
		attack_speed = 2,
		operation = {
			[75] = {
				fire_bullet = {}
			}
		},
	},

	Attack_gun = {
		--attack_speed = 2,
		operation = {
			[30] = {
				fire_bullet = {}
				--fire_bullet = {skills={10001,1002},flySpeed=20}
			}
		},
	},
}

return guai
