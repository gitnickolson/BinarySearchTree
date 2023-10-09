class Tree
  attr_accessor :array, :root, :node_counter
  def initialize(array)
    @root = build_tree(array)
    @node_counter = 0
  end

  def build_tree(array)
    return nil if array.empty?

    array = array.uniq.sort
    middle = array.length / 2
    node_value = array.delete_at(middle)

    if array.length <= 1
      split_array = [array, []]
    else
      split_array = array.each_slice((array.length / 2.0).round).to_a
    end
    left_node = build_tree(split_array[0])
    right_node = build_tree(split_array[1])

    Node.new(node_value, left_node, right_node)
  end

  def insert(value)
    current_node = root
    new_node = Node.new(value)

    while current_node != nil
      return p "The given value is already in the tree (#{value})" if current_node.value == value
      if current_node.value < new_node.value
        direction = :right
        last_node = current_node
        current_node = current_node.right_node

      else
        direction = :left
        last_node = current_node
        current_node = current_node.left_node
      end
    end

    if direction == :left
      last_node.left_node = new_node
    else
      last_node.right_node = new_node
    end
  end

  def delete(value)
    current_node = root
    new_node = Node.new(value)
    last_node = nil

    while current_node != nil
      break if last_node == value
      if current_node.value < new_node.value
        direction = :right
        last_node = current_node
        current_node = current_node.right_node

      else
        direction = :left
        last_node = current_node
        current_node = current_node.left_node
      end
    end

    last_node
  end

  def find(value)
    current_node = root
    new_node = Node.new(value)

    while current_node != nil
      return p "#{current_node}" if current_node.value == value
      if current_node.value < new_node.value
        direction = :right
        last_node = current_node
        current_node = current_node.right_node

      else
        direction = :left
        last_node = current_node
        current_node = current_node.left_node
      end
    end
  end

  def height(value)
    current_node = root
    new_node = Node.new(value)
    height_count = 0
    post_value = false

    while current_node != nil
      if current_node.value == value || post_value == true
        if post_value == true
          height_count += 1
        end
        post_value = true
      end

      if current_node.value < new_node.value
        direction = :right
        last_node = current_node
        current_node = current_node.right_node

      else
        direction = :left
        last_node = current_node
        current_node = current_node.left_node
      end
    end

    p height_count
  end

  def depth(value)
    current_node = root
    new_node = Node.new(value)
    depth_count = 0

    while current_node != nil
      return p depth_count if current_node.value == value
      if current_node.value < new_node.value
        direction = :right
        last_node = current_node
        current_node = current_node.right_node
        depth_count += 1

      else
        direction = :left
        last_node = current_node
        current_node = current_node.left_node
        depth_count += 1
      end
    end
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_node, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_node
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left_node, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_node
  end
end


class Node
  attr_accessor :value, :left_node, :right_node
  def initialize(value, left_node = nil, right_node = nil)
    @value = value
    @left_node = left_node
    @right_node = right_node

  end
end

BST = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
BST.insert(5)
BST.insert(29)
BST.delete(29)
BST.find(67)
BST.depth(67)
BST.height(67)
BST.depth(3)
BST.height(3)

BST.pretty_print



