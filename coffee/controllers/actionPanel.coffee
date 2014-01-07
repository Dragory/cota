angular.module('cota').controller 'actionPanelCtrl', [
	'$scope', 'game', 'player',
	($scope,   game,   player) ->
		$scope.template =
			url: './templates/actionPanel.html'

		$scope.game = game
		$scope.playerData = player.data

		$scope.farm = () ->
			game.doFarm()

		setTimeout () ->
			$scope.$apply () ->
				player.addGold(200)
		, 1000
]