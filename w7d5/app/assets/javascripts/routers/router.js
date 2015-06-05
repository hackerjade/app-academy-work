TrelloClone.Routers.Route = Backbone.Router.extend({
  initialize: function(options) {
    this.$rootEl = options.$rootEl;
    this.collection = options.collection;
  },

  routes: {
    "": "index",
    "boards/new": "new",
    "boards/:id": "show",
    "boards/:id/edit": "edit"
  },

  index: function() {
    var view = new TrelloClone.Views.BoardIndex({collection: this.collection});
    this._swapView(view);
  },

  edit: function(id) {
    var view = new TrelloClone.Views.BoardForm({collection: this.collection});
    this._swapView(view);
  },

  new: function() {
    var view = new TrelloClone.Views.BoardForm();
    this._swapView(view);
    // this.$rootEl.html('NNEEEEEEEw');
  },

  show: function(id) {
    debugger;
    var view = new TrelloClone.Views.BoardShow({model: this.collection.getOrFetch(id)});
    this._swapView(view);
  },

  _swapView: function(view) {
    this._current_view && this._current_view.remove();
    this._current_view = view;
    this.$rootEl.html(view.render().$el);
  }
});
