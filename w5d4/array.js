Array.prototype.includes = function (el) {
  var included = false;

  this.forEach(function(el2) {
    if (el2 === el) {
      included = true;
    };
  });

  return included;
};

Array.prototype.includes2 = function (el) {
  return this.indexOf(el) !== -1;
};

Array.prototype.includes3 = function (el) {
  return this.some(function (el2) {
    return el === el2;
  });
};


Array.prototype.myUniq = function () {
  var newArray = [];

  this.forEach(function(el) {
    if (!newArray.includes(el)) {
      newArray.push(el);
    }
  });

  return newArray;
};


Array.prototype.twoSum = function () {
  var sums = [];

  for (var i = 0; i < this.length - 1; i++) {
    for (var j = i + 1; j < this.length; j++) {
      if (this[i] + this[j] === 0) {
        sums.push([i, j]);
      }
    }
  }

  return sums;
};

Array.prototype.transpose = function () {
  var transposed = new Array(this.length);

  for (var i = 0; i < this.length; i++) {
    transposed[i] = [];
    for (var j = 0; j < this[0].length; j++) {
        transposed[i][j] = this[j][i];
    }
  }

  return transposed;
};

Array.prototype.myEach = function (func) {
  for (var i = 0; i < this.length; i++) {
    func(this[i]);
  }
};

Array.prototype.myMap = function (func) {
  var mapped = [];

  this.myEach(function (el) {
    mapped.push(func(el));
  });

  return mapped;
};

Array.prototype.myInject = function (acc, accumFunc) {
  this.myEach(function (el) {
    acc = accumFunc(acc, el);
  });

  return acc;
};

Array.prototype.bubbleSort = function () {
  var sorted = false;
  var count = 0;
  while(!sorted) {
    sorted = true;
    for (var i = 0; i < this.length - count; i++) {
      if(this[i] > this[i + 1]) {
        var temp = this[i + 1];
        this[i + 1] = this[i];
        this[i] = temp;
        sorted = false;
      }
    }
    count++;
  }
  return this;
};


var arr = [2, 3, 5, -5, 3, 1];

// function print(something) {
//   console.log(something);
// }
//
// function Snowman (name) {
//   this.name = name;
// }
//
// var someFunc = function () {
//
// };


// class Array
//   def two_sum
//     (0...length).to_a.combination.select { |x, y| self[x] + self[y] == 0 }
//   end
// end
// //
