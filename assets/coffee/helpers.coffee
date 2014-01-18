randomBetween = (min, max) ->
	return Math.floor(Math.random() * (max - min) + min)

#! Thanks to http://stackoverflow.com/a/2532251/316944
randomProperty = (object) ->
	result = null
	count = 1

	for prop of object
		if not object.hasOwnProperty(prop) then continue
		if Math.random() < 1/count then result = prop
		count++

	return result

window.helpers =
	randomBetween: randomBetween
	randomProperty: randomProperty