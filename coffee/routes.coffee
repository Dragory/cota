angular.module('cota').config [
	'$compileProvider',
	($compileProvider) ->
		$compileProvider.aHrefSanitizationWhitelist /^\s*(https?|ftp|mailto|file|tel):/
]

angular.module('cota').config [
	'$routeProvider', '$locationProvider',
	($routeProvider,   $locationProvider) ->
		$routeProvider.when '/messages', {
			templateUrl: './templates/messages.html'
			controller: 'MessagesPageCtrl'
		}

		$routeProvider.otherwise {
			redirectTo: '/messages'
		}

		$locationProvider.html5Mode false
]