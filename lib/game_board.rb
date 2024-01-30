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
    valid_moves = @board[0].each_index.select { |index| @board[0][index].nil? }
    p valid_moves
    valid_moves
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
    winner_search(row_cursor: 0) ||
      winner_search(start_row: @height - 4, end_column: @width - 1, column_cursor: 0) ||
      winner_search(end_row: 3, row_cursor: -1) ||
      winner_search(start_row: @height - 4) ||
      check_for_tie ||
      false
  end

  # Iterates through starting points for combinations, beginning in the bottom left
  # corner by default and moving donwards and diagonal by default. Finishing on the top
  # row and 4th column.
  def winner_search(
    start_row: @height - 1, \
    end_row: 0, \
    start_column: 0, \
    end_column: @width - 4, \
    row_cursor: 1, \
    column_cursor: 1 \
  )
    start_row.downto(end_row) do |row|
      start_column.upto(end_column) do |column|
        test_group = []
        0.upto(3) { |index| test_group.push(@board[row + (index * row_cursor)][column + (index * column_cursor)]) }
        return test_group_winner(test_group) if test_group_winner(test_group)
      end
    end
    false
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
