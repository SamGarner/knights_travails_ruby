# frozen_string_literal: false

# class for 8x8 grid chess board
class Board

  attr_reader :ending_coordinates, :moves_required
  attr_accessor :knights, :optimal_path, :traversal_path

  def initialize(ending_coordinates)
    # @board_array = Array.new(8, [0, 1, 2, 3, 4, 5, 6, 7])
    # @start = starting_coordinates
    @ending_coordinates = ending_coordinates
    @knights = []
    @optimal_path = [] # holds path of Knight objects that represent the traversal
    @traversal_path = [] # hold just the coordinates of the Knight objects in the optimal_path array above
  end

  def moves_from_current_point(current_point)
    next_move = []
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
      create_children(child, next_knight) # adding next generation, possible children of current child in each loop
      break if successful_child?(child) # stop evaluating possible children/next moves if final position achieved
    end

    return knights.last unless successful_child.empty? # if last child created meets end condition, return it

    knight_array.shift # remove the just evaluated knight from the queue
    [optimal_path] << gen_and_check(knight_array) # BRACKETS, CAN'T FLATTEN RECURSIVE ARRAY
  end

  def unwind_optimal_knight(knight)
    traversal_path << unwind_optimal_knight(knight.parent) unless knight.parent == 'Origin'
    knight.location # work up the parental chain to get the coordinates of required moves
  end

  def get_number_of_moves(starting_point, ending_point)
    knights << Knight.new(starting_point, moves_from_current_point(starting_point))

    optimal_path = gen_and_check(knights).flatten
    unwind_optimal_knight(optimal_path[0]) # gets the coordinates of the traversal moves by following parent nodes
    traversal_path.push(ending_point)
    @moves_required = traversal_path.size - 1
  end

  def print_results(moves_required = self.moves_required, traversal_path = self.traversal_path)
    if moves_required == 1 
      puts "Our brave Knight can accomplish the journey in #{moves_required} move."
    else
      puts "Our brave Knight can accomplish the journey in #{moves_required} moves."
    end
    puts "The path is as follows: #{traversal_path}."
  end  
end