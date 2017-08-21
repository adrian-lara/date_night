require './binary_search_tree.rb'
require 'minitest/autorun'
require 'minitest/pride'

class BinarySearchTreeTest < Minitest::Test

  def test_if_tree_exists
    tree = BinarySearchTree.new

    assert_instance_of BinarySearchTree, tree
  end

end


#
# tree = BinarySearchTree.new
# tree.load("movies.txt")
#
# # create tree
# # tree.insert(12, "Title of Movie")
# # tree.insert(11, "Sequel")
# # tree.insert(13, "Prequel")
# # tree.insert(15, "New Max")
# # tree.insert(14, "Movie 14")
#
#
# # #test include
# puts "#{tree.include?(11)} <--- should be true"
# puts "#{tree.include?(12)} <--- should be true"
# puts "#{tree.include?(13)} <--- should be true"
# puts "#{tree.include?(101)} <--- should be false"
#
# #test depth_of
# puts "#{tree.depth_of(55)} <--- should be 2"
# puts "#{tree.depth_of(75)} <--- should be 2"
# puts "#{tree.depth_of(101)} <--- should be nil/empty"
#
# # test min and max
# puts "#{tree.min} <--- should be { 'Cruel Intentions' => 0 }"
# puts "#{tree.max} <--- should be { 'The Little Engine That Could' => 100 }"
#
# # p tree.sort
