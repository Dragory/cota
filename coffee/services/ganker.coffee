angular.module('cota').factory 'ganker', [
	'player',
	(player) ->
		_noGank = () ->
			return {happened: false}

		_success = (damage) ->
			return {happened: true, success: true, damage: damage}

		_fail = () ->
			return {happened: true, success: false}

		attemptEnemyGank = () =>
			gankRoll = Math.random()
			if gankRoll > player.data.enemyGank.probability then return _noGank()

			gankSuccessRoll = Math.random()
			if gankSuccessRoll > player.data.enemyGank.successRate then return _fail()

			damageMin = player.data.level * 60
			damageMax = player.data.level * 100
			damage = Math.floor(Math.random() * (damageMax - damageMin) + damageMin)

			return _success(damage)
]