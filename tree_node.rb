class PolyTreeNode
  attr_accessor :value, :parent, :children

  def initialize(value)
    @value, @parent, @children = value, nil, []
  end

  def parent=(p_node)
    old_parent = parent
    old_parent.children.delete(self) unless old_parent.nil?
    parent = p_node

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

  def depth_first_search(target)
    return self if self.value == target
    return nil if self.children.empty?

    self.children.each do |child|
      child_value = child.depth_first_search(target)
      return child_value unless child_value.nil?
    end

    nil
  end

  def breadth_first_search(target)
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
  end
end
