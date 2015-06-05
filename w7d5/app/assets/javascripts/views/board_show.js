TrelloClone.Views.BoardShow = Backbone.View.extend({
  template: JST['boards/show'],

  initialize: function(model) {
    this.listenTo(this.model, 'sync', this.render);
  },

  render: function() {
    debugger;
    var content = this.template({board: this.model});
    this.$el.html(content);

    var that = this;
    this.model.each(function(list) {
      var listView = new TrelloClone.Views.ListItem({model: list});
      that.$el.find('.board-canvas').append(boardView.render().$el);
    });

    return this;
  }
});
