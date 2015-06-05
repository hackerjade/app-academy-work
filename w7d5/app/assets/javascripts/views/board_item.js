TrelloClone.Views.BoardIndexItem = Backbone.View.extend({
  template: JST['boards/board_item'],

  initialize: function(model) {
    this.listenTo(this.model, 'sync', this.render);
  },

  render: function() {
    var content = this.template({board: this.model});
    this.$el.html(content);

    return this;
  }
});
