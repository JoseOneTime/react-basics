{React, D} = require './react-etc'
ENTER_KEY_CODE = 13

TodoTextInput = React.createClass
	propTypes:
		className: React.PropTypes.string
		id: React.PropTypes.string
		placeholder: React.PropTypes.string
		onSave: React.PropTypes.func.isRequired
		value: React.PropTypes.string

	getInitialState: -> {value: @props.value or ''}

	render: ->
		D.input {
			className: @props.className
				id: @props.id
				placeholder: @props.placeholder
				onBlur: @_save
				onChange: @_onChange
				onKeyDown: @_onKeyDown
				value: @state.value
				autoFocus: true
		}

	_save: ->
		@props.onSave @state.value
		@setState {value: ''}

	_onChange: (event) ->
		@setState {value: event.target.value}

	_onKeyDown: (event) ->
		@_save if event.keyCode is ENTER_KEY_CODE

module.exports = TodoTextInput