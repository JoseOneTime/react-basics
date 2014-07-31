Promise = require 'es6-promise'

_callbacks = _promises = []

class Dispatcher
	register: (callback) =>
		_callbacks.push callback
		_callbacks.length - 1

	dispatch: (payload) =>
		resolves = rejects = []

		_promises = _callbacks.map (_, i) ->
			new Promise (resolve, reject) ->
				resolves[i] = resolve
				rejects[i] = reject

		_callbacks.forEach (callback, i) ->
			Promise.resolve(callback(payload)).then(
				-> resolves[i] payload,
				-> rejects[i] new Error('Dispatcher callback unsuccessful')
			)

		_promises = []

	waitFor: (promiseIndexes, callback) ->
		selectedPromises = promiseIndexes.map (index) -> _promises[index]
		Promise.all(selectedPromises).then(callback)

module.exports = Dispatcher