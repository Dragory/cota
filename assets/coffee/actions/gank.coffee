angular.module('cota').factory 'actionGank', [
	'player',
	(player) ->
		attemptGank = () ->
			return {
				success: true
				message: "Gank successful"
				result:
					gold: 200
			}

		return {
			actions: [
				{
					name: "Gank"
					description: "omg no ss noob"
					execute: attemptGank
				}
			]
		}
]