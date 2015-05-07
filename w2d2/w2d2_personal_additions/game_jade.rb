require_relative 'piece'
require_relative 'board'
require_relative 'player'
require 'byebug'
<<<<<<< HEAD
require 'colorize'
=======
>>>>>>> refs/remotes/origin/master

class Game
  attr_reader :board, :player1, :player2

  def initialize(player1 = HumanPlayer.new, player2 = HumanPlayer.new)
    @player1 = player1
    @player2 = player2
    @board = Board.new
    @player1.color = :black
    @player2.color = :white
  end
end

<<<<<<< HEAD

game = Game.new
board1 = game.board
board2 = board1.dup
# board2.move([0,0], [1,0])
# p board1[[0,4]].moves
puts board1.render
=======
if __FILE__ != $PROGRAM_NAME
  # game = Game.new
end
>>>>>>> refs/remotes/origin/master
