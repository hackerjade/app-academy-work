TrelloClone.Models.List = Backbone.Model.extend({
  url: '/api/lists',
  initialize: function(options) {
    this.board = options.board;
  }
});
