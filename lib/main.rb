# frozen_string_literal: true

require_relative 'connect_four'
require_relative 'player'
require_relative 'game_board'

puts 'Player 1 name?'
print '>> '
player1_name = gets.chomp

puts "\nPlayer 2 name?"
print '>> '
player2_name = gets.chomp

ConnectFour.new(player1_name, player2_name).play_game
