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

  def find(value)
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

  def delete(value)
    current_node = root
    previous_node = nil
    previous_node_save = nil


  end

  def replace_node()

  end

  def level_order
    current_node = root
    queue = []
    sorted_array = []

    queue << current_node

    until current_node.nil?
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

    return if block_given?

    sorted_array
  end

  def inorder
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
    return if current_node.nil?

    postorder(current_node.left, result)
    postorder(current_node.right, result)

    result << current_node.value unless result.include?(current_node.value)

    return if block_given?

    result
  end

  def postorder_test
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

  def height(value); end

  def depth(value)
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
    array = inorder
    @root = build_tree(inorder)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end