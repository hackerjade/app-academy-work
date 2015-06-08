window.TrelloClone.Models.Board = Backbone.Model.extend({
  urlRoot: '/api/boards',

  lists: function() {
    if (!this._lists) {
      this._lists = new window.TrelloClone.Collections.Lists([], { board: this });
    }

    return this._lists;
  },

  parse: function(response) {
    if (response.lists) {
      this.lists().set(response.lists, { parse: true });
      delete response.lists;
    }

    return response;
  }
});
