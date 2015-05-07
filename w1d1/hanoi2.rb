class Hanoi
  # attr_accessor :towers, :solutions, :to_tower, :from_tower, :user_from, :user_to

  def initialize(tower_length)
    @tower_length = tower_length
    @towers = [[], [], []]
    @solution = (1..@tower_length).to_a
    @towers[0] = (1..@tower_length).to_a
  end

  def play
    p @towers
    until @towers[2] == @solution
      # self.get_move_from
      # self.get_move_to
      self.move_tower
      p @towers
    end
    puts "CONGRADULATIONS YOU WINNO"
  end

  def move_tower
    if @to_tower.nil? || @from_tower < @to_tower
      @towers[@user_to].unshift(@towers[@user_from].shift)
    else
      puts "That's not a valid move!"
    end
  end

  def get_move_to
    puts "Which tower would you like to move to?"
    @user_to = gets.chomp.to_i - 1

    @towers[@user_to][0]
  end

  def get_move_from
    puts "Which tower would you like to move from?"
    destination_tower = gets.chomp.to_i - 1

    if destination_tower < 0 || destination_tower >= @tower_length
      puts "That's not a valid move."
      get_move_from
    end

    return destination_tower
  end


end


game = Hanoi.new(3)
game.play
