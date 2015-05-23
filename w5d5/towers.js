var readline = require('readline');

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});


function TowersOfHanoi () {
  this.stacks = [[1, 2, 3], [], []];
}

TowersOfHanoi.prototype.isWon = function() {
  return this.stacks[1].length === 3 || this.stacks[2].length === 3;
};

TowersOfHanoi.prototype.isValidMove = function(startIdx, endIdx) {

  if (startIdx < 0 || startIdx > 2 || endIdx < 0 || endIdx > 2) {
    return false;
  }

  if (this.stacks[endIdx].length === 0) {
      return true;
  } else {
    return this.stacks[startIdx][0] <
    this.stacks[endIdx][0];
  }
};

TowersOfHanoi.prototype.move = function(startIdx, endIdx) {
  if (this.isValidMove(startIdx, endIdx)) {
    this.stacks[endIdx].unshift(this.stacks[startIdx].shift());
    return true;
  }

  return false;
};

TowersOfHanoi.prototype.print = function() {
  console.log("\n");
  console.log(this.stacks);
  console.log("\n");
};

TowersOfHanoi.prototype.promptMove = function(callback) {
  this.print();
  reader.question("Where do you want to move?", function (answer) {
    callback(answer[0], answer[2]);
  }.bind(this));
};

TowersOfHanoi.prototype.run = function(callback) {
  var that = this
  function promptCallback(startIdx, endIdx) {
    if (!that.move(startIdx, endIdx)) {
      console.log("Error son");
    }

    that.isWon() ? callback() : that.run(callback);
  }


  this.promptMove(promptCallback);
};

var game = new TowersOfHanoi();

console.log(game.run(function() {
  console.log("You won!");
  reader.close();
}));
