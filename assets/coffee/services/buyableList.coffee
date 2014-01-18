angular.module('cota').factory 'buyableList', [
	'$injector',
	($injector) ->
		actionList = [
			'gank',
			'jungle'
		]

		itemList = [

		]

		upgradeList = [

		]

		prefixCamelCase = (prefix, value) ->
			return prefix + value.substr(0, 1).toUpperCase() + value.substr(1)

		# Request the services/factories for the listed items above

		actions = actionList.reduce (allActions, action) ->
			serviceName = prefixCamelCase('action', action)
			allActions.concat($injector.get(serviceName).actions)
		, []

		items = itemList.reduce (allItems, item) ->
			serviceName = prefixCamelCase('item', item)
			allItems.concat($injector.get(serviceName).items)
		, []

		upgrades = upgradeList.reduce (allUpgrades, upgrade) ->
			serviceName = prefixCamelCase('upgrade', upgrade)
			allUpgrades.concat($injector.get(serviceName).upgrades)
		, []

		return {
			actions:  actions
			items:    items
			upgrades: upgrades
		}
]