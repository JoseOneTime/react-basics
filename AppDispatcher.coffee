Dispatcher = require './Dispatcher'

class AppDispatcher extends Dispatcher
	handleViewAction: (action) =>
		@dispatch
			source: 'VIEW_ACTION'
			action

module.exports = AppDispatcher