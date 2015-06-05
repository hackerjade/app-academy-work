TrelloClone.Views.BoardIndex = Backbone.View.extend({
  template: JST['boards/index'],

  initialize: function(collection) {
    this.listenTo(this.collection, 'sync', this.render);
  },

  events: {
    'click button': 'newBoard'
  },

  newBoard: function(event) {
    Backbone.history.navigate("boards/new", {trigger: true});
  },

  render: function() {
    var content = this.template({boards: this.collection});
    this.$el.html(content);

    var that = this;
    this.collection.each(function(board) {
      var boardView = new TrelloClone.Views.BoardIndexItem({model: board});
      that.$el.find('.board-canvas').append(boardView.render().$el);
    });

    return this;
  }
});
