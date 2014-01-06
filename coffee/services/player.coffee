angular.module('cota').factory 'player', [
	'gameData',
	(gameData) ->
		player = gameData.player
		respawnTimeout = null
		states =
			ALIVE: 1
			DEAD: 2

		# 
		# State
		# 

		getState = () ->
			if player.health <= 0
				return states.DEAD
			else
				return states.ALIVE

		# 
		# Damage
		# 

		dealDamage = (damage) ->
			player.health = Math.max(player.health - damage, 0)

			if player.health <= 0
				player.die()

			return player.health

		heal = (amount) ->
			player.health = Math.min(player.health + amount, player.maxHealth)
			return player.health

		#
		# Dying and respawning
		# 

		die = () ->
			takeGold(player.level * 30)

			player.respawnTime = (player.level * 4 + player.buybackRespawnPenalty) * 1000 + (new Date).getTime()
			player.buybackRespawnPenalty = 0

			respawnTimeout = setTimeout respawn, player.respawnTime
			return

		buyback = () ->
			if player.buybackDisabledUntil > (new Date).getTime()
				return false

			# Just assume game time 30, it's not really relevant here
			buybackCost = 100 + (player.level * 1.5) + (30 * 15)

			if player.gold < buybackCost
				return false

			takeGold(buybackCost)
			respawn()

		respawn = () ->
			clearTimeout(respawnTimeout)
			player.health = player.maxHealth
			return

		#
		# Gold
		# 

		addGold = (amount) ->
			player.gold += amount
			return player.gold

		takeGold = (amount) ->
			player.gold = Math.max(player.gold - amount, 0)
			return player.gold

		#
		# Last hitting
		# 

		addLastHitAttempt = (amount = 1) ->
			player.lastHitAttempts += amount
			return player.lastHitAttempts

		addLastHit = (amount = 1) ->
			player.lastHits += amount
			return player.lastHits

		return {
			data: player

			states: states
			checkState: checkState
			dealDamage: dealDamage
			heal: heal
			die: die
			buyback: buyback
			respawn: respawn
			addGold: addGold
			takeGold: takeGold
			addLastHitAttempt: addLastHitAttempt
			addLastHits: addLastHits
		}
]