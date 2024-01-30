# frozen_string_literal: true

# Player in a game of Connect 4.
class Player
  attr_accessor :color, :name

  def initialize(color, name = 'Player')
    @color = color
    @name = name
  end

  def take_turn(valid_moves)
    loop do
      input = ask_user_input
      next unless test_input(input)

      return input.to_i if valid_moves.include?(input.to_i)
    end
  end

  def play_again?
    puts "Press enter to play again, or type 'exit' to finish."
    ask_user_input
  end

  def ask_user_input
    print '>> '
    gets.chomp.strip.upcase
  end

  def test_input(string)
    !!(string =~ /^[1-7]$/)
  end
end
