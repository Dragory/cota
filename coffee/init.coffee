# Initialize angular module
angular.module('cota', ['ngRoute']);

# Initialize game data
window.cota =
	player:
		hero: null
		level: 1

		maxHealth: 640
		maxHealthGain: 50
		health: 640
		respawnTime: 0
		buybackDisabledUntil: 0

		junglingBonus: 0

		kills: 0
		deaths: 0
		lastHitAttempts: 0
		lastHitChance: 0.25
		lastHits: 0
		gold: 0

		items: []
		upgrades: []

		enemyGank:
			probability: 0
			successRate: 0

		ownGank:
			successRate: 0

	# Different creep types
	creeps:
		melee:
			weight: 100
			goldMin: 38
			goldMax: 48
			xp: 62
		ranged:
			weight: 20
			goldMin: 43
			goldMax: 53
		siege:
			weight: 4
			goldMin: 66
			goldMax: 80

	# Different jungle camp types
	jungleCamps:
		easy:
			goldMin: 65
			goldMax: 102
			damage: 400
		medium:
			goldMin: 81
			goldMax: 155
			damage: 800
		hard:
			goldMin: 86
			goldMax: 161
			damage: 1200
		ancients:
			goldMin: 215
			goldMax: 346
			damage: 1600

	items: {}
	upgrades: {}