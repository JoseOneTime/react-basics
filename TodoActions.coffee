dispatch = require('./AppDispatcher').handleViewAction
TodoConstants = require './TodoConstants'


TodoActions = 
	create: (text) -> dispatch
		actionType: TodoConstants.TODO_CREATE
		text

	updateText: (id, text) -> dispatch
		actionType: TodoConstants.TODO_UPDATE_TEXT
		id
		text

	toggleComplete: (todo) ->
		actionType = todo.complete ? TodoConstants.TODO_UNDO_COMPLETE : TodoConstants.TODO_COMPLETE
		dispatch
			actionType
			id: todo.id

	toggleCompleteAll: -> dispatch
		actionType: TodoConstants.TODO_TOGGLE_COMPLETE_ALL

	destroy: (id) -> dispatch
		actionType: TodoConstants.TODO_DESTROY
		id

	destroyCompleted: -> dispatch
		actionType: TodoConstants.TODO_DESTROY_COMPLETED

module.exports = TodoActions