# frozen_string_literal: false

require 'pry'

# knight class for movable chess piece
class Knight
  attr_accessor :location, :children_array, :parent

  def initialize(current_location, children_array, parent = 'Origin')
    @location = current_location
    @children_array = children_array
    @parent = parent   
  end
end

# class for 8x8 grid chess board
class Board
  attr_reader :next_move, :ending_coordinates, :moves_required
  attr_accessor :knights, :optimal_path, :traversal_path

  def initialize(starting_coordinates, ending_coordinates)
    @board_array = Array.new(8, [0, 1, 2, 3, 4, 5, 6, 7])
    @start = starting_coordinates
    @ending_coordinates = ending_coordinates
    @knights = []
    @optimal_path = []
    @traversal_path = []
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

  def create_children(new_child_coord, parent)
    knights << Knight.new(new_child_coord, moves_from_current_point(new_child_coord), parent)
  end 

  def successful_child?(knight_coord)
    # return knight_coord if knight_coord == ending_coordinates
    knight_coord == ending_coordinates
  end

  def gen_and_check(knight_array = knights)
    next_knight = knight_array[0] # change to be first with the lowest depth???
    successful_child = []
    next_knight.children_array.each do |child| # adds next gen of Knight's offspring to Knight queue
      successful_child = child if successful_child?(child)
      create_children(child, next_knight) #adding next generation of this child to the queue
      break if successful_child?(child)
    end

    return knights.last unless successful_child.empty?

    knight_array.shift
    [optimal_path] << gen_and_check(knight_array) # BRACKETS, CAN'T FLATTEN RECURSIVE ARRAY
  end

  # def unravel_optimal_knight(knight)
  #   return if knight.parent == 'Origin'
  #   traversal_path << knight.location
  #   unravel_optimal_knight(knight.parent)
  # end

  def unwind_optimal_knight(knight)
    traversal_path << unwind_optimal_knight(knight.parent) unless knight.parent == 'Origin'
    return knight.location
  end

  def get_number_of_moves(starting_point, ending_point)
    knights << root = Knight.new(starting_point, moves_from_current_point(starting_point))

    optimal_path = gen_and_check(knights).flatten
    unwind_optimal_knight(optimal_path[0])
    traversal_path.push(ending_point)
    @moves_required = traversal_path.size - 1
  end

  def print_results(moves_required = self.moves_required, traversal_path = self.traversal_path)
    if moves_required == 1 
      p "Our brave Knight can accomplish the journey in #{moves_required} move."
    else
      p "Our brave Knight can accomplish the journey in #{moves_required} moves."
    end
    p "The path is as follows: #{traversal_path}."
  end  
end

def knight_moves(start_point, end_point)
  puts "\n Invalid start point \n " unless valid_user_input?(start_point)
  puts "\n Invalid end point \n " unless valid_user_input?(end_point)
  return print_instructions unless valid_user_input?(start_point) && valid_user_input?(end_point)

  board = Board.new(start_point, end_point)
  return 'Start and end point are the same. no moves required' if start_point == end_point

  board.get_number_of_moves(start_point, end_point)
  board.print_results
end

private

def print_instructions
  p "Use the 'knight_moves' function with start and end points between [0, 0] and "\
    "[7, 7] to determine the number of moves the journey will take our Knight"
  p 'Example: knight_moves([0,0],[4,5])'
end

def valid_user_input?(input)
  input.size == 2 && (0..7).include?(input[0]) && (0..7).include?(input[1])
end

print_instructions
# # Driver
# p 'Input coordinates between 0, 0 and 7, 7 for the starting point of the knight'
# text_coordinates = gets.chomp.split(',')
# starting_point = text_coordinates.map(&:to_i)
# # input handling
# p 'Input coordinates between 0, 0 and 7, 7 for the end point of the knight'
# text_coordinates = gets.chomp.split(',')
# ending_point = text_coordinates.map(&:to_i)
# # input handling

# board = Board.new(starting_point, ending_point)
# return 'Start and end point are the same. no moves required' if starting_point == ending_point

# #*******
# # if board.moves_from_current_point(starting_point) # return only 1 move required

# board.knights << root = Knight.new(starting_point, board.moves_from_current_point(starting_point))

# board.optimal_path = board.gen_and_check(board.knights).flatten
# board.unwind_optimal_knight(board.optimal_path[0])
# board.traversal_path.push(ending_point)
# moves_required = board.traversal_path.size - 1

# if moves_required == 1 
#   p "Our brave Knight can accomplish the journey in #{moves_required} move."
# else
#   p "Our brave Knight can accomplish the journey in #{moves_required} moves."
# end
# p "The path is as follows: #{board.traversal_path}."
