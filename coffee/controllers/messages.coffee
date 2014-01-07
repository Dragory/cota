angular.module('cota').controller 'messagesCtrl', [
	'$scope', 'messages',
	($scope,   messages) ->
		$scope.messageTypes = messages.types

		$scope.messages = [
			{type: messages.types.SUCCESS, message: "Test"}
			{type: messages.types.SUCCESS, message: "Another test"}
		]
]	