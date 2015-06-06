TrelloClone.Views.BoardListItem = Backbone.View.extend({
  template: JST['boards/board_list_item'],

  initialize: function(options) {
    this.list = options.list;
    this.board = options.board;
  },

  render: function() {
    var content = this.template({
      board: this.board, 
      list: this.list
    });
    this.$el.html(content);
    return this;
  }
});
