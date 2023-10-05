class Tree
  attr_accessor :array, :root
  def initialize(array)
    array = array
    root
  end
end


class Node
  include Comparable
  attr_accessor :value, :left_node, :right_node, :comparison_result
  def initialize(value, left, right)
    value = value
    left_node = left
    right_node = right

    comparison_result = left_node <=> right_node
  end
end




