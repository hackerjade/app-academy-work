window.TrelloClone.Models.Card = Backbone.Model.extend({
  url: '/api/cards',
  initialize: function(options) {
    this.list = options.list;
  }
});
