# frozen_string_literal: true

# Connect Four board
class GameBoard
  attr_accessor :board

  def initialize(height = 6, width = 7)
    @board = Array.new(height) { Array.new(width) }
  end
end
