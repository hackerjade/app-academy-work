require 'set'
require 'awesome_print'
require 'byebug'

class Tile
  attr_accessor :revealed, :flagged, :bomb

  def initialize(game_board, position)
    @game_board = game_board
    @position = position
    @bomb = false
    @flagged = false
    @revealed = false
    @old_neighbors = []
  end

  def status
    #get the neighbor bomb count
  end

  def neighbors
    neighbors = []
    [-1, 0, 1].each do |mod1|
      [-1, 0, 1].each do |mod2|
        y_coor = @position[0] + mod1
        x_coor = @position[1] + mod2
        unless mod1 == 0 && mod2 == 0
          unless on_board?(y_coor,x_coor) == false || old_neighbors.include?(y_coor, x_coor)
            neighbors << [y_coor , x_coor]
          end
        end
      end
    end

    neighbors.each do |neighbor|
      unless @old_neighbors.include?(neighbor)
        @old_neighbors << neighbor
      end
    end

    @old_neighbors << @position unless @old_neighbors.include?(@position)

    neighbor
  end

  def on_board?(x,y) #make 8 dynamic in future?
    x.between?(0,8) && y.between?(0,8)
  end

  def neighbor_bomb_count
    count = 0
    neighbors.each do |neighbor|
      # byebug
      count += 1 if @game_board[neighbor[0]][neighbor[1]].is_bomb?
    end
    # count == 0 ? " " : count
    return " "
  end

  def expand_reveal
    if neighbor_bomb_count == " "
      reveal_tile
      neighbors.each do |neighbor|
        byebug
        p neighbor
        @game_board[neighbor[0]][neighbor[1]].expand_reveal
      end
    elsif neighbor_bomb_count.is_a?(Integer)
      reveal_tile
    end
  end


  def is_bomb?
    @bomb
  end

  def bomb_tile
    @bomb = true
  end

  def flag_tile
    @flagged = true
  end

  def reveal_tile
    @revealed = true

  end

  def inspect
    res = {
      position: @position,
      bomb: @bomb,
      flagged: @flagged,
      revealed: @revealed
    }

    res.inspect
  end
end

class Board
  attr_accessor :game_board

  def initialize
    @game_board = Array.new(9) {Array.new(9)}
    generate_board
  end

  def display_board
    display = Array.new(9) {Array.new(9)}
    @game_board.each_with_index do |row, y_coor|
      row.each_with_index do |dummy, x_coor|
        current_tile = @game_board[y_coor][x_coor]
        if current_tile.revealed
          return false if current_tile.is_bomb?
          display[y_coor][x_coor] = current_tile.neighbor_bomb_count
          current_tile.expand_reveal
        else
          display[y_coor][x_coor] = "*"
        end
      end
    end

    display
  end

  def generate_board
    @game_board.each_with_index do |row, y_coor|
      row.each_with_index do |dummy, x_coor|
        @game_board[y_coor][x_coor] = Tile.new(@game_board, [y_coor, x_coor])
      end
    end

    seed_bombs
  end

  def seed_bombs
    count = 0
    until count == 10
      x, y = (0..8).to_a.sample, (0..8).to_a.sample
      unless @game_board[y][x].is_bomb?
        @game_board[y][x].bomb_tile
        count += 1
      end
    end

    p @game_board

  end
end

class Minesweeper
  def initialize
    @board = Board.new
  end

  def play
    puts "Would you like to reveal or flag? (r/f)"
    user_action = gets.chomp
    puts "Where would you like to do this? x, y"
    user_position = gets.chomp.split(', ')
    if user_action == r
      @board.game_board[user_position[1]][user_position[0]].reveal_tile
    elsif user_action == f
      @board.game_board[user_position[1]][user_position[0]].flag_tile
    else
      puts 'Not a valid move.'
    end
    # ...
  end

end

game = Board.new
