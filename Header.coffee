React = require 'react'
TodoActions = require './TodoActions'
TodoTextInput = require './TodoTextInput'

D = React.DOM

Header = React.createClass
	render: ->
		D.header {id: 'header'},
			D.h1 {}, 'todos'
			TodoTextInput {
				id: 'new-todo'
				placeholder: 'What needs to be done?'
				onSave: (text) -> TodoActions.create text if text.trim()?
			}

module.exports = Header