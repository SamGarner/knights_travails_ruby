# frozen_string_literal: false

require 'pry'

# knight class for movable chess piece
class Knight
  attr_accessor :location, :parent_location, :depth

  def initialize(current_location, parent = current_location, depth = 0)
    @location = current_location
    @parent_location = parent
    # add a depth attribute/counter ?
    @depth = depth
    
  end
end

# input two coordinates
# (Driver) - make sure coordinates are valid and within the Board grid (Board)
# initialize Knight with current location as current location and parent
# (loop/recurse)
#   get list of allowable moves from Knight and init a new knight for each
#   check if 'current location' of any of the new knights matches the end goal location
#     if no, repeat this for all of the newly created knights
#     if yes, count the number of returns up the return chain to get number of moves and 
#         add parents to answer array of move/coordinates needed

# class for 8x8 grid chess board
class Board
  attr_reader :next_move, :ending_coordinates
  attr_accessor :knights

  def initialize(starting_coordinates, ending_coordinates)
    @board_array = Array.new(8, [0, 1, 2, 3, 4, 5, 6, 7])
    @start = starting_coordinates
    @end = ending_coordinates
    @knights = []
  end

  def moves_from_current_point(current_point)
    @next_move = []
    x = current_point[0]
    y = current_point[1]
    next_move << [x + 1, y + 2]
    next_move << [x + 1, y - 2]
    next_move << [x - 1, y + 2]
    next_move << [x - 1, y - 2]
    next_move << [x + 2, y + 1]
    next_move << [x + 2, y - 1]
    next_move << [x - 2, y + 1]
    next_move << [x - 2, y - 1]
    next_move.select { |n| (0..7).include?(n[0]) && (0..7).include?(n[1]) }
  end

  def create_children(current_location, move_to_coordinates, depth)
    # move to coordinates = array of coordinate arrays
    move_to_coordinates.each do |coordinates|
      knights << Knight.new(coordinates, current_location, depth)
    end
  end

  def end_point_reached?(move_to_coordinates, ending_coordinates) #move to will be array of coords?
    move_to_coordinates.any? { |coordinates| coordinates == ending_coordinates }
  end

  # def matches_endpoint(move_to_coordinates, ending_coordinates)
  #   move_to_coordinates.select { |coordinates| coordinates == ending_coordinates }
  # end
  def end_point_knight(knights)
    knights.select { |k| k.location = ending_coordinates }
  end

  def build_tree(next_move_array)
    # next_move_array.each { |move| p moves_from_current_point(move) }
    #   # create array for each path ?
    next_move_array.each do |move|
      following_moves = []
      following_moves[0] = move
      following_moves[1] = moves_from_current_point(move)
      # how to store parent node?
      p following_moves
    end
  end

  def full_tree(current_point)
    moves = moves_from_current_point(current_point)
    15.times do
      build_tree(build_tree(moves))
    end
  end
end

# Driver
  # move from [0, 0] to [3, 3]
p 'Input coordinates between 0, 0 and 7, 7 for the starting point of the knight'
text_coordinates = gets.chomp.split(',')
starting_point = text_coordinates.map(&:to_i)
# input handling
p 'Input coordinates between 0, 0 and 7, 7 for the end point of the knight'
text_coordinates = gets.chomp.split(',')
ending_point = text_coordinates.map(&:to_i)
# input handling

# starting_coordinates =  
board = Board.new(starting_point, ending_point)
board.knights << root = Knight.new(starting_point, 'start')

# everything below will go into method loop?
depth_counter = 0

# def check_next_generation

  board.knights.each do |knight| #make the next generation of children
    next if knight.depth != depth_counter

    next_possibilities = board.moves_from_current_point(knight.location)
   
    # binding.pry
    # next_possibilities.each do |move|
    #   board.create_children(knight.location, move, knight.depth + 1)
    # end
    board.create_children(knight.location, next_possibilities, knight.depth + 1)
  end

  # check the next gen of knights that was just generated
  board.knights.each do |knight|
    next if knight.depth != depth_counter + 1

    if knight.location == ending_point
      # binding.pry
      p knight.parent_location#, knight.depth
      p knight.depth #explicit return to feed up the chain?
      return p "#{knight.depth} moves required to get to endpoint"
    else
      false
    end
  end
# end

binding.pry


# move_to_options = board.moves_from_current_point(root.location)
# board.create_children(root.location, move_to_options) #binding in here?
# binding.pry



# until move_to_options.includes?(ending_point) 
#   moves_from_current_point()
# end

# until board.end_point_reached?(move_to_options, ending_point)
#   move_to_options.each do |move|
#     create_children(move, board.moves_from_current_point(move))
#   end
#   move_to_options << board.moves_from_current_point

  # next_moves = board.moves_from_current_point(move_to_options)
  # next_moves.each do |move|
  #   create_children(move)

  # board.end_point_knight(knights)

binding.pry
#BFS
# queue = []
# queue << root.location

# if board.end_point_reached?


# -should a 'node' have a 'left_value' and 'right_value' for the two coordinates or is that overcomplicating?

# @ [4, 4]
# can move to:
# [2, 3]
# [2, 5]
# [3, 2]
# [3, 6]
# [5, 2]
# [5, 6]
# [7, 3]
# [7. 5]