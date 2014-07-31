{React, D} = require './react-etc'
TodoActions = require './TodoActions'
TodoTextInput = require './TodoTextInput'
cx = require 'react/lib/cx'

TodoItem = React.createClass
	propTypes:
		todo: React.PropTypes.object.isRequired

	getInitialState: -> {isEditing: false}

	render: ->
		if @state.isEditing
			input = TodoTextInput {
				className: 'edit'
				onSave: @_onSave
				value: todo.text
			}

		D.li {
			className: cx(
					completed: todo.complete
					editing: @state.isEditing
				)
			key: todo.id
		},
			D.div {className: 'view'},
				D.input {
					className: 'toggle'
					type: 'checkbox'
					checked: todo.complete
					onChange: @_onToggleComplete
				}
				D.label {onDoubleClick: @_onDoubleClick}, todo.text
				D.button {className: 'destroy', onClick: @_onDestroyClick}
			input

	_onToggleComplete: -> TodoActions.toggleComplete @props.todo

	_onDoubleClick: -> @setState {isEditing: true}

	_onSave: (text) ->
		TodoActions.updateText @props.todo.id, text
		@setState {isEditing: false}

	_onDestroyClick: -> TodoActions.destroy @props.todo.id

module.exports = TodoItem