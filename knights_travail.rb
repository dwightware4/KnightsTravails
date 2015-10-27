require './tree_node.rb'

class KnightPathFinder
  attr_accessor :visited_squares, :root_node, :position

  def initialize(pos)
    @position, @visited_squares, @root_node = pos, [pos], PolyTreeNode.new(pos)
    build_move_tree(root_node)
  end

  def build_move_tree(node)
    pos = node.value
    possible_moves = get_children(node)

    possible_moves.each do |move|
        build_move_tree(move)
    end
  end

  def get_children(node)
    created_nodes = []

    [1, -1].each do |x|
      [2, -2].each do |y|
        offsets = [x, y]
        2.times do
          pos = [node.value[0] + offsets[0], node.value[1] + offsets[1]]
          offsets.rotate!
          next unless valid_move?(pos)
          created_nodes << create_move_node(pos, node)
          visited_squares << pos
        end
      end
    end

    created_nodes
  end

  def valid_move?(pos)
    on_board?(pos) && !visited_squares.include?(pos)
  end

  def create_move_node(pos, parent)
      move_node = PolyTreeNode.new(pos)
      move_node.parent = parent
      move_node
  end

  def on_board?(pos)
    pos.all? { |el| el >= 0  && el < 8 }
  end

  def find_path(end_pos)
    end_node = root_node.depth_first_search(end_pos)
    end_node.trace_path_back.reverse
  end
end
