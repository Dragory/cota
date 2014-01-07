angular.module('cota').factory 'notifications', [
	'mouse',
	(mouse) ->
		$body = $('body')

		types =
			SUCCESS: 1
			FAIL: 2

		reverseTypes = {}
		for prop, value of types
			reverseTypes[value] = prop

		createNotification = (type, message) ->
			notification = $('<div></div>')
			notification.addClass('notification')
			notification.addClass('notification--' + reverseTypes[type].toLowerCase())
			notification.html(message)

			notification.css {
				left: mouse.x
				top: mouse.y
			}

			$body.append(notification)
			setTimeout () ->
				notification.remove()
			, 1500

		return {
			success: (message) ->
				createNotification(types.SUCCESS, message)

			fail: (message) ->
				createNotification(types.FAIL, message)
		}
]