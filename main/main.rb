class Tree
  attr_accessor :array, :root, :node_counter
  def initialize(array)
    @root = build_tree(array)
    @node_counter = 0
    p root.value
  end


  def build_tree(array)
    return nil if array.empty?

    array = array.uniq.sort
    middle = array.length / 2
    p node_value = array.delete_at(middle)

    if array.length <= 1
      p split_array = [array, []]
    else
      p split_array = array.each_slice((array.length / 2.0).round).to_a
      p left_node = build_tree(split_array[0])
      p right_node = build_tree(split_array[1])
    end

    Node.new(node_value, left_node, right_node)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_node, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_node
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left_node, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_node
  end
end


class Node
  include Comparable
  attr_accessor :value, :left_node, :right_node, :comparison_result
  def initialize(value, left_node = nil, right_node = nil)
    @value = value
    @left_node = left_node
    @right_node = right_node
    comparison_result = left_node <=> right_node

    if comparison_result == 1
      temp = left_node
      left_node = right_node
      right_node = temp
    end
  end
end

BST = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
BST.pretty_print


