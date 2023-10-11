require_relative 'main/tree'
require_relative 'main/node'

BST = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 40, 5, 7, 9, 67, 6345, 324])

puts 'Level order:'
p BST.level_order
# BST.level_order{|element| p element}

puts ''

puts 'Inorder:'
p BST.inorder
# BST.inorder_recursive{|element| p element.value}

puts ''

puts 'Preorder:'
p BST.preorder
# BST.preorder{|element| p element}

puts ''

puts 'Postorder:'
p BST.postorder
# BST.postorder{|element| p element}

puts ''
BST.delete(3)

puts '---------------------------------------------'
BST.pretty_print
