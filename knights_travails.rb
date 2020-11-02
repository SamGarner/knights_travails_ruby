# frozen_string_literal: false

require 'pry'

# knight class for movable chess piece
class Knight
  def initialize(current_location, parent = current_location)
    @location = current_location
    @parent_location = parent
  end
end

# class for 8x8 grid chess board
class Board
  attr_reader :next_move

  def initialize
    @board_array = Array.new(8, [0, 1, 2, 3, 4, 5, 6, 7])
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