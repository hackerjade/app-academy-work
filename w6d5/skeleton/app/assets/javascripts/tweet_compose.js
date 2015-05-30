$.TweetCompose = function(el) {
  this.$el = $(el);
  this.$el.on('submit', this.submit.bind(this));
  $('a.add-mentioned-user').on('click', this.addMentionedUser.bind(this));
};

$.TweetCompose.prototype.submit = function() {
  event.preventDefault();
  var formData = this.$el.serializeJSON();
  // this.$el.find('input').prop("disabled", true);

  $.ajax({
    url: "/tweets",
    type: "POST",
    data: formData,
    dataType: 'json',
    success: function() {
      this.$el.find('input').prop("disabled", false);
      this.handleSuccess.bind(this);
    }.bind(this)
  });
};

$.TweetCompose.prototype.addMentionedUser = function() {
  // this.clearInput();
  $(this.$el.find('script').html()).appendTo('div.mentioned-users');
};


$.TweetCompose.prototype.clearInput = function(response) {
  response.empty();
};

$.TweetCompose.prototype.handleSuccess = function(response) {
  this.clearInput(response);

  var newTweet = $('<li>').text(JSON.stringify(response));

  $(this.$el.data('tweets-ul')).append(newTweet);
};


$.fn.tweetCompose = function() {
  this.each(function() {
    new $.TweetCompose(this);
  });
};

$(function() {
  $('form.tweet-compose').tweetCompose();
});
