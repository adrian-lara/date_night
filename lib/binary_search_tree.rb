require './lib/node.rb'

class BinarySearchTree

  attr_reader :root

  def initialize()
    @root = nil
  end

  def populate_root(rating, movie_title)
    @root = Node.new(rating, movie_title)
  end

  def insert(rating, movie_title, current = @root, current_depth = 0)
    if @root.nil?
      populate_root(rating, movie_title)
      return @root.depth
    end

    current_depth += 1
    if rating < current.rating
      insert_left(rating, movie_title, current, current_depth)
    elsif rating > current.rating
      insert_right(rating, movie_title, current, current_depth)
    end
  end

  def insert_left(rating, movie_title, current, current_depth)
    if current.left != nil
      insert(rating, movie_title, current.left, current_depth)
    else
      current.left = Node.new(rating, movie_title)
      current.left.depth = current_depth
    end
  end

  def insert_right(rating, movie_title, current, current_depth)
    if current.right != nil
      insert(rating, movie_title, current.right, current_depth)
    else
      current.right = Node.new(rating, movie_title)
      current.right.depth = current_depth
    end
  end

  def include?(rating, current = @root)
    return false if @root.nil?
    return true if rating == current.rating

    if rating < current.rating && current.left != nil
      include?(rating, current.left)
    elsif rating > current.rating && current.right != nil
      include?(rating, current.right)
    else
      false
    end
  end

  def depth_of(rating, current = @root)
    return nil if @root.nil?
    return current.depth if rating == current.rating

    if rating < current.rating && current.left != nil
      depth_of(rating, current.left)
    elsif rating > current.rating && current.right != nil
      depth_of(rating, current.right)
    end
  end

  def max(current = @root)
    return nil if @root.nil?

    if current.right == nil
      { current.movie_title => current.rating }
    else
      max(current.right)
    end
  end

  def min(current = @root)
    return nil if @root.nil?

    if current.left == nil
      { current.movie_title => current.rating }
    else
      min(current.left)
    end
  end

  def sort(current = @root, sorted_movies = [])
    return sorted_movies if @root.nil?

    sort(current.left, sorted_movies) unless current.left.nil?
    sorted_movies << { current.movie_title => current.rating }
    sort(current.right, sorted_movies) unless current.right.nil?

    sorted_movies
  end

  def load(movie_file)
    insert_count = 0
    File.open(movie_file, "r").readlines("\n").each do |line|
      rating, movie_title = line.chomp.split(', ', 2)
      insert_count += 1 unless insert(rating.to_i, movie_title).nil?
    end
    insert_count
  end

  def count_self_and_children(current, count = 0)
    count += 1
    count = count_self_and_children(current.left, count) unless current.left.nil?
    count = count_self_and_children(current.right, count) unless current.right.nil?
    count
  end

  def node_health(node)
    total_nodes = count_self_and_children(@root)
    children = count_self_and_children(node)
    pct_of_total = (children.to_f/total_nodes * 100).to_i
    [node.rating, children, pct_of_total]
  end

  def health(depth, current = @root, status = [])
    return nil if @root.nil?
    return status << node_health(current) if depth == current.depth

    health(depth, current.left, status) unless current.left.nil?
    health(depth, current.right, status) unless current.right.nil?

    status
  end

  def leaves(current = @root, count = 0)
    return nil if @root.nil?

    if current.left != nil
        return leaves(current.left, count) if current.right == nil
        count = leaves(current.left, count)
    end

    return leaves(current.right, count) if current.right != nil
    count += 1
  end

  def return_largest(first, second, third)
    [first, second, third].sort[-1]
  end

  def height(current = @root, current_height = 0, height_left = 0, height_right = 0)
    return 0 if @root.nil?

    current_height += 1
    height_left = height(current.left, current_height) unless current.left.nil?
    height_right = height(current.right, current_height) unless current.right.nil?

    return_largest(current_height, height_left, height_right)
  end

end
