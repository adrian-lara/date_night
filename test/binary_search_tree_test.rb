require './lib/binary_search_tree.rb'
require 'minitest/autorun'
require 'minitest/pride'

class BinarySearchTreeTest < Minitest::Test

  def test_if_tree_exists
    tree = BinarySearchTree.new

    assert_instance_of BinarySearchTree, tree
  end

  def test_populate_root_creates_new_root_node
    tree = BinarySearchTree.new
    assert_nil tree.root
    tree.populate_root(10, "10 Movie")

    refute_nil tree.root
  end

  def test_insert_can_create_root_and_return_depth_zero
    tree = BinarySearchTree.new

    assert_equal 0, tree.insert(10, "10 Movie")
  end

  def test_insert_inserts_new_node_and_returns_depth
    tree = BinarySearchTree.new

    assert_equal 0, tree.insert(10, "10 Movie")
    assert_equal 1, tree.insert(3, "3 Movie")
    assert_equal 2, tree.insert(5, "5 Movie")
    assert_equal 1, tree.insert(57, "57 Movie")
    assert_equal 2, tree.insert(65, "65 Movie")

    assert_nil tree.insert(10, "10 Movie")
  end

  def test_insert_returns_nil_if_rating_exists_in_tree
    tree = BinarySearchTree.new

    tree.insert(10, "10 Movie")

    assert_nil tree.insert(10, "10 Movie")
  end

  def test_include_checks_specific_node_existense
    tree = BinarySearchTree.new

    refute tree.include?(10)

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

    assert_nil tree.depth_of(10)

    tree.insert(10, "10 Movie")
    tree.insert(100, "100 Movie")
    tree.insert(3, "3 Movie")
    tree.insert(5, "5 Movie")
    tree.insert(57, "57 Movie")
    tree.insert(65, "65 Movie")

    assert_equal 0, tree.depth_of(10)
    assert_equal 1, tree.depth_of(100)
    assert_equal 1, tree.depth_of(3)
    assert_equal 2, tree.depth_of(5)
    assert_equal 2, tree.depth_of(57)
    assert_equal 3, tree.depth_of(65)

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

    assert_equal({"3 Movie"=>3}, tree.min)
  end

  def test_sort_returns_sorted_array_of_hashes
    tree = BinarySearchTree.new

    tree.insert(10, "10 Movie")
    tree.insert(100, "100 Movie")
    tree.insert(3, "3 Movie")
    tree.insert(5, "5 Movie")
    tree.insert(1, "1 Movie")

    assert_instance_of Array, tree.sort
    assert_equal [{"1 Movie"=>1},{"3 Movie"=>3},{"5 Movie"=>5},{"10 Movie"=>10},{"100 Movie"=>100}], tree.sort
  end

  def test_load_returns_total_inserted_entries_of_file
    tree = BinarySearchTree.new

    assert_equal 99, tree.load("movies.txt")
  end

  def test_count_self_and_children_counts_self_and_children
    tree = BinarySearchTree.new

    tree.insert(98, "Animals United")
    assert_equal 1, tree.count_self_and_children(tree.root)

    tree.insert(58, "Armageddon")
    assert_equal 2, tree.count_self_and_children(tree.root)

    tree.insert(36, "Bill & Ted's Bogus Journey")
    assert_equal 3, tree.count_self_and_children(tree.root)

    tree.insert(93, "Bill & Ted's Excellent Adventure")
    assert_equal 4, tree.count_self_and_children(tree.root)
  end

  def test_node_health_returns_health_status_array_at_specific_node
    tree = BinarySearchTree.new

    tree.insert(98, "Animals United")
    tree.insert(58, "Armageddon")
    tree.insert(36, "Bill & Ted's Bogus Journey")

    assert_equal [98, 3, 100], tree.node_health(tree.root)
  end

  def test_health_returns_rating_and_child_count_and_floored_percentage_arrays_at_depth
    tree = BinarySearchTree.new

    tree.insert(98, "Animals United")
    tree.insert(58, "Armageddon")
    tree.insert(36, "Bill & Ted's Bogus Journey")
    tree.insert(93, "Bill & Ted's Excellent Adventure")
    tree.insert(86, "Charlie's Angels")
    tree.insert(38, "Charlie's Country")
    tree.insert(69, "Collateral Damage")

    assert_equal [[98, 7, 100]], tree.health(0)
    assert_equal [[58, 6, 85]], tree.health(1)
    assert_equal [[36, 2, 28], [93, 3, 42]], tree.health(2)
  end

  def test_integration_of_various_methods
    tree = BinarySearchTree.new

    assert_equal tree.insert(50, "50 Movie"), 0
    assert_equal tree.insert(45, "45 Movie"), 1
    assert_equal tree.insert(46, "46 Movie"), 2

    assert tree.include?(50)
    assert tree.include?(45)
    assert tree.include?(46)
    refute tree.include?(47)

    assert_equal tree.depth_of(50), 0
    assert_equal tree.depth_of(45), 1
    assert_equal tree.depth_of(46), 2
    assert_nil tree.depth_of(2)

    assert_equal tree.max, {"50 Movie"=>50}
    assert_equal tree.min, {"45 Movie"=>45}

    assert_equal tree.load("movies.txt"), 96
    assert_equal tree.load("movies.txt"), 0
  end

  def test_leaves_returns_one_if_tree_has_two_nodes
    tree = BinarySearchTree.new

    tree.insert(10, "10 Movie")
    tree.insert(100, "100 Movie")

    assert_equal 1, tree.leaves
  end

  def test_leaves_returns_the_number_of_leaves_for_tree_three_plus_nodes
    tree = BinarySearchTree.new

    tree.insert(10, "10 Movie")
    tree.insert(95, "95 Movie")
    tree.insert(3, "3 Movie")
    tree.insert(5, "5 Movie")
    tree.insert(1, "1 Movie")

    assert_equal 3, tree.leaves

    tree.insert(90, "90 Movie")
    tree.insert(100, "100 Movie")

    assert_equal 4, tree.leaves
  end

  def test_return_largest_returns_the_largest_of_three_integers
    tree = BinarySearchTree.new

    assert_equal 7, tree.return_largest(1, 2, 7)
    assert_equal 9, tree.return_largest(5, 2, 9)
  end

  def test_height_returns_height_of_tree
    tree = BinarySearchTree.new

    assert_equal 0, tree.height

    tree.insert(10, "10 Movie")
    assert_equal 1, tree.height

    tree.insert(45, "45 Movie")
    assert_equal 2, tree.height

    tree.insert(3, "3 Movie")
    assert_equal 2, tree.height

    tree.insert(5, "5 Movie")
    assert_equal 3, tree.height

    tree.insert(50, "50 Movie")
    assert_equal 3, tree.height

    tree.insert(55, "55 Movie")
    assert_equal 4, tree.height

    tree.insert(52, "52 Movie")
    assert_equal 5, tree.height
  end

end
