TrelloClone.Views.BoardForm = Backbone.View.extend({
  template: JST['boards/board_form'],

  // initialize: function() {
  //   this.listenTo()
  // },

  events: {
    'submit .new-board': 'submitBoard'
  },

  submitBoard: function(event) {
    debugger;
  },

  render: function() {
    var content = this.template();
    this.$el.html(content);

    return this;
  }
});
