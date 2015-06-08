window.TrelloClone.Views.BoardListItem = Backbone.View.extend({
  template: JST['boards/board_list_item'],

  initialize: function(options) {
    this.list = options.list;
    this.board = options.board;
    this.listenTo(this.list, 'sync', this.render);
    this.listenTo(this.list.cards(), 'sync', this.render);
  },

  render: function() {
    var content = this.template({
      board: this.board,
      list: this.list
    });
    this.$el.html(content);

    var that = this;
    this.list.cards().each(function(card) {
      var cardView = new window.TrelloClone.Views.ListCardItem({
        list: that.list,
        card: card
      });
      that.$el.find('.list').append(cardView.render().$el);
    });

    return this;
  }
});
