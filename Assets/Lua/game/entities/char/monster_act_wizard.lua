

local guai = {

	Attack3 = {
		operation = {
			[60] = {
				fire_bullet = {}
			},
		},
	},

	Attack2 = {
	--only on boss
		operation = {
			[65] = {
				fire_bullet = {
					weaponid=2021,
					skills={1000003}
				}
			},
		},
	},
}

return guai
