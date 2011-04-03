jQuery(function($){

  var Section = Backbone.View.extend({

    initialize: function(options){
      this._a = options.a;
    },

    select: function(){
      this.el.add(this._a).addClass('active');
    },

    deselect: function(){
      this.el.add(this._a).removeClass('active');
    }

  });

  var App = Backbone.View.extend({

    initialize: function(){
      var nav = $('nav');

      this.header = nav.find('h1');

      this.sections = $('section').map(function(){
        var el = $(this);
        return new Section({
          el: el,
          a: nav.find('a[href=#' + el.attr('id') + ']')
        });
      });

      this.update();
    },

    events: {
      'scroll': 'update'
    },

    update: _.debounce(function(){
      var top = this.el.scrollTop(), sections = this.sections;

      if(this.active) this.active.deselect();

      if(top < sections[0].el.offset().top){
        this.header.addClass('hidden');
        return;
      }

      this.active = sections[sections.length - 1];
      for(var i = 0, l = sections.length; i < l; i++){
        if(sections[i].el.offset().top > top){
          this.active = sections[i-1];
          break;
        }
      }

      this.active.select();
      this.header.removeClass('hidden');
    }, 50)

  });

  var app = new App({ el: $(window) });

});
