angular.module('cota').factory 'jungler', [
	'gameData',
	(gameData) ->
		attempt = (type) ->
			camp = gameData.jungleCamps[type]
			if not camp? then return null

			goldGain = Math.floor(Math.random() * (camp.goldMax - camp.goldMin) + camp.goldMin)
			damage = camp.damage * (1 - gameData.player.jungleBonus)

			return {
				goldGain: goldGain
				damage: damage
			}
]