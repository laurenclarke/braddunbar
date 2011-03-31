jQuery(function($){

  var Section = Backbone.View.extend({

    initialize: function(options){
      this._a = options.a;
    },

    select: function(){
      this._a.addClass('active');
    },

    deselect: function(){
      this._a.removeClass('active');
    }

  });

  var App = Backbone.View.extend({

    initialize: function(){
      var ul = $('nav ul');

      this.sections = $('section').map(function(){
        var el = $(this);
        return new Section({
          el: el,
          a: ul.find('a[href=#' + el.attr('id') + ']')
        });
      });

      this.update();
    },

    events: {
      'scroll': 'update'
    },

    update: _.debounce(function(){
      var top = this.el.scrollTop(), sections = this.sections;

      console.log(top, _.pluck(sections, 'top'));

      if(this.active) this.active.deselect();

      for(var i = 0, l = sections.length; i < l; i++){
        if(sections[i].el.offset().top > top){
          this.active = sections[i-1];
          break;
        }
      }

      if(this.active) this.active.select()
    }, 50)

  });

  var app = new App({ el: $(window) });

});
