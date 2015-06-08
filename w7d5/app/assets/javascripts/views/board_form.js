window.TrelloClone.Views.BoardForm = Backbone.View.extend({
  template: JST['boards/board_form'],

  events: {
    'submit .board-form': 'submitBoard'
  },

  submitBoard: function(event) {
    event.preventDefault();
    var attrs = this.$el.find("form").serializeJSON();

    this.model.set(attrs);
    this.model.save({}, {
      success: function() {
        this.collection.add(this.model, { merge: true });
        Backbone.history.navigate("", { trigger: true });
      }.bind(this)
    });
  },

  render: function() {
    var content = this.template({
      board: this.model
    });
    this.$el.html(content);

    return this;
  }
});
