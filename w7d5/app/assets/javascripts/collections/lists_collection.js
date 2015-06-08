window.TrelloClone.Collections.Lists = Backbone.Collection.extend({
  model: window.TrelloClone.Models.List,
  url: '/api/lists',
  initialize: function(model, options) {
    this.board = options.board;
  },

  comparator: function(list) {
    return list.get('ord');
  }
});
