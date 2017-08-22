require './node.rb'
require 'minitest/autorun'
require 'minitest/pride'

class NodeTest < Minitest::Test

  def test_if_node_exists
    node = Node.new(1, "Movie")

    assert_instance_of Node, node
  end

  def test_node_has_a_rating
    node = Node.new(1, "Movie")

    assert_equal 1, node.rating
  end

  def test_node_has_a_movie_title
    node = Node.new(1, "Movie")

    assert_equal "Movie", node.movie_title
  end

  def test_node_has_a_depth
    node = Node.new(1, "Movie")

    assert_equal 0, node.depth
  end

  def test_node_has_a_left
    node = Node.new(1, "Movie")

    assert_nil node.left
  end

  def test_node_has_a_right
    node = Node.new(1, "Movie")

    assert_nil node.right
  end

end
