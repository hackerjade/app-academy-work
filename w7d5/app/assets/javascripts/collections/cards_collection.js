window.TrelloClone.Collections.Cards = Backbone.Collection.extend({
  model: window.TrelloClone.Models.Card,
  url: '/api/cards',
  initialize: function(model, options) {
    this.list = options.list;
  }
});
