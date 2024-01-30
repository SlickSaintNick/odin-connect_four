# frozen_string_literal: true

# Connect Four board
class GameBoard
  attr_accessor :board

  def initialize(height = 6, width = 7)
    @board = Array.new(height) { Array.new(width) }
    @height = height
    @width = width
  end

  def valid_moves
    @board[0].each_index.select { |index| @board[0][index].nil? }
  end

  # Place a move if it is valid - return the row index or ERROR if invalid.
  def move(color, column)
    (@height - 1).downto(0) do |row|
      return @board[row][column] = color if @board[row][column].nil?
    end
    'ERROR'
  end

  def display_board
    display = ". 1  2  3  4  5  6  7.\n"
    0.upto(@height - 1) do |row|
      0.upto(@width - 1) do |column|
        display += "|#{game_piece(row, column)}"
      end
      display += "|\n"
    end
    display += "'===================='\n"
  end

  def game_piece(row, column)
    case @board[row][column]
    when nil
      '⚫'
    when 'R'
      '🔴'
    when 'Y'
      '🟡'
    end
  end

  # This method tests in order for horizontal, vertical, diagonal (rising) and diagonal (falling) winning
  # combinations. If all are passed, it checks for a tie.
  def winner
    winner_search(cols: [0, @width - 4], step: [0, 1]) ||
      winner_search(rows: [0, @height - 4], step: [1, 0]) ||
      winner_search(rows: [0, @height - 4], cols: [@width - 4, @width - 1], step: [1, -1]) ||
      winner_search(rows: [0, @height - 4], cols: [0, @width - 4], step: [1, 1]) ||
      check_for_tie ||
      false
  end

  # Iterates through starting points for combinations, beginning in the bottom left
  # corner by default and moving donwards and diagonal by default. Finishing on the top
  # row and 4th column.
  def winner_search(
    array: @board, \
    match: 4, \
    rows: [0, array.length - 1], \
    cols: [0, array[0].length - 1],
    step: [0, 1] \
  )
    sort_arrays(rows, cols)

    rows[0].upto(rows[1]) do |row|
      cols[0].upto(cols[1]) do |col|
        test_group = []
        0.upto(match - 1) { |index| test_group.push(@board[row + (index * step[0])][col + (index * step[1])]) }
        return test_group_winner(test_group) if test_group_winner(test_group)
      end
    end
    false
  end

  def sort_arrays(*arrays)
    arrays.each { |array| array.sort! }
  end
  # The game is tied if the top row is full.
  def check_for_tie
    return 'tie' if @board[0].none?(nil)

    false
  end

  def test_group_winner(test_group)
    return 'R' if test_group.all?('R')

    return 'Y' if test_group.all?('Y')

    false
  end

  def clear
    @board = Array.new(@height) { Array.new(@width) }
  end
end
