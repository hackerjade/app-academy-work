require './00_tree_node.rb'

class KnightPathFinder
  MOVE_DIFFS = [
    [1, 2],
    [1, -2],
    [2, 1],
    [2, -1],
    [-1, 2],
    [-1, -2],
    [-2, 1],
    [-2, -1]
  ]

  def initialize(position)
    @start_position = position
    @visited_positions = [position]
    @root = build_move_tree
  end

  def self.valid_move?(pos)
    # x, y = pos
    pos.all? { |coord| coord.between?(0, 7) }
    # return PolyTreeNode.new(pos) unless  x < 0 || x > 7 || y < 0 || y > 7
  end

  def generate_positions(position)
    MOVE_DIFFS.map do |move|
      x, y = move
      init_x, init_y = position
      [init_x + x, init_y + y]
    end
  end

  def new_move_positions(position)
    generate_positions(position).select do |val_pos|
      self.class.valid_move?(val_pos)
    end
  end

  def visited_position?(valid_pos)
    if @visited_positions.include?(valid_pos)
      true
    else
      @visited_positions << valid_pos
      false
    end
  end

  def build_move_tree
    root_node = PolyTreeNode.new(@start_position)
    queue = [root_node]

    until queue.empty?
      current = queue.pop
      children_moves = new_move_positions(current.value)

      children_moves.each do |pos|
        unless visited_position?(pos)
          node = PolyTreeNode.new(pos)
          queue.unshift(node)
          current.add_child(node)
        end
      end
    end

    root_node
  end

  def find_path(end_pos)
    @root.bfs(end_pos).trace_path_back
  end
end

test = KnightPathFinder.new([0,0])
p test.find_path([6,2])
