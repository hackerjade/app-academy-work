String.prototype.substrings = function() {
  var substrings = [];

  for (var l = 1; l < this.length; l++) {
    for (var i = 0; i <= this.length - l; i++) {
      substrings.push(this.substring(i, i + l));
    }
  }

  return substrings;
};
