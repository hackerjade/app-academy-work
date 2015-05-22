function Clock () {
  this.tick = 1000;
  this.hours = null;
  this.minutes = null;
  this.seconds = null;
}

Clock.prototype.printTime = function () {
  var timestamp = "";

  var timeFormatter = function(num) {
    if (num < 10) {
      timestamp += "0" + num + ":";
    } else {
      timestamp += num + ":";
    }
  };

  var timeArray = [this.hours, this.minutes, this.seconds];
  timeArray.forEach(function(el) {
    timeFormatter(el);
    });

  timestamp = timestamp.slice(0, timestamp.length - 1);

  console.log(timestamp);
};

Clock.prototype.run = function () {
  this.date = new Date();
  this.hours = this.date.getHours();
  this.minutes = this.date.getMinutes();
  this.seconds = this.date.getSeconds();
  this.printTime();
  this._tick();
};

Clock.prototype._tick = function () {
  var increment = function () {
      this.seconds += ( this.tick/1000 );
      if (this.seconds === 60) {
          this.seconds = 0;
          this.minutes += 1;
      }

      if (this.minutes === 60) {
          this.minutes = 0;
          this.hours += 1;
      }

      if (this.hours === 24) {
          this.hours = 0;
      }

      this.printTime();
  };

  setInterval( increment.bind(this), this.tick );
};


var clock = new Clock();
clock.run();
