var readline = require('readline');

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

reader.question('asdf', function () {});
