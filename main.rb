# frozen_string_literal: false

require 'pry'
require_relative 'lib/knight.rb'
require_relative 'lib/board.rb'

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
