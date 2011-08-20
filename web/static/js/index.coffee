
class View extends Backbone.View

  initialize: ->
    super
    @$el = $(@el)

class Section extends View

  initialize: ->
    super
    @a = $("nav a[href=##{@el.id}]")

  toggle: (toggle) ->
    @$el.add(@a).toggleClass('active', toggle)

class App extends View

  events: ->
    scroll: '_scroll'

  initialize: ->
    super
    @header = $('nav h1')
    @sections = $('section').map -> new Section {el: @}

  activate: (section) ->
    @active?.toggle(false)
    (@active = section)?.toggle(true)
    @header.toggleClass('hidden', !@active)

  _scroll: _.debounce ->
    scrollTop = @$el.scrollTop()
    @activate _.detect @sections, (s) ->
      top = s.$el.offset().top
      nextTop = s.$el.next('section').offset()?.top
      top < (scrollTop + 75) < (nextTop or Number.MAX_VALUE)
  , 200

jQuery ($) ->
  app = new App {el: window}
