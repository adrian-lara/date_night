class Node

  attr_accessor :rating,
                :movie_title,
                :depth,
                :left,
                :right

  def initialize(rating, movie_title)
    @rating = rating
    @movie_title = movie_title
    @depth = 0
    @left = nil
    @right = nil
  end


end
