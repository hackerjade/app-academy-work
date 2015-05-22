/* range
exponent
fib
binary search
make change
merge_sort
subsets */

function range(start, end) {
  if (start === end) {
    return [start];
  } else {
    return [start].concat(range(start + 1, end));
  }
}

function fib(n) {
  if (n === 1) {
    return [1];
  } else if (n === 2) {
    return [1, 1];
  } else {
    var prevFibs = fib(n - 1);
    return prevFibs.concat([prevFibs[prevFibs.length - 1] +
                            prevFibs[prevFibs.length - 2]]);
  }
}

function bsearch(arr, val) {
  if (arr.length === 1 && arr[0] !== val) {
    return NaN; // TA: return null
  }

  var midpoint = Math.floor(arr.length / 2);
  if (val > arr[midpoint]) {
    return midpoint + bsearch(arr.slice(midpoint + 1));
  } else if (val < arr[midpoint]) {
    return bsearch(arr.slice(0, midpoint));
  } else {
    return midpoint;
  }
}

function makeChange(payment, coins) {
  if (payment === 0) {
    return [];
  } else if (coins.includes(payment)) {
    return [payment];
  }

  // var minCoinCount = Infinity;
  var minCoins = [];

  for (var i = 0; i < coins.length; i++) { // TA: could be a forEach
    if (coins[i] < payment) {
      var thisTry = [coins[i]].concat(makeChange(payment - coins[i], coins));
      if (!minCoins || thisTry.length < minCoins.length) {
        // minCoinCount = thisTry.length;
        minCoins = thisTry;
      }
    }
  }
  return minCoins;
}

function subsets(arr) {
  if (arr.length === 0) {
    return [[]];
  } else {
    var prevSubsets = subsets(arr.slice(1));
    var mappedSubsets = prevSubsets.map(function (subArray) {
      return [arr[0]].concat(subArray);
    });
    return mappedSubsets.concat(prevSubsets);
  }
}

// console.log(subsets([1, 23, 4]));

function mergeSort(arr) {
  if (arr.length <= 1) {
    return arr;
  }
  var midpoint = Math.ceil(arr.length / 2);
  var right = arr.slice(midpoint);
  var left = arr.slice(0, midpoint);
  return merge(mergeSort(left), mergeSort(right));
}

function merge(left, right) {
  var merged = [];


  while (right.length > 0 && left.length > 0) {
    if (right[0] > left[0]) {
      merged.push(left.shift());
    } else {
      merged.push(right.shift());
    }
  }

  return merged.concat(right, left);
}
