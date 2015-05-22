var readline = require('readline');

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var sum, numleft;

function completionCallback (total) {
  console.log("Total Sum is " + total);
}

function addNumbers (sum, numLeft, completionCallback) {
  if (numLeft > 0) {
    reader.question("What are your numbers?", function (answer) {
      var num = parseInt(answer);
      sum += num;
      console.log(sum);
      addNumbers (sum, numLeft - 1, completionCallback);
    });
  } else {
    completionCallback(sum);
  }
}

addNumbers(0, 3, function (sum) {
  console.log("Total Sum: " + sum);
});
