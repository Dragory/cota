angular.module('cota').factory 'messages', [
	() ->
		return {
			types: {SUCCESS: 1, FAIL: 2}
			success: (message) -> console.log(message)
			fail: (message) -> console.log(message)
		}
]