# frozen_string_literal: true

# A Connect 4 game.
class ConnectFour
  def initialize
    @player1 = Player.new('R')
    @player2 = Player.new('Y')
    @current_player = @player1
    @board = GameBoard.new
  end

  def play_game(player = @current_player)
    # puts display
    player_move = player.take_turn(@board.valid_moves)
    system(exit) if player_move == 'EXIT'
    @game_board.move(@current_player.color, player_move)
    check_for_win = @game_board.winner
    next_turn
  end


  def next_turn
    @current_player = if @current_player == @player1
                        @player2
                      else
                        @player1
                      end
  end

  def display
    display = display_title
    display += display_players
    display += @board.display_board
  end

  def display_players
    display = ''
    display += @current_player.color == 'R' ? ">> Red <<\n" : "   Red\n"
    display += "   #{@player1.name}\n\n"
    display += @current_player.color == 'Y' ? ">> Yellow <<\n" : "   Yellow\n"
    display += "   #{@player2.name}\n\n"
  end

  def display_title
    "🔴 CONNECT 4 🟡\n\n"
  end
end
