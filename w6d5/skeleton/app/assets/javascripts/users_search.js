$.UsersSearch = function(el) {
  this.$el = $(el);
  this.$input = this.$el.find('input');
  this.$ul = this.$el.find(".users");
  this.$input.on('input', this.handleInput.bind(this));
};

$.UsersSearch.prototype.handleInput = function(event) {
  var currentInput = event.currentTarget.value;
  $.ajax({
    type: "GET",
    url:  "/users/search",
    data: {
      query: currentInput
    }, dataType: 'json',
    success: function(foggle) {
      this.renderResult(foggle);
    }.bind(this)
  });
};

$.UsersSearch.prototype.renderResult = function(foogle) {
  this.$ul.empty();
  $(foogle).each(function(idx, foogler){
    $("<li a>").attr("href", "users/" + foogler.id).text(foogler.username).appendTo(this.$ul);
    debugger;
    var buttonText = (foogler.followed ? "followed" : "unfollowed");
    var button = $("<button>").addClass("follow-toggle");
    button.followToggle({userId: foogler.id, followState: buttonText});
    button.appendTo(this.$ul);
  }.bind(this));
};

$.fn.usersSearch = function() {
  this.each(function() {
    new $.UsersSearch(this);
  });
};


$(function() {
  $(".users-search").usersSearch();
});
