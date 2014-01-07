angular.module('cota').factory 'mouse', [
	() ->
		mouse =
			x: 0
			y: 0

		$(window).on 'mousemove', (ev) ->
			mouse.x = ev.pageX
			mouse.y = ev.pageY

		return mouse
]