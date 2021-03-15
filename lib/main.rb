# frozen_string_literal: false

# require 'pry'
require_relative 'knight.rb'
require_relative 'board.rb'

@mapping_hash = Hash[A1: [7, 0], A2: [6, 0], A3: [5, 0], A4: [4, 0],
                     A5: [3, 0], A6: [2, 0], A7: [1, 0], A8: [0, 0],
                     B1: [7, 1], B2: [6, 1], B3: [5, 1], B4: [4, 1],
                     B5: [3, 1], B6: [2, 1], B7: [1, 1], B8: [0, 1],
                     C1: [7, 2], C2: [6, 2], C3: [5, 2], C4: [4, 2],
                     C5: [3, 2], C6: [2, 2], C7: [1, 2], C8: [0, 2],
                     D1: [7, 3], D2: [6, 3], D3: [5, 3], D4: [4, 3],
                     D5: [3, 3], D6: [2, 3], D7: [1, 3], D8: [0, 3],
                     E1: [7, 4], E2: [6, 4], E3: [5, 4], E4: [4, 4],
                     E5: [3, 4], E6: [2, 4], E7: [1, 4], E8: [0, 4],
                     F1: [7, 5], F2: [6, 5], F3: [5, 5], F4: [4, 5],
                     F5: [3, 5], F6: [2, 5], F7: [1, 5], F8: [0, 5],
                     G1: [7, 6], G2: [6, 6], G3: [5, 6], G4: [4, 6],
                     G5: [3, 6], G6: [2, 6], G7: [1, 6], G8: [0, 6],
                     H1: [7, 7], H2: [6, 7], H3: [5, 7], H4: [4, 7],
                     H5: [3, 7], H6: [2, 7], H7: [1, 7], H8: [0, 7]
                   ]

def knight_moves(start_point, end_point, board)
  # board = Board.new(end_point)
  # return 'Start and end point are the same. No moves required!' if start_point == end_point

  board.get_number_of_moves(start_point, end_point)
  board.print_results(@mapping_hash)
end

private

# def print_instructions
#   puts "Use the 'knight_moves' function with start and end points between [0, 0] and "\
#     "[7, 7] to determine the number of moves the journey will take our Knight"
#   puts 'Example: knight_moves([0,0],[4,5])'
# end

# def valid_user_input?(input)
#   input.size == 2 && (0..7).include?(input[0]) && (0..7).include?(input[1])
# end

def valid_user_input?(start_input, end_input)
  @mapping_hash.key?(start_input.to_sym) && @mapping_hash.key?(end_input.to_sym)
end

def fetch_user_input
  puts 'Enter the space where our knight will start (e.g. a1 or H3):'
  @start_input = gets.chomp.upcase
  puts 'Enter the space where our knight must journey (e.g. a1 or H3):'
  @end_input = gets.chomp.upcase
end

def map_user_input_to_numerical_coordinates(start_point, end_point)
  @start_coordinate = @mapping_hash.fetch(start_point.to_sym)
  @end_coordinate = @mapping_hash.fetch(end_point.to_sym)
end

def print_input_error
  puts 'Invalid input. Please try again using coordinates between a1 and H7'
end

def generate_response
  if @start_input == @end_input
    puts 'Start and end point are the same. No moves required!'
  elsif valid_user_input?(@start_input, @end_input)
    map_user_input_to_numerical_coordinates(@start_input, @end_input)
    board = Board.new(@end_coordinate)
    knight_moves(@start_coordinate, @end_coordinate, board)
  else
    print_input_error
  end
end

display_board = Board.new
display_board.display_board
fetch_user_input
generate_response
