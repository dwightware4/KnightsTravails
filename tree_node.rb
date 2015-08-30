class PolyTreeNode
  attr_accessor :value, :parent, :children
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(p_node)
    old_parent = @parent
    old_parent.children.delete(self) unless old_parent.nil?
    @parent = p_node

    p_node.children << self unless (p_node.nil? || p_node.children.include?(self))
  end

  def add_child(child)
    self.children << child unless self.children.include?(child)
    child.parent = self
  end

  def remove_child(child)
    if !self.children.include?(child)
      raise("Passed child not a child of self")
    else
      self.children.delete(child)
      child.parent = nil
    end
  end

  def dfs(target)
    return self if self.value == target
    return nil if self.children.empty?

    self.children.each do |child|
      child_value = child.dfs(target)
      return child_value unless child_value.nil?
    end

    nil
  end

  def bfs(target)
    arr = [self]
    until arr.empty?
      first = arr.shift
      if first.value == target
        return first
      else
        first.children.each do |g_child|
          arr << g_child
        end
      end
    end
    nil
  end

  def trace_path_back
    node = self
    path = []
    until node.parent.nil?
      path << node.value
      node = node.parent
    end
    path << node.value
    # path
  end

  #fix later - not working
  def depth_first_print
    puts self.value.to_s
    #if !children.empty?
    self.children.each do |child|
        child.depth_first_print
    end
#    else
#      return nil
#    end
  end

  def breadth_first_print
    arr = [self]

    until arr.empty?
      first = arr.shift
      puts first.value.to_s
      #if first.value == target
      #  return first
      #else
        first.children.each do |g_child|
          arr << g_child
        end
      #end
    end

    nil
  end



end
