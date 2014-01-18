angular.module('cota').factory 'lastHitter', [
	'gameData', 'player',
	(gameData,   player) ->
		_success = (goldGain) ->
			return {success: true, goldGain: goldGain}

		_fail = () ->
			return {success: false}

		attempt = (type) ->
			lastHitRoll = Math.random()
			if lastHitRoll > player.data.lastHitChance
				return _fail()

			creep = gameData.creeps[window.helpers.randomProperty(gameData.creeps)]
			goldGain = Math.floor(Math.random() * (creep.goldMax - creep.goldMin) + creep.goldMin)

			return _success(goldGain)

		return {
			attempt: attempt
		}
]