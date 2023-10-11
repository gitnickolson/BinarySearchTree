require_relative 'main/tree'
require_relative 'main/node'

# BST = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 40, 5, 7, 9, 67, 6345, 324])
#
# puts 'Level order:'
# BST.level_order
# BST.level_order{|element| p element}
#
# puts ''
#
# puts 'Inorder:'
# BST.inorder
# BST.inorder_recursive{|element| p element.value}
#
# puts ''
#
# puts 'Preorder:'
# BST.preorder
# BST.preorder{|element| p element}
#
# puts ''
#
# puts 'Postorder:'
# BST.postorder
# BST.postorder{|element| p element}
#
# puts ''
#
# puts '---------------------------------------------'
# BST.rebalance
# BST.pretty_print
#

# Final test
tree = Tree.new(Array.new(15) { rand(1..100) })
p tree.balanced?

tree.pretty_print

puts ''

p tree.level_order
p tree.preorder
p tree.postorder
p tree.inorder

puts ''

tree.insert(213)
tree.insert(4534)
tree.insert(763)
tree.insert(5459)
tree.insert(999)
tree.insert(643)

puts ''

p tree.balanced?
tree.rebalance
p tree.balanced?

puts ''

p tree.level_order
p tree.preorder
p tree.postorder
p tree.inorder

tree.pretty_print
