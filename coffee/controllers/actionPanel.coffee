angular.module('cota').controller 'actionPanel', [
	'game', 'player',
	(game,   player) ->
		$scope.game = game
		$scope.playerData = player.data
]	