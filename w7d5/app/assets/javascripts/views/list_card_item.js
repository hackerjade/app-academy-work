


window.TrelloClone.Views.ListCardItem = Backbone.View.extend({
  tagName: "li",
  className: "draggable",
  template: JST['boards/list_card_item'],

  initialize: function(options) {
    this.list = options.list;
    this.card = options.card;
  },

  render: function() {
    var content = this.template({
      list: this.list,
      card: this.card
    });
    this.$el.html(content);

    return this;
  }
});
