require_relative 'node'

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

    split_array = if array.length <= 1
                    [array, []]
                  else
                    array.each_slice((array.length / 2.0).round).to_a
                  end
    left = build_tree(split_array[0])
    right = build_tree(split_array[1])

    Node.new(node_value, left, right)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def find(value)
    return "Error: Tree is empty." if root.nil?

    current_node = root

    until current_node.nil?
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
    return "Error: Tree is empty." if root.nil?

    current_node = root
    new_node = Node.new(value)

    until current_node.nil?
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

  def delete(value, current_node = root)
    return nil if root == nil
    return current_node if current_node.nil?

    if current_node.value > value
      current_node.left = delete(value, current_node.left)

    elsif current_node.value < value
      current_node.right = delete(value, current_node.right)

    else
      if current_node.left.nil?
        saved_node = current_node.right
        current_node = nil
        return saved_node

      elsif current_node.right.nil?
        saved_node = current_node.left
        current_node = nil
        return saved_node
      end

      node_to_delete = current_node.right
      node_to_delete = node_to_delete.left until node_to_delete.left.nil?

      saved_node = node_to_delete
      current_node.value = saved_node.value
      current_node.right = delete(saved_node.value, current_node.right)

    end

    current_node
  end

  def level_order
    return "Error: Tree is empty." if root.nil?

    current_node = root
    queue = []
    sorted_array = []

    queue << current_node

    until queue.empty?
      current_node = queue.shift

      next if current_node.nil?

      queue << current_node.left
      queue << current_node.right

      if block_given?
        yield(queue[0])
      else
        sorted_array << current_node.value
      end

    end

    return if block_given?

    sorted_array
  end

  def inorder
    return "Error: Tree is empty." if root.nil?

    current_node = root
    result = []
    stack = []

    while !stack.empty? || !current_node.nil?
      until current_node.nil?
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
    return if block_given?

    result
  end

  def inorder_recursive(current_node = root, result = [], &block)
    return "Error: Tree is empty." if root.nil?

    unless current_node.nil?
      inorder_recursive(current_node.left, result, &block)
      if block_given?
        yield current_node
      else
        result << current_node.value
      end

      inorder_recursive(current_node.right, result, &block)
    end

    return if block_given?

    result
  end

  def preorder
    return "Error: Tree is empty." if root.nil?

    current_node = root
    result = []
    stack = []

    while !stack.empty? || !current_node.nil?
      if !current_node.nil?
        if block_given?
          yield current_node
        else
          result << current_node.value
        end

        stack << current_node.right unless current_node.right.nil?
        current_node = current_node.left
      else
        current_node = stack.pop
      end
    end

    return if block_given?

    result
  end

  def postorder(current_node = root, result = [])
    return "Error: Tree is empty." if root.nil?

    return if current_node.nil?

    postorder(current_node.left, result)
    postorder(current_node.right, result)

    result << current_node.value unless result.include?(current_node.value)

    return if block_given?

    result
  end

  def postorder_test
    return "Error: Tree is empty." if root.nil?

    stack = []
    result = []
    current_node = root

    while !current_node.nil? || !stack.empty?
      until current_node.nil?
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

  def height(_value)
    return "Error: Tree is empty." if root.nil?
  end

  def depth(value)
    return "Error: Tree is empty." if root.nil?

    current_node = root
    depth_count = 0

    until current_node.nil?
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
    return "Error: Tree is empty." if root.nil?

    array = inorder
    @root = build_tree(inorder)
  end
end
