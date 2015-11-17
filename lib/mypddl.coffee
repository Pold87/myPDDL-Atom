MypddlView = require './mypddl-view'
{CompositeDisposable} = require 'atom'

module.exports = Mypddl =
  mypddlView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @mypddlView = new MypddlView(state.mypddlViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @mypddlView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'mypddl:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @mypddlView.destroy()

  serialize: ->
    mypddlViewState: @mypddlView.serialize()

  toggle: ->
    console.log 'Mypddl was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
