angular.module('cota').factory 'game', [
	'player', 'lastHitter', 'jungler', 'ganker', 'notifications', 'messages',
	(player,   lastHitter,   jungler,   ganker,   notifications,   messages) ->
		_handleEnemyGankResult = () ->
			result = ganker.attemptEnemyGank()

			if result.success
				messages.fail("You got ganked and took #{result.damage} damage!")
				notifications.fail('ganked!')
				_dealDamage(result.damage)

			return

		_dealDamage = (amount) ->
			player.dealDamage(amount)

			if player.getState() is player.states.DEAD
				messages.fail("You died!")
				notifications.fail('you died!')

			return

		_isDead = () ->
			return player.getState() is player.states.DEAD

		doFarm = () ->
			if _isDead() then return false

			# A chance to get ganked on each farming action
			gankResult = ganker.attemptEnemyGank()
			if gankResult.happened then _handleEnemyGankResult()
			if _isDead() then return false

			result = lastHitter.attempt()
			player.addLastHitAttempt()

			if result.success
				player.addLastHit()
				player.addGold(result.goldGain)
				notifications.success('+' + result.goldGain)
			else
				notifications.fail('missed')

			return true

		doJungle = (type) ->
			if _isDead() then return false

			gankRandom = Math.random()
			if gankRandom < player.data.enemyGank.probability + 0.2
				_doEnemyGank()

			result = jungler.attempt()

			_dealDamage(result.damage)
			if player.getState() is player.states.DEAD
				return

			player.addGold(result.goldGain)

		return {
			doFarm: doFarm
			doJungle: doJungle
		}
]