# frozen_string_literal: false

# knight class for movable chess piece
class Knight
  attr_accessor :location, :children_array, :parent

  def initialize(current_location, children_array, parent = 'Origin')
    @location = current_location
    @children_array = children_array
    @parent = parent   
  end
end