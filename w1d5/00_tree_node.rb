class PolyTreeNode
  def initialize(value)
    @parent = nil
    @children = []
    @value = value
  end

  def parent
    @parent
  end

  def children
    @children
  end

  def trace_path_back
    if parent.nil?
      [self.value]
    else
      array = parent.trace_path_back
      array << self.value
    end
  end

  def value
    @value
  end

  def parent=(parent)
    @parent.children.delete(self) unless @parent.nil?
    @parent = parent
    @parent.children << self unless @parent.nil?
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child)
    raise "Bad parent=!" if @children.delete(child).nil?
    child.parent = nil
  end

  def dfs(target_value)
    if @value == target_value
      return self
    else
      @children.each do |child|
        child_search_result = child.dfs(target_value)
        return child_search_result if child_search_result
      end
    end

    nil
  end

  def bfs(target_value)
    queue = []
    queue << self
    until queue.empty?
      current = queue.pop
      if current.value == target_value
        return current
      else
        current.children.each do |child|
          queue.unshift(child)
        end
      end
    end

    nil
  end
end
