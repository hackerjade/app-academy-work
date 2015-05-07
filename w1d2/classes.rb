class Student
  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name  = last_name
    @courses    = {}
    @course_objects = []
  end

  def name
    "#{@first_name} #{@last_name}"
  end

  def courses
    @courses.keys
  end

  def enroll(course)
    raise "Conflicting course!" if has_conflict?(course)

    if @courses[course.department]
      @courses[course.department] += course.credits
    else
      @courses[course.department] = course.credits
    end

    course.add_student(self.name)
    @course_objects << course
  end

  def has_conflict?(course)
    @course_objects.each do |el|
       return true if course.conflicts_with?(el)
    end
    false
  end

  def course_load
    @courses
  end
end

class Course
  attr_reader :course, :department, :credits, :students, :time, :days_of_week

  def initialize(course, department, credits, days_of_week, time)
    @course = course
    @department = department
    @credits = credits
    @days_of_week = days_of_week
    @time = time
    @students = []
  end

  def add_student(student)
    @students << student
  end

  def conflicts_with?(course)
    if @time == course.time
      @days_of_week.each do |day1|
        course.days_of_week.each do |day2|
          return true if day1 == day2
        end
      end
    end
  end
end

class Board
  def initialize
    @board = Array.new(3) {Array.new(3)}
  end

  def won?
    @board.each do |row|
      if row == ['X', 'X', 'X']
        @winner = 'X'
        return true
      end
    end
  end

  def winner
  end

  def empty?(row, col)
    true unless @board[row][col]
  end

  def place_mark(pos, mark)
    row, col = pos[0], pos[1]
    empty?(row, col) ? @board[row][col] = mark : puts("That spot is taken")
    puts @board
  end
end

class Game
  def initialize
    @board = Board.new
    @human = HumanPlayer.new(@board)
    @computer = ComputerPlayer.new(@board)
  end

  def play
    pick_mark
    loop do
      @human.take_turn
      break if @board.won?
      @computer.take_turn
      break if @board.won?
    end
  end

  def pick_mark
    puts "Human! Pick your mark (X or O)!"
    mark = gets.chomp
    @human.mark = mark
    if @human.mark == 'X'
      @computer.mark = 'O'
    else
      @computer.mark = 'X'
    end
  end
end

class Player
  attr_accessor :mark

  def initialize(board)
    @board = board
    @mark = ""
  end
end

class HumanPlayer < Player
  def take_turn
    puts "Where do you want to place your mark?"
    pos = gets.chomp.split.map { |el| el.to_i}
    @board.place_mark(pos, @mark)
  end
end

class ComputerPlayer < Player
  def take_turn
    row, col = (0..2).to_a.sample, (0..2).to_a.sample
    until @board.empty?(row, col)
      row, col = (0..2).to_a.sample, (0..2).to_a.sample
    end
    @board.place_mark([row, col], @mark)
  end
end
