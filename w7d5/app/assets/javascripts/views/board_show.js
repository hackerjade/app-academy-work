window.TrelloClone.Views.BoardShow = Backbone.View.extend({
  template: JST['boards/show'],

  initialize: function(model) {
    this.listenTo(this.model, 'sync', this.render);
    this.listenTo(this.model.lists(), 'sync', this.render);
  },

  render: function() {
    var content = this.template({board: this.model});
    this.$el.html(content);

    var that = this;
    this.model.lists().each(function(list) {
      var listView = new window.TrelloClone.Views.BoardListItem({
        board: that.model,
        list: list
      });
      that.$el.find('.list-show').append(listView.render().$el);
    });

    return this;
  }
});
