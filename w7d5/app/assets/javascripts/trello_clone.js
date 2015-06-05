window.TrelloClone = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    var collection = new window.TrelloClone.Collections.Boards({reset: true});
    collection.fetch();
    var router = new window.TrelloClone.Routers.Route({
      collection: collection,
      $rootEl: $('#main')}
    );

    Backbone.history.start();
  }
};

$(document).ready(function(){
  window.TrelloClone.initialize();
});
