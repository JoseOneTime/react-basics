{React, D} = require './react-etc'
TodoActions = require './TodoActions'
TodoItem = require './TodoItem'
_ = require './utils'


MainSection = React.createClass
	propTypes:
		allTodos: React.PropTypes.object.isRequired
		areAllComplete: React.PropTypes.bool.isRequired

	render: ->
		allTodos = @props.allTodos

		return null if _.numKeys(allTodos) < 1

		todos = []
		for key of allTodos
			todos.push TodoItem {
					key
					todo: allTodos[key]
				}

		D.section {id: 'main'},
			D.input {
				id: 'toggle-all'
				type: 'checkbox'
				onChange: -> TodoActions.toggleCompleteAll()
				checked: if @props.areAllComplete then 'checked' else ''
			}
			D.label {htmlFor: 'toggle-all'}, 'Mark all as complete'
			D.ul {id: 'todo-list'}, 
				todos

module.exports = MainSection