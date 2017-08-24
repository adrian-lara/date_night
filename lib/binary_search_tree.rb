require 'pry'
require './lib/node.rb'

class BinarySearchTree

  attr_reader :root

  def initialize()
    @root = nil
  end

  def insert(rating, movie_title, current = @root, current_depth = 0)
    if @root.nil?
      @root = Node.new(rating, movie_title)
      return @root.depth
    end

    current_depth += 1

    if rating < current.rating
      enter_or_insert_left(rating, movie_title, current, current_depth)
    elsif rating > current.rating
      enter_or_insert_right(rating, movie_title, current, current_depth)
    end
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

  def count_children(current = @root, count = 0)
    count += 1
    count = count_children(current.left, count) unless current.left.nil?
    count = count_children(current.right, count) unless current.right.nil?
    count
  end

  def health(depth, current = @root, status = [])
    return nil if @root.nil?

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
    return nil if @root.nil?

    if current.left != nil
        return leaves(current.left, count) if current.right == nil
        count = leaves(current.left, count)
    end

    return leaves(current.right, count) if current.right != nil
    count += 1
  end

  def return_larger(first, second)
    if first >= second then first else second end
  end

  def height(current = @root, current_height = 0, height_left = 0, height_right = 0)
    return 0 if @root.nil?

    current_height += 1
    height_left = height(current.left, current_height) unless current.left.nil?
    height_right = height(current.right, current_height) unless current.right.nil?

    greater_side = return_larger(height_left, height_right)
    return_larger(current_height, greater_side)
  end

  def delete(rating, current = @root)
    # return delete_leaf(rating)
    current = find_node(rating) if current.rating != rating #move to rating node
    replacement_info = {} #establish replacment_info variable

    if current.left != nil #if left has something, save the rating and movie_title of max rating on left
      replacement_info = max_and_left(current.left)
      delete(replacement_info[0]) #save info, then try to delete or replace it
      current.left = replacement_info[2]
    elsif current.right !=  nil #if right has something, save the rating and movie_title of max rating on right
      replacement_info = min_and_right(current.right)
      delete(replacement_info[0]) #save info, then try to delete or replace it
      current.right = replacement_info[2]
    end

    current.rating = replacement_info[0]
    current.movie_title = replacement_info[1]

    rating
  end

  def max_and_left(current)
    if current.right == nil
      [current.rating, current.movie_title, current.left]
    else
      max_and_left(current.right)
    end
  end

  def min_and_right(current)
    if current.left == nil
      [current.rating, current.movie_title, current.right]
    else
      min_and_right(current.left)
    end
  end

  def find_node(rating, current = @root)
    return current if rating == current.rating

    if rating < current.rating
      find_node(rating, current.left)
    else
      find_node(rating, current.right)
    end
  end

  def delete_leaf(rating, current = @root)
    if current.left.nil? && current.right.rating == rating
      return current.right = nil if current.right.left.nil? && current.right.right.nil?
    elsif current.left.rating == rating
      current.left = nil if current.left.left.nil? && current.left.right.nil?
    end
  end

end
