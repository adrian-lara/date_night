require './node.rb'
require 'minitest/autorun'
require 'minitest/pride'

class NodeTest < Minitest::Test

  def test_if_node_exists
    node = Node.new(1, "Movie")

    assert_instance_of Node, node
  end

end
