require 'pry'
require './lib/node.rb'

class BinarySearchTree

  attr_reader :root

  def initialize()
    @root = nil
  end

  def create_root(rating, movie_title)
    @root = Node.new(rating, movie_title)
  end

  def enter_or_insert_left(rating, movie_title, current, current_depth)
    if current.left != nil
      insert(rating, movie_title, current.left, current_depth)
    else
      current.left = Node.new(rating, movie_title)
      current.left.depth = current_depth
    end
  end

  def enter_or_insert_right(rating, movie_title, current, current_depth)
    if current.right != nil
      insert(rating, movie_title, current.right, current_depth)
    else
      current.right = Node.new(rating, movie_title)
      current.right.depth = current_depth
    end
  end

  def insert(rating, movie_title, current = @root, current_depth = 0)
    if current == nil
      create_root(rating, movie_title)
      return @root.depth
    end

    current_depth += 1

    if rating < current.rating
      enter_or_insert_left(rating, movie_title, current, current_depth)
    elsif rating > current.rating
      enter_or_insert_right(rating, movie_title, current, current_depth)
    end
  end

  def include?(rating, current = @root)
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
    return current.depth if rating == current.rating

    if rating < current.rating && current.left != nil
      depth_of(rating, current.left)
    elsif rating > current.rating && current.right != nil
      depth_of(rating, current.right)
    end
  end

  def max(current = @root)
    if current.right == nil
      { current.movie_title => current.rating }
    else
      max(current.right)
    end
  end

  def min(current = @root)
    if current.left == nil
      { current.movie_title => current.rating }
    else
      min(current.left)
    end
  end

  def sort(current = @root, sorted_movies = [])
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

  def count_children(current = @root, count = 0)
    count += 1
    count = count_children(current.left, count) unless current.left.nil?
    count = count_children(current.right, count) unless current.right.nil?
    count
  end

  def health(depth, current = @root, status = [])
    total = count_children

    if depth == current.depth
      children = count_children(current)
      pct_of_total = (children.to_f/total * 100).to_i
      return status << [current.rating, children, pct_of_total]
    elsif current.left != nil
      health(depth, current.left, status)
    end

    health(depth, current.right, status) unless current.right.nil?

    status
  end

  def leaves(current = @root, count = 0)
    if current.left != nil
        return leaves(current.left, count) if current.right.nil?
        count = leaves(current.left, count)
    end

    if current.right != nil
      return leaves(current.right, count)
    end
    count += 1
  end

end


# def sort(current_tree = @root, movie_list = [])
#
#   return movie_list if current_tree == nil
#
#   movie_list << min
#   new_current_tree = replace_min(current_tree, current_tree) #pop out new current_tree
#   sort(new_current_tree, movie_list)
# end
#
# def replace_min(current, current_tree)
#   if current.left.left == nil && current.left.right !=  nil
#     current.left = current.left.right
#   elsif current.left.left == nil && current.left.right == nil
#     current.left = nil
#   else
#     replace_min(current.left, current_tree)
#   end
#   return current_tree #this needs to return the "newly changed root"
# end
