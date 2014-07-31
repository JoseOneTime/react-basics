React = require 'react'
TodoApp = require './TodoApp'

React.renderComponent
	TodoApp {},
	document.getElementById 'todoapp'