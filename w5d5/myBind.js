Function.prototype.myBind = function (context) {
  var fn = this;
  function boundFunc (fn, context) {
    fn.apply(context)
  }

  boundFunc(fn, context);
};


function Cat (name) {
  this.name = name;
}

Cat.prototype.meow = function () {
  console.log("Meowing by your cat " + this.name);
};

function Duck (name) {
  this.name = name;
}

Duck.prototype.meow = function () {
  console.log("Quacking by your duck " + this.name);
};

var sally = new Cat("Sally");
var arnold = new Duck("Ahnold");

var a = arnold.meow.myBind(sally);


var meowMethod = sally.meow;
meowMethod();

sally.meow();

var sallysMeow = meowMethod.bind(sally); //
sallysMeow();
