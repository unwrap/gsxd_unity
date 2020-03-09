
local guai = {

	Attack1 = {
		operation = {
			[35] = {
				fire_bullet = {}
			}
		},
	},

	Attack3 = {
	--only use on boss_magic_plant
		operation = {
			[60] = {
				fire_bullet = {
					weaponid=1008,
					skills={1000004,1000006}
				},
			},
		},
	},
}

return guai
