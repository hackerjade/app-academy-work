window.TrelloClone.Views.BoardIndex = Backbone.View.extend({
  tagName: 'div',
  className: "container-fluid",
  template: JST['boards/index'],

  initialize: function(collection) {
    this.listenTo(this.collection, 'sync remove delete', this.render);
  },

  events: {
    'click li.new-board-link': 'newBoard',
    'click button.delete': 'deleteBoard'
  },

  newBoard: function(event) {
    Backbone.history.navigate("boards/new", {trigger: true});
  },

  deleteBoard: function(event) {
    var $target = $(event.currentTarget);
    var post = this.collection.get($target.attr("data"));
    post.destroy();
  },

  render: function() {
    var content = this.template({boards: this.collection});
    this.$el.html(content);

    this.collection.each(function(board) {
      var boardView = new window.TrelloClone.Views.BoardIndexItem({model: board});
      this.$el.find('.board-list').append(boardView.render().$el);
    }.bind(this));

    return this;
  }
});
