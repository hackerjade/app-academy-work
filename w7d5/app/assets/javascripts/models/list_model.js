window.TrelloClone.Models.List = Backbone.Model.extend({
  url: '/api/lists',
  initialize: function(options) {
    this.board = options.board;
  },

  cards: function() {
    if (!this._cards) {
      this._cards = new window.TrelloClone.Collections.Cards([], { list: this });
    }

    return this._cards;
  },

  parse: function(response) {
    if (response.cards) {
      this.cards().set(response.cards);
      delete response.cards;
    }

    return response;
  },
});
