{React, D} = require './react-etc'
TodoActions = require './TodoActions'
_ = require './utils'

Footer = React.createClass
	propTypes:
		allTodos: React.PropTypes.object.isRequired

	render: ->
		allTodos = @props.allTodos
		total = _.numKeys allTodos

		return null if total is 0

		completed = 0
		completed++ if allTodos[key].complete for key of allTodos

		itemsLeft = total - completed
		itemsLeftPhrase = if itemsLeft is 1 then ' item ' else ' items '
		itemsLeftPhrase += 'left'

		if completed
			clearCompletedButton = 
				D.button{
					id: 'clear-completed'
					onClick: -> TodoActions.destroyCompleted()
				}, "Clear completed (#{completed})"

		D.footer {id: 'footer'},
			D.span {id: 'todo-count'},
				D.strong {}, "#{itemsLeft}",
				"#{itemsLeftPhrase}"
			clearCompletedButton
					
module.exports = Footer