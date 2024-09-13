class_name AK

class EVENTS:

	const COIN = 3603273110
	const ENEMYLAZERBLAST = 4011402401
	const MUSIC = 3991942870
	const PLAYERMELEE = 4225616770
	const ENEMYMELEE = 1731774001
	const PLAYERLEFTFOOT = 2424622641
	const JUMP = 3833651337
	const ENEMYFLAMEBREATH = 3193916302
	const PLAYERHIT = 3831688773
	const PLAYERDEATH = 1656947812
	const PLAYERICEBLAST = 261543715
	const PLAYERRIGHTFOOT = 51740264

	const _dict = {
		"Coin": COIN,
		"EnemyLazerBlast": ENEMYLAZERBLAST,
		"Music": MUSIC,
		"PlayerMelee": PLAYERMELEE,
		"EnemyMelee": ENEMYMELEE,
		"PlayerLeftFoot": PLAYERLEFTFOOT,
		"Jump": JUMP,
		"EnemyFlameBreath": ENEMYFLAMEBREATH,
		"PlayerHit": PLAYERHIT,
		"PlayerDeath": PLAYERDEATH,
		"PlayerIceBlast": PLAYERICEBLAST,
		"PlayerRightFoot": PLAYERRIGHTFOOT
	}

class STATES:

	class GAMESTATE:
		const GROUP = 4091656514

		class STATE:
			const NONE = 748895195
			const LEVEL = 2782712965
			const MAINMENU = 3604647259
			const GAMEOVER = 4158285989

	const _dict = {
		"Gamestate": {
			"GROUP": 4091656514,
			"STATE": {
				"None": 748895195,
				"Level": 2782712965,
				"MainMenu": 3604647259,
				"GameOver": 4158285989
			}
		}
	}

class SWITCHES:

	class PLAYERHEALTH:
		const GROUP = 151362964

		class SWITCH:
			const OVER50HP = 502123208
			const UNDER50HP = 193829906

	const _dict = {
		"PlayerHealth": {
			"GROUP": 151362964,
			"SWITCH": {
				"Over50Hp": 502123208,
				"Under50Hp": 193829906
			}
		}
	}

class GAME_PARAMETERS:

	const SS_AIR_TIMEOFDAY = 3203397129
	const SS_AIR_STORM = 3715662592
	const SOUNDVOLUME = 3873835272
	const SS_AIR_PRESENCE = 3847924954
	const ANNOYANCEVOLUME = 2948158961
	const SS_AIR_TURBULENCE = 4160247818
	const SS_AIR_SIZE = 3074696722
	const SS_AIR_FEAR = 1351367891
	const SS_AIR_FREEFALL = 3002758120
	const SS_AIR_FURY = 1029930033
	const SS_AIR_RPM = 822163944
	const SS_AIR_MONTH = 2648548617
	const PAUSEDLOWPASS = 2369900608
	const MUSICVOLUME = 2346531308

	const _dict = {
		"SS_Air_TimeOfDay": SS_AIR_TIMEOFDAY,
		"SS_Air_Storm": SS_AIR_STORM,
		"SoundVolume": SOUNDVOLUME,
		"SS_Air_Presence": SS_AIR_PRESENCE,
		"AnnoyanceVolume": ANNOYANCEVOLUME,
		"SS_Air_Turbulence": SS_AIR_TURBULENCE,
		"SS_Air_Size": SS_AIR_SIZE,
		"SS_Air_Fear": SS_AIR_FEAR,
		"SS_Air_Freefall": SS_AIR_FREEFALL,
		"SS_Air_Fury": SS_AIR_FURY,
		"SS_Air_RPM": SS_AIR_RPM,
		"SS_Air_Month": SS_AIR_MONTH,
		"PausedLowPass": PAUSEDLOWPASS,
		"MusicVolume": MUSICVOLUME
	}

class TRIGGERS:

	const _dict = {}

class BANKS:

	const INIT = 1355168291
	const SOUNDBANK1 = 1647770721

	const _dict = {
		"Init": INIT,
		"Soundbank1": SOUNDBANK1
	}

class BUSSES:

	const MASTER_AUDIO_BUS = 3803692087

	const _dict = {
		"Master Audio Bus": MASTER_AUDIO_BUS
	}

class AUX_BUSSES:

	const _dict = {}

class AUDIO_DEVICES:

	const NO_OUTPUT = 2317455096
	const SYSTEM = 3859886410

	const _dict = {
		"No_Output": NO_OUTPUT,
		"System": SYSTEM
	}

class EXTERNAL_SOURCES:

	const _dict = {}

