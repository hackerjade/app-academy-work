require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_accessor :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    # duplicate.all?
      duplicate = @board.dup.rows
      0.upto(2) do |x|
        2.downto(0) do |y|
          # p duplicate
          p [[x],[y - 1]]
          duplicate = @board.dup.rows
          duplicate[x][y - 1] = @next_mover_mark if duplicate[x][y -1].empty?
          @prev_move_pos = [x, y - 1]
        end
      end
      update_next_mover_mark
      # p "dup" + duplicate.to_s
      duplicate
  end

  def num_of_empty
    count = []
    0.upto(2) do |x|
      2.downto(0) do |y|
        duplicate = @board.dup.rows
        count += 1 if duplicate[x][y].empty?
      end
    end
    p "here"
    p count
    duplicate
  end

  def update_next_mover_mark
    @next_mover_mark == :x ? @next_mover_mark = :o : @next_mover_mark = :x
  end
end
