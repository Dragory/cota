angular.module('cota').factory 'game', [
	'player', 'lastHitter', 'buyableList', 'notifications', 'messages',
	(player,   lastHitter,   buyableList,   notifications,   messages) ->
		_isDead = () ->
			return player.getState() is player.states.DEAD

		# The main action
		doFarm = () ->
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

		# Attempts to execute the requested action
		executeAction = (actionIndex) ->
			console.log(buyableList.actions[actionIndex])

		# Attempts to buy the requested item
		buyItem = (itemIndex) ->
			console.log(buyableList.items[itemIndex])

		# Attempts to buy the requested upgrade
		buyUpgrade = (upgradeIndex) ->
			console.log(buyableList.upgrades[upgradeIndex])

		return {
			doFarm:        doFarm
			executeAction: executeAction
			buyItem:       buyItem
			buyUpgrade:    buyUpgrade
		}
]