require 'pry'
require './node.rb'

class BinarySearchTree

  attr_reader :root

  def initialize()
    @root = nil
  end


  def create_root(rating, movie_title)
    @root = Node.new(rating, movie_title)
  end


  # top priority for refactoring
  # maybe need to better understand the flow
  #   (take same approach of brainstorming as with sort)
  # definitely can split out nested ifs in the if statement
  #   (would just have to iterate insert from within a different method?)
  def insert(rating, movie_title, working = @root, working_depth = 0)
    if working == nil
      create_root(rating, movie_title)
      return @root.depth
    end

    working_depth += 1

    if rating < working.rating
      if working.left != nil
        insert(rating, movie_title, working.left, working_depth)
      else
        working.left = Node.new(rating, movie_title)
        working.left.depth = working_depth
      end
    elsif rating > working.rating
      if working.right != nil
        insert(rating, movie_title, working.right, working_depth)
      else
        working.right = Node.new(rating, movie_title)
        working.right.depth = working_depth
      end
    end
  end


  def include?(rating, working = @root)
    return true if rating == working.rating

    if rating < working.rating && working.left != nil
      include?(rating, working.left)
    elsif rating > working.rating && working.right != nil
      include?(rating, working.right)
    else
      false
    end
  end


  def depth_of(rating, working = @root)
    return working.depth if rating == working.rating

    if rating < working.rating && working.left != nil
      depth_of(rating, working.left)
    elsif rating > working.rating && working.right != nil
      depth_of(rating, working.right)
    end
  end


  def max(working = @root)
    if working.right == nil
      { working.movie_title => working.rating }
    else
      max(working.right)
    end
  end


  def min(working = @root)
    if working.left == nil
      { working.movie_title => working.rating }
    else
      min(working.left)
    end
  end

  def sort(working = @root, sorted_movies = [])
    sort(working.left, sorted_movies) if working.left != nil #consider unless
    sorted_movies << { working.movie_title => working.rating }
    sort(working.right, sorted_movies) if working.right !=nil #consider unless

    sorted_movies
  end

  #refactor, likely possible to iterate directly from file.
  def load(movie_file)
    file = File.open(movie_file, "r").readlines("\n") # should I 'append' the map enumerable at the end of this line???
    movie_list = file.map { |movie| movie.chomp }
    insert_count = 0

    movie_list.each do |entry|
      rating, movie_title = entry.split(', ', 2)
      insert_count += 1 if insert(rating.to_i, movie_title) != nil #consider unless
    end
    insert_count
  end

end


# def sort(working_tree = @root, movie_list = [])
#
#   return movie_list if working_tree == nil
#
#   movie_list << min
#   new_working_tree = replace_min(working_tree, working_tree) #pop out new working_tree
#   sort(new_working_tree, movie_list)
# end
#
# def replace_min(working, working_tree)
#   if working.left.left == nil && working.left.right !=  nil
#     working.left = working.left.right
#   elsif working.left.left == nil && working.left.right == nil
#     working.left = nil
#   else
#     replace_min(working.left, working_tree)
#   end
#   return working_tree #this needs to return the "newly changed root"
# end
