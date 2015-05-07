<<<<<<< HEAD

=======
# Chess
>>>>>>> refs/remotes/origin/master

class Piece
  attr_reader :color, :pos

  def initialize(board, pos, color, moved = false)
    @board, @pos, @color, @moved = board, pos, color, moved
  end

<<<<<<< HEAD
  def moves(potential_moves) #Causes a bug
    valid_moves = potential_moves.reject { |move| move_into_check?(move) }
    valid_moves
  end

  def display
  end

  def move_into_check?(pos)
    board_dup = @board.dup
    board_dup.move(@pos, pos).in_check?(@color) # TA: make #move actually chainable
=======
  def symbol
    raise NotImplementedError.new
  end

  def moves

>>>>>>> refs/remotes/origin/master
  end

  def inspect
    { :piece => self.class, :piece_color => self.color}.inspect
  end

  def is_blocked?(pos)
    @board.occupied?(pos) && self.color == @board[pos].color
  end

end

<<<<<<< HEAD
class Pawn < Piece
  def move_dirs
    [
    [1,0],
    [-1,0]
    ]
  end

  def display
    self.color == :white ? "\u2659 " : "\u265F ".colorize(:black)
  end
end

class SlidingPiece < Piece
  def moves
    potential_moves = []
=======

class Pawn < Piece
end

class SlidingPiece < Piece

  def moves
    valid_moves = []
>>>>>>> refs/remotes/origin/master

    move_dirs.each do |direction|
      dx,dy = direction
      new_position = [@pos[0] + dx, @pos[1] + dy]

      until is_blocked?(new_position) || !@board.on_board?(new_position)
        if is_opponent_piece?(new_position)
<<<<<<< HEAD
          potential_moves << new_position
          break
        end
        potential_moves << new_position
=======
          valid_moves << new_position
          break
        end
        valid_moves << new_position
>>>>>>> refs/remotes/origin/master
        new_position = [new_position[0] + dx, new_position[1] + dy]
      end
    end

<<<<<<< HEAD
    super(potential_moves)
=======
    valid_moves
>>>>>>> refs/remotes/origin/master
  end

  def is_opponent_piece?(pos)
    @board.occupied?(pos) && self.color != @board[pos].color
  end

end

class Rook < SlidingPiece
<<<<<<< HEAD
=======

>>>>>>> refs/remotes/origin/master
  def move_dirs
    [
    [0, 1],
    [1, 0],
    [-1, 0],
    [0, -1]
    ]
  end

<<<<<<< HEAD
  def display
    self.color == :white ? "\u2656 " : "\u265C ".colorize(:black)
  end

end

class Bishop < SlidingPiece
=======
end

class Bishop < SlidingPiece

>>>>>>> refs/remotes/origin/master
  def move_dirs
    [
    [1, 1],
    [-1, -1],
    [1, -1],
    [-1, 1]
    ]
  end
<<<<<<< HEAD

  def display
    self.color == :white ? "\u2657 " : "\u265D ".colorize(:black)
  end
=======
>>>>>>> refs/remotes/origin/master
end

class Queen < SlidingPiece
  def move_dirs
    [
    [-1, -1],
    [-1,  0],
    [-1,  1],
    [ 0, -1],
    [ 0,  1],
    [ 1, -1],
    [ 1,  0],
    [ 1,  1]
    ]
  end
<<<<<<< HEAD

  def display
    self.color == :white ? "\u2655 " : "\u265B ".colorize(:black)
  end
end

class SteppingPiece < Piece
  def moves
    potential_moves = []
=======
end


class SteppingPiece < Piece
  def moves
    valid_moves = []
>>>>>>> refs/remotes/origin/master

    move_dirs.each do |direction|
      dx,dy = direction
      new_position = [@pos[0] + dx, @pos[1] + dy]
      next if is_blocked?(new_position) || !@board.on_board?(new_position)
<<<<<<< HEAD
      potential_moves << new_position
    end

    super(potential_moves)
=======
      valid_moves << new_position
    end

    valid_moves
>>>>>>> refs/remotes/origin/master
  end
end

class Knight < SteppingPiece
  def move_dirs
    [
    [-2, -1],
    [-2,  1],
    [-1, -2],
    [-1,  2],
    [ 1, -2],
    [ 1,  2],
    [ 2, -1],
    [ 2,  1]
    ]
  end
<<<<<<< HEAD

  def display
    self.color == :white ? "\u2658 " : "\u265E ".colorize(:black)
  end
=======
>>>>>>> refs/remotes/origin/master
end

class King < SteppingPiece
  def move_dirs
    [
    [-1, -1],
    [-1,  0],
    [-1,  1],
    [ 0, -1],
    [ 0,  1],
    [ 1, -1],
    [ 1,  0],
    [ 1,  1]
    ]
  end
<<<<<<< HEAD

  def display
    self.color == :white ? "\u2654 " : "\u265A ".colorize(:black)
  end
=======
>>>>>>> refs/remotes/origin/master
end

# + Piece
#     + @color
#     + @pos
#     + @moved
#     + @board
#     + #valid_moves()
#  + Pawn (weird)
#  + SlidingPiece
#    + #moves()
#    + Rook
#      + #move_dirs()
#      + #symbol "R"
#    + Bishop
#    + Queen
#  + SteppingPiece
#    + #move_diffs()
#    + King
#    + Knight
#
# + Player
# + Game
#
# ---
#
# ## `Piece`
# + pos
# + board
# + color
# + moves()
#
# ## `SlidingPiece`
# + move_dirs()
# ## `SteppingPiece`
# + move_diffs()
#
# ---
#
# ## Approach
#
# 1. Board
# 2. Piece moving
# 3. Pawn (simple Game class)
# 4. in_check?(color)
# 5. update piece to have valid_moves = moves - moves_into_check (HINT:
# dup board)
# 6. check_mate?(color)
