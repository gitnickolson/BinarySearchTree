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
    left = build_tree(split_array[0])
    right = build_tree(split_array[1])

    Node.new(node_value, left, right)
  end

  def find(value)
    current_node = root

    while current_node != nil
      return current_node if current_node.value == value
      if current_node.value < value
        previous_node = current_node
        current_node = current_node.right

      else
        previous_node = current_node
        current_node = current_node.left
      end
    end
  end

  def insert(value)
    current_node = root
    new_node = Node.new(value)

    while current_node != nil
      return p "The given value is already in the tree (#{value})" if current_node.value == value
      if current_node.value < new_node.value
        direction = :right
        previous_node = current_node
        current_node = current_node.right

      else
        direction = :left
        previous_node = current_node
        current_node = current_node.left
      end
    end

    if direction == :left
      previous_node.left = new_node
    else
      previous_node.right = new_node
    end
  end

  def delete(value)
    current_node = root
    previous_node = nil
    previous_node_save = nil

    while current_node != nil && current_node.value != value
      if current_node.value < value
        direction = :right
        previous_node = current_node
        current_node = current_node.right

      else
        direction = :left
        previous_node = current_node
        current_node = current_node.left
      end
    end
    return pp "The value doesn't exist in the tree!" if current_node == nil

    deleted_value = root
    current_node == root ? previous_node_save = previous_node : previous_node_save = current_node

    right_save = current_node.right
    left_save = current_node.left

    if current_node.left == nil && current_node.right == nil # Keine child node
      replace_node(previous_node_save, current_node, direction, 0)

    elsif current_node.left == nil || current_node.right == nil #Eine child node
      replace_node(previous_node_save, current_node, direction, 1)

    elsif current_node.left != nil && current_node.right != nil
      current_node = current_node.right
      while current_node.left != nil
        previous_node = current_node
        current_node = current_node.left
      end

      current_node.left = left_save
      current_node.right = right_save

      previous_node.left = nil

      if deleted_value == root
        replace_node(previous_node_save, current_node, direction, 2, root)
      else
        replace_node(previous_node_save, current_node, direction, 2)
      end
    end
    deleted_value
  end

  def replace_node(previous_node_save, node, direction, children, is_root = false)
    if direction == :right
      case children
      when 0
        previous_node_save.right = nil

      when 1
        previous_node_save.right = node.left

      when 2
        if root == true
          previous_node_save.value = node.value
        else
          previous_node_save.right = node
        end
      end

    else
      case children
      when 0
        previous_node_save.left = nil

      when 1
        previous_node_save.left = node.left

      when 2
        if root == true
          previous_node_save.left = node
        else
          previous_node_save.value = node.value
        end
      end
    end
  end

  def level_order
    current_node = root
    queue = []
    sorted_array = []

    queue << current_node

    while current_node != nil
      queue << current_node.left
      queue << current_node.right

      if block_given?
        yield(queue[0])
      else
        sorted_array << current_node.value
      end

      queue.shift
      current_node = queue[0]
    end

    if !block_given?
      sorted_array
    end
  end

  def inorder
    current_node = root
    result = []
    stack = []

    while !stack.empty? || current_node != nil
      while current_node != nil
        stack << current_node
        current_node = current_node.left
      end

      current_node = stack.pop

      if block_given?
        yield current_node
      else
        result << current_node.value
      end

      current_node = current_node.right
    end

    if !block_given?
      result
    end
  end

  def inorder_recursive(current_node = root, result = [])
    if current_node != nil
      inorder(current_node.left, result)
      if block_given?
        yield current_node
      else
        result << current_node.value
      end

      inorder(current_node.right, result)
    end

    if !block_given?
      result
    end
  end

  def preorder
    current_node = root
    result = []
    stack = []

    while !stack.empty? || current_node != nil
      if current_node != nil
        if block_given?
          yield current_node
        else
          result << current_node.value
        end

        stack << current_node.right if current_node.right != nil
        current_node = current_node.left
      else
        current_node = stack.pop
      end
    end

    if !block_given?
      result
    end
  end

  def postorder(current_node = root, result = [])
    return if current_node.nil?

    postorder(current_node.left, result)
    postorder(current_node.right, result)

    result << current_node.value if !result.include?(current_node.value)

    if !block_given?
      result
    end
  end

  def postorder
    stack = []
    result = []
    current_node = root

    while current_node != nil || !stack.empty?
      while current_node != nil
        stack << current_node
        current_node = current_node.left
      end

      current_node = stack.last
      if current_node.right.nil? || current_node.right == result.last
        stack.pop
        result << current_node.value
        current_node = nil
      else
        current_node = current_node.right
      end
    end

    p result
  end


  def height(value)

  end

  def depth(value)
    current_node = root
    depth_count = 0

    while current_node != nil
      return p depth_count if current_node.value == value
      if current_node.value < value
        previous_node = current_node
        current_node = current_node.right
        depth_count += 1

      else
        previous_node = current_node
        current_node = current_node.left
        depth_count += 1
      end
    end
  end

  def rebalance
    array = inorder
    @root = build_tree(inorder)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end


class Node
  attr_accessor :value, :left, :right
  def initialize(value, left = nil, right = nil)
    @value = value
    @left = left
    @right = right
  end
end

###########################################################################################
BST = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 40, 5, 7, 9, 67, 6345, 324])

puts "Level order:"
p BST.level_order
# BST.level_order{|element| p element}

puts ""

puts "Inorder:"
p BST.inorder
# BST.inorder{|element| p element}

puts ""

puts "Preorder:"
p BST.preorder
# BST.preorder{|element| p element}

puts ""

puts "Postorder:"
p BST.postorder
#BST.postorder{|element| p element}

puts ""

puts "---------------------------------------------"
BST.pretty_print



