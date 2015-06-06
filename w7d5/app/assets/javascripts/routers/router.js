TrelloClone.Routers.Route = Backbone.Router.extend({
  initialize: function(options) {
    this.$rootEl = options.$rootEl;
    this.collection = options.collection;
  },

  routes: {
    "": "boardIndex",
    "boards/new": "boardNew",
    "boards/:id": "boardShow",
    "boards/:id/edit": "boardEdit",
    "boards/:board_id/lists/:id": "listShow"
  },

  boardIndex: function() {
    var view = new window.TrelloClone.Views.BoardIndex({collection: this.collection});
    this._swapView(view);
  },

  boardEdit: function(id) {
    var view = new window.TrelloClone.Views.BoardForm({collection: this.collection});
    this._swapView(view);
  },

  boardNew: function() {
    var view = new window.TrelloClone.Views.BoardForm();
    this._swapView(view);
  },

  boardShow: function(id) {
    var view = new window.TrelloClone.Views.BoardShow({model: this.collection.getOrFetch(id)});
    this._swapView(view);
  },

  listShow: function(board_id, id) {
    var board = this.collection.get(board_id);
    var list = board.lists().get(id);
    debugger;
    var view = new window.TrelloClone.Views.ListShow({list: list});
    this._swapView(view);
  },

  _swapView: function(view) {
    this._current_view && this._current_view.remove();
    this._current_view = view;
    this.$rootEl.html(view.render().$el);
  }
});
