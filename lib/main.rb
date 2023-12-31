# frozen_string_literal: true

require_relative 'tree'
require_relative 'node'

tree = Tree.new(Array.new(20) { rand(1..100) })

tree.pretty_print
puts "Is the tree balanced?: #{tree.balanced?}"

puts ''

puts 'Level order:'
p tree.level_order

puts 'Preorder:'
p tree.preorder

puts 'Postorder:'
p tree.postorder

puts 'Inorder:'
p tree.inorder

puts ''

counter = 20
while counter.positive?
  tree.insert(rand(100..10_000))
  counter -= 1
end

puts ''

tree.pretty_print
puts "Is the tree balanced?: #{tree.balanced?}"

tree.rebalance

tree.pretty_print
puts "Is the tree balanced?: #{tree.balanced?}"

puts ''

puts 'Level order:'
p tree.level_order

puts 'Preorder:'
p tree.preorder

puts 'Postorder:'
p tree.postorder

puts 'Inorder:'
p tree.inorder
