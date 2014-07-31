Footer = require './Footer'
Header = require './Header'
MainSection = require './MainSection'
{React, D} = require './react-etc'
TodoStore = require './TodoStore'


getTodoState = ->
	allTodos: TodoStore.getAll()
	areAllComplete: TodoStore.areAllComplete()

TodoApp = React.createClass
	getInitialState: -> getTodoState()

	componentDidMount: -> TodoStore.addChangeListener @_onChange

	componentWillUnmount: -> TodoStore.removeChangeListener @_onChange

	render: ->
		D.div {},
			Header {}
			MainSection {
				allTodos: @state.allTodos
				areAllComplete: @state.areAllComplete
			}
			Footer {allTodos: @state.allTodos}

	_onChange: -> @setState getTodoState()

module.exports = TodoApp