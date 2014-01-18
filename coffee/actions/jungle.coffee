angular.module('cota').factory 'actionJungle', [
	'gameData',
	(gameData) ->
		attemptJungle = (type) ->
			camp = gameData.jungleCamps[type]
			if not camp? then return null

			goldGain = Math.floor(Math.random() * (camp.goldMax - camp.goldMin) + camp.goldMin)
			damage = camp.damage * (1 - gameData.player.jungleBonus)

			return {
				goldGain: goldGain
				damage: damage
			}

		return {
			actions: [
				{
					name: "Jungle (small camp)"
					description: "ez"
					execute: () -> return attemptJungle('easy')
				}
				{
					name: "Jungle (medium camp)"
					description: "a bit less ez"
					execute: () -> return attemptJungle('medium')
				}
				{
					name: "Jungle (large camp)"
					description: "not so ez"
					execute: () -> return attemptJungle('hard')
				}
			]
		}
]