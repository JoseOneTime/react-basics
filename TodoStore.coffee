AppDispatcher = require './AppDispatcher'
EventEmitter = require('events').EventEmitter
TodoConstants = require './TodoConstants'
merge = require 'react/lib/merge'

CHANGE_EVENT = 'change'


_todos = {}

create = (text) ->
	# the tutorial admits this part is under-developed
	id = Date.now()
	_todos[id] = {id, complete: false, text}

update = (id, updates) -> _todos[id] = merge _todos[id], updates

updateAll = (updates) -> update id, updates for id of _todos

destroy = (id) -> delete _todos[id]

destroyCompleted = -> destroy id if _todos[id].complete for id of _todos


class TodoStore extends EventEmitter
	areAllComplete: =>
		return false unless _todos[id].complete for id of _todos
		return true

	getAll: => _todos

	emitChange: => @emit CHANGE_EVENT

	addChangeListener: (callback) => @on CHANGE_EVENT, callback

	removeChangeListener: (callback) => @removeListener CHANGE_EVENT, callback


AppDispatcher.register (payload) ->
	action = payload.action

	switch action.actionType

		when TodoConstants.TODO_CREATE
			text = action.text.trim()
			create text unless text is ''	

		when TodoConstants.TODO_TOGGLE_COMPLETE_ALL
			complete = not TodoStore.areAllComplete
			updateAll {complete}

		when TodoConstants.TODO_UNDO_COMPLETE
			update action.id, {complete: false}

		when TodoConstants.TODO_COMPLETE
			update action.id, {complete: true}

		when TodoConstants.TODO_UPDATE_TEXT
			text = action.text.trim()
			update action.id, {text} unless text is ''

		when TodoConstants.TODO_DESTROY
			destroy action.id

		when TodoConstants.TODO_DESTROY_COMPLETED
			destroyCompleted()

		else
			return true

	TodoStore.emitChange()
	true

module.exports = TodoStore