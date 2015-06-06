TrelloClone.Views.ListShow = Backbone.View.extend({
  template: JST['lists/show'],

  initialize: function(model) {
    this.listenTo(this.model, 'sync', this.render);
  },

  render: function() {
    var content = this.template({board: this.model});
    this.$el.html(content);

    var that = this;
    this.model.lists().each(function(list) {
      var listView = new TrelloClone.Views.BoardListItem({
        board: that.model,
        list: list
      });
      that.$el.find('.list').append(listView.render().$el);
    });

    return this;
  }
});
