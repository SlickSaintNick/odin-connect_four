# frozen_string_literal: true

# A Connect 4 game.
class ConnectFour
  def initialize(*names)
    @player1 = Player.new('R', names[0])
    @player2 = Player.new('Y', names[1])
    @current_player = @player1
    @board = GameBoard.new
  end

  def play_game
    puts display_intro
    gets
    game_loop
  end

  def game_loop(player = @current_player)
    loop do
      puts display
      valid_moves = @board.valid_moves.map { |move| move + 1 }
      player_move = player.take_turn(valid_moves) - 1
      @board.move(@current_player.color, player_move)
      display_winner(@board.winner) if @board.winner
      next_turn
    end
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
    display + @board.display_board
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

  def display_intro
    <<~HEREDOC
         __________  _   ___   ______________________ __
        / ____/ __ \\/ | / / | / / ____/ ____/_  __/ // /
       / /   / / / /  |/ /  |/ / __/ / /     / / / // /_
      / /___/ /_/ / /|  / /|  / /___/ /___  / / /__  __/
      \\____/\\____/_/ |_/_/ |_/_____/\\____/ /_/    /_/

      For two players.

      Place four pieces in a row horizontally, vertically or diagonally.
      Type the column number 1-7 to make your move.

      Press Enter to continue...
    HEREDOC
  end

  def display_winner(winner)
    puts display
    case winner
    when 'R' || 'Y'
      puts "\n#{@current_player.name} won that round!\n"
    when 'tie'
      puts "\nThe game was a tie!\n"
    end
    system(exit) if @current_player.play_again? == 'EXIT'
    @board.clear
  end
end
