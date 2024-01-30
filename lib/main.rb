# frozen_string_literal: true

require_relative 'connect_four'
require_relative 'player'
require_relative 'game_board'

def ask_name(player_number)
  puts "Player #{player_number} name?"
  print '>> '
  gets.chomp
end

player1_name = ask_name(1)
player2_name = ask_name(2)
ConnectFour.new(player1_name, player2_name).play_game
