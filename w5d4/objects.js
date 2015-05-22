function Student(fName, lName, courses) {
  this.fName = fName;
  this.lName = lName;
  this.courses = courses;
}

Student.prototype.name = function () {
  return this.fName + " " + this.lName;
};

// Student.prototype.courses = function () {
//   return this.courses;
// };

Student.prototype.enroll = function (course) {
  course.addStudent(this);
  this.courses.push(course);
};

Student.prototype.courseLoad = function() {
  var load = {};
  this.courses.forEach(function (course) {
    if (load[course.dept]) {
      load[course.dept] += course.credits;
    } else {
      load[course.dept] = course.credits;
    }
  });
  return load;
};

Student.prototype.hasConflict = function (course) {
  return this.courses.some(function (otherCourse) {
    return course.conflictsWith(otherCourse);
  });
};

function Course (name, dept, credits, timeBlock, days, students) {
  this.name = name;
  this.dept = dept;
  this.credits = credits;
  this.timeBlock = timeBlock;
  this.days = days;
  this.students = students || [];
}

Course.prototype.addStudent = function (student) {
  this.students.push(student);
};

Course.prototype.conflictsWith = function (otherCourse) {
  var noSameDays = this.days.none(function (day) {
    return otherCourse.days.includes(day);
  });
  return noSameDays ? false : this.timeBlock === otherCourse.timeBlock;
};

function Cat (nickname, owner) {
  this.nickname = nickname;
  this.owner = owner;
}

Cat.prototype.cuteStatement = function () {
  console.log(this.owner + " loves " + this.nickname );
};

var johnny = new Cat("johnny", "johnny");
var markov = new Cat("Markov", "Ned");

johnny.cuteStatement();
markov.cuteStatement();

Cat.prototype.cuteStatement = function () {
  console.log("Everyone loves " + this.nickname);
};

johnny.cuteStatement();
markov.cuteStatement();

Cat.prototype.meow = function () { console.log("Meow") };

johnny.meow();

markov.meow = function () { console.log("I can talk!") };

johnny.meow();
markov.meow();
