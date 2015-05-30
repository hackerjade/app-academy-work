$.FollowToggle = function (el, options) {
  this.$el = $(el);
  this.userId = this.$el.data('user-id') || options.userId;
  this.followState = this.$el.data('initial-follow-state')|| options.followState;
  this.render();
  this.$el.on('click', this.handleClick.bind(this));
};

$.FollowToggle.prototype.render = function() {
  if (this.$el.prop("disabled")) {return;}
  var buttonText = this.foggle() ? "Unfollow!" : "Follow!";
  this.$el.empty();
  this.$el.append(buttonText);
};

$.FollowToggle.prototype.foggle = function() {
  return this.followState === "followed";
};

$.FollowToggle.prototype.handleClick = function(event) {
  event.preventDefault();
  var action = this.foggle() ? "DELETE" : "POST";
  this.$el.prop("disabled", true);
  $.ajax({
    type: action,
    url: "/users/" + this.userId + "/follow",
    dataType: 'json',
    success: function() {
      this.$el.prop("disabled", false);
      this.followState = this.foggle() ? "unfollowed" : "followed";
      this.render();
    }.bind(this)
  });
};

$.fn.followToggle = function (options) {
  var paramptions = options || {};
  return this.each(function () {
    new $.FollowToggle(this, paramptions);
  });
};

$(function () {
  $("button.follow-toggle").followToggle();
});
