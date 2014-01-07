angular.module('cota').factory 'sounds', [
	() ->
		$body = $('body')

		soundRoot = './sounds'
		formats = [
			{
				extension: 'mp3'
				type: 'audio/mp3'
			}
			{
				extension: 'ogg'
				type: 'audio/ogg'
			}
		]

		playSound = (path) ->
			fullPath = soundRoot + path

			audioElement = $('<audio></audio>')
			audioElement.addClass('sound-hidden')

			sources = []
			for format in formats
				source = $('<source>')
				source.attr('src', "#{fullPath}.#{format.extension}")
				source.attr('type', format.type)
				sources.push(source)

			audioElement.append(sources)
			audioElement.on 'ended', () -> audioElement.remove()

			$body.append(audioElement)

		return {
			playSound: playSound
		}
]