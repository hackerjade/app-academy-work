var readline = require('readline');

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var callback = function (boolean) {
  console.log(boolean);
};

function askIfGreaterThan (el1, el2, callback) {
  reader.question("Is " + el1 + " > " + el2 + "?", function (answer) {
    answer.toLowerCase() === 'yes' ? callback(true) : callback(false);
  });
}

// askIfGreaterThan(3, 2, callback);

function innerBubbleSortLoop (arr, i, madeAnySwaps, outerBubbleSortLoop) {
  if (i < arr.length - 1) {
    askIfGreaterThan(arr[i], arr[i + 1], function (isGreaterThan) {
      if(isGreaterThan) {
        var temp1 = arr[i + 1];
        arr[i + 1] = arr[i];
        arr[i] = temp1;
        madeAnySwaps = true;
      }
      innerBubbleSortLoop(arr, i + 1, madeAnySwaps, outerBubbleSortLoop);
    });
  } else if (i === arr.length - 1) {
    outerBubbleSortLoop (madeAnySwaps);
  }
}

// innerBubbleSortLoop([1,2,4,2], 0, false, null);

function absurdBubbleSort (arr, sortCompletionCallback) {
  function outerBubbleSortLoop (madeAnySwaps) {
    if (madeAnySwaps) {
      innerBubbleSortLoop(arr, 0, false, outerBubbleSortLoop);
    } else {
      sortCompletionCallback(arr);
    }
  }

  outerBubbleSortLoop(true);
}

absurdBubbleSort([3, 2, 1], function (arr) {
  console.log("Sorted array: " + JSON.stringify(arr));
  reader.close();
});
