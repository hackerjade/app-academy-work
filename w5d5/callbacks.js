function Clock (tickInteval) {
  this.tick = tickInteval || Clock.TICK;
}

Clock.TICK = 1000;

Clock.prototype.printTime = function () {
  var timeArray = [this.hours, this.minutes, this.seconds];

  var timestamp = timeArray.map(function(el) {
      if (el < 10) {
      return "0" + el;
      } else {
        return el;
      }
    }).join(":");

  console.log(timestamp);
};

Clock.prototype.run = function () {
  this.date = new Date();
  this.hours = this.date.getHours();
  this.minutes = this.date.getMinutes();
  this.seconds = this.date.getSeconds();
  this.printTime();
  setInterval(this._tick.bind(this), this.tick);
};

Clock.prototype.rollOverUnits = function () {
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
};

Clock.prototype._tick = function () {
  this.seconds += ( this.tick/1000 );
  this.rollOverUnits();
  this.printTime();
};

var clock = new Clock();
clock.run();
