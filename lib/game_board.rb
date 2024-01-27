# frozen_string_literal: true

# Connect Four board
class GameBoard
  attr_accessor :board

  def initialize(height = 6, width = 7)
    @board = Array.new(height) { Array.new(width) }
    @height = height
    @width = width
  end

  # Place a move if it is valid - return the row index or ERROR if invalid.
  def move(color, column)
    (@height - 1).downto(0) do |row|
      return @board[row][column] = color if @board[row][column].nil?
    end
    'ERROR'
  end

  def winner
    return winner_horizontal if winner_horizontal

    return winner_vertical if winner_vertical

    return winner_diagonal_rising if winner_diagonal_rising

    return winner_diagonal_falling if winner_diagonal_falling

    false
  end

  # TODO: Refactor these to a single method.
  def winner_horizontal
    (@height - 1).downto(0) do |row|
      0.upto(@width - 4) do |column|
        test_group = []
        0.upto(3) { |index| test_group.push(@board[row][column + index]) }
        return test_group_winner(test_group) if test_group_winner(test_group)
      end
    end
    false
  end

  def winner_vertical
    (@height - 4).downto(0) do |row|
      0.upto(@width - 1) do |column|
        test_group = []
        0.upto(3) { |index| test_group.push(@board[row + index][column]) }
        return test_group_winner(test_group) if test_group_winner(test_group)
      end
    end
    false
  end

  def winner_diagonal_rising
    (@height - 1).downto(3) do |row|
      0.upto(@width - 4) do |column|
        test_group = []
        0.upto(3) { |index| test_group.push(@board[row - index][column + index]) }
        return test_group_winner(test_group) if test_group_winner(test_group)
      end
    end
    false
  end

  def winner_diagonal_falling
    (@height - 4).downto(0) do |row|
      0.upto(@width - 4) do |column|
        test_group = []
        0.upto(3) { |index| test_group.push(@board[row + index][column + index]) }
        return test_group_winner(test_group) if test_group_winner(test_group)
      end
    end
    false
  end

  def test_group_winner(test_group)
    return 'R' if test_group.all?('R')

    return 'Y' if test_group.all?('Y')

    false
  end
end
