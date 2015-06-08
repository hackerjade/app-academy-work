window.TrelloClone.Routers.Route = Backbone.Router.extend({
  initialize: function(options) {
    this.$rootEl = options.$rootEl;
    this.collection = options.collection;
  },

  routes: {
    "": "boardIndex",
    "boards/new": "boardNew",
    "boards/:id": "boardShow",
    "boards/:id/edit": "boardEdit",
  },

  boardIndex: function() {
    var view = new window.TrelloClone.Views.BoardIndex({
      collection: this.collection
    });
    this._swapView(view);
  },

  boardEdit: function(id) {
    var board = this.collection.getOrFetch(id);
    var view = new window.TrelloClone.Views.BoardForm({
      model: board,
      collection: this.collection
    });
    this._swapView(view);
  },

  boardNew: function() {
    var newBoard = new window.TrelloClone.Models.Board();
    var view = new window.TrelloClone.Views.BoardForm({
      model: newBoard,
      collection: this.collection
    });
    this._swapView(view);
  },

  boardShow: function(id) {
    var view = new window.TrelloClone.Views.BoardShow({
      model: this.collection.getOrFetch(id)
    });
    this._swapView(view);
  },

  _swapView: function(view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$rootEl.html(view.render().$el);
  }
});
