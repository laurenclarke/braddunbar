
Section = Backbone.View.extend

  initialize: (options) ->
    @_a = options.a

  select: ->
    @el.add(@_a).addClass 'active'

  deselect: ->
    @el.add(@_a).removeClass 'active'

App = Backbone.View.extend

  initialize: ->
    nav = $ 'nav'

    @header = nav.find 'h1'

    @sections = $('section').map ->
      el = $ @
      new Section {el, a: nav.find 'a[href=#' + (el.attr 'id') + ']'}

    @update()

  events:
    scroll: 'update'

  update: _.debounce ->
    top = @el.scrollTop()

    @active?.deselect()

    if top < @sections[0].el.offset().top
      return @header.addClass 'hidden'

    @active = @sections[@sections.length - 1]
    for i in [0...@sections.length]
      if @sections[i].el.offset().top > top
        @active = @sections[i - 1]
        break

    @active.select()
    @header.removeClass 'hidden'

  , 50

app = new App {el: $ window}
