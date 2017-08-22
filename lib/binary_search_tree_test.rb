require './binary_search_tree.rb'
require 'minitest/autorun'
require 'minitest/pride'

class BinarySearchTreeTest < Minitest::Test

  def test_if_tree_exists
    tree = BinarySearchTree.new

    assert_instance_of BinarySearchTree, tree
  end

  def test_create_root_creates_new_root_node
    tree = BinarySearchTree.new
    tree.create_root(1, "Movie")

    assert_instance_of Node, tree.root
  end

  def test_insert_inserts_new_node_and_returns_depth
    tree = BinarySearchTree.new

    assert_equal tree.insert(10, "10 Movie"), 0
    assert_equal tree.insert(3, "3 Movie"), 1
    assert_equal tree.insert(5, "5 Movie"), 2
    assert_equal tree.insert(57, "57 Movie"), 1
    assert_equal tree.insert(65, "65 Movie"), 2

    assert_nil tree.insert(10, "10 Movie")
  end

  def test_include_checks_specific_node_existense
    tree = BinarySearchTree.new

    tree.insert(10, "10 Movie")
    tree.insert(100, "100 Movie")
    tree.insert(3, "3 Movie")
    tree.insert(5, "5 Movie")
    tree.insert(57, "57 Movie")
    tree.insert(65, "65 Movie")

    assert tree.include?(10)
    assert tree.include?(100)
    assert tree.include?(3)
    assert tree.include?(5)
    assert tree.include?(57)
    assert tree.include?(65)

    refute tree.include?(1)
    refute tree.include?(4)
    refute tree.include?(87)
    refute tree.include?(101)
  end

  def test_depth_of_returns_depth_of_node
    tree = BinarySearchTree.new

    tree.insert(10, "10 Movie")
    tree.insert(100, "100 Movie")
    tree.insert(3, "3 Movie")
    tree.insert(5, "5 Movie")
    tree.insert(57, "57 Movie")
    tree.insert(65, "65 Movie")

    assert_equal tree.depth_of(10), 0
    assert_equal tree.depth_of(100), 1
    assert_equal tree.depth_of(3), 1
    assert_equal tree.depth_of(5), 2
    assert_equal tree.depth_of(57), 2
    assert_equal tree.depth_of(65), 3

    assert_nil tree.depth_of(1)
    assert_nil tree.depth_of(0)
    assert_nil tree.depth_of(99)
  end

  def test_max_returns_movie_title_and_highest_rating_hash
    tree = BinarySearchTree.new

    tree.insert(10, "10 Movie")
    tree.insert(100, "100 Movie")
    tree.insert(3, "3 Movie")
    tree.insert(5, "5 Movie")
    tree.insert(57, "57 Movie")
    tree.insert(65, "65 Movie")

    assert_equal tree.max, {"100 Movie"=>100}
  end

  def test_max_returns_movie_title_and_lowest_rating_hash
    tree = BinarySearchTree.new

    tree.insert(10, "10 Movie")
    tree.insert(100, "100 Movie")
    tree.insert(3, "3 Movie")
    tree.insert(5, "5 Movie")
    tree.insert(57, "57 Movie")
    tree.insert(65, "65 Movie")

    assert_equal tree.min, {"3 Movie"=>3}
  end

  def test_sort_returns_sorted_array_of_hashes
    tree = BinarySearchTree.new

    tree.insert(10, "10 Movie")
    tree.insert(100, "100 Movie")
    tree.insert(3, "3 Movie")
    tree.insert(5, "5 Movie")

    assert_instance_of Array, tree.sort
    assert_equal [{"3 Movie"=>3 },{"5 Movie"=>5},{"10 Movie"=>10},{"100 Movie"=>100}], tree.sort
  end

  def test_load_returns_total_inserted_entries_of_file
    tree = BinarySearchTree.new

    assert_equal tree.load("movies.txt"), 99
  end

  def test_health_returns_rating_and_child_count_and_floored_percentage_of_depth
    tree = BinarySearchTree.new

    tree.insert(98, "Animals United")
    tree.insert(58, "Armageddon")
    tree.insert(36, "Bill & Ted's Bogus Journey")
    tree.insert(93, "Bill & Ted's Excellent Adventure")
    tree.insert(86, "Charlie's Angels")
    tree.insert(38, "Charlie's Country")
    tree.insert(69, "Collateral Damage")

    assert_equal tree.health(0), [[98, 7, 100]]
    assert_equal tree.health(1), [[58, 6, 85]]
    assert_equal tree.health(2), [[36, 2, 28], [93, 3, 42]]
  end

end

# #include this as integration test
#   def test_insert_inserts_new_node
#     tree = BinarySearchTree.new
#
#     tree.insert(5, "5 Movie")
#     tree.insert(1, "1 Movie")
#     tree.insert(3, "3 Movie")
#
#     #check if new nodes exist
#     # => use other methods to "inspect"
#     # => include
#   end
