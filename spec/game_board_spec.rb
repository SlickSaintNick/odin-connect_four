# frozen_string_literal: true

# Counter characters 🔴  R 🟡  Y

require_relative '../lib/game_board'

describe GameBoard do
  subject(:game_board) { described_class.new }
  it 'initializes with a board array' do
    expect(game_board.board).to be_an_instance_of(Array)
  end

  it 'initializes with given height and width' do
    game_board_one_row = described_class.new(1, 2)
    expect(game_board_one_row.board).to eql([[nil, nil]])

    game_board_one_column = described_class.new(2, 1)
    expect(game_board_one_column.board).to eql([[nil], [nil]])
  end

  it 'defaults to height 6, width 7' do
    expect(game_board.board).to eql(
      [
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil]
      ]
    )
  end

  it 'adds an "R" in position [5][0] when receives move("R", 0)' do
    expect { game_board.move('R', 0) }
      .to change { game_board.board[5][0] }
      .from(nil).to('R')
  end

  context 'When the board is partially full in a triangular pattern' do
    subject(:game_board_triangle) { described_class.new }
    before do
      game_board_triangle.board = [
        ['R', nil, nil, nil, nil, nil, nil],
        ['R', 'R', nil, nil, nil, nil, nil],
        ['R', 'R', 'R', nil, nil, nil, nil],
        ['R', 'R', 'R', 'R', nil, nil, nil],
        ['R', 'R', 'R', 'R', 'R', nil, nil],
        ['R', 'R', 'R', 'R', 'R', 'R', nil]
      ]
    end

    it 'does not add a piece if the row is full with move ("R", 0)' do
      expect { game_board_triangle.move('R', 0) }
        .not_to change { game_board_triangle.board }
    end

    it 'adds a piece in [1][2] with move ("R", 2)' do
      expect { game_board_triangle.move('R', 2) }
        .to change { game_board_triangle.board[1][2] }
        .from(nil).to('R')
    end

    it 'returns "ERROR" if the row is full' do
      response = game_board_triangle.move('R', 0)
      expect(response).to eql('ERROR')
    end
  end

  context 'When the red player has won with a horizontal connect 4' do
    subject(:game_board_h_win) { described_class.new }

    before do
      game_board_h_win.board = [
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        ['Y', 'Y', 'Y', 'R', 'R', 'R', 'R']
      ]
    end

    it 'returns "R" as the winner' do
      winner = game_board_h_win.winner
      expect(winner).to eql('R')
    end
  end

  context 'When the yellow player has won with a vertical connect 4' do
    subject(:game_board_v_win) { described_class.new }

    before do
      game_board_v_win.board = [
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, 'Y', nil],
        [nil, nil, nil, nil, nil, 'Y', nil],
        [nil, nil, nil, nil, nil, 'Y', nil],
        [nil, nil, nil, 'R', 'R', 'Y', 'R']
      ]
    end

    it 'returns "Y" as the winner' do
      winner = game_board_v_win.winner
      expect(winner).to eql('Y')
    end
  end

  context 'When the red player has won with a rising diagonal connect 4' do
    subject(:game_board_d_rising_win) { described_class.new }

    before do
      game_board_d_rising_win.board = [
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, 'R', 'R', nil],
        [nil, nil, nil, 'R', 'Y', 'Y', 'Y'],
        [nil, nil, 'R', 'Y', 'R', 'Y', 'Y'],
        [nil, 'R', 'Y', 'R', 'R', 'Y', 'R']
      ]
    end

    it 'returns "R" as the winner' do
      winner = game_board_d_rising_win.winner
      expect(winner).to eql('R')
    end
  end

  context 'When the yellow player has won with a falling diagonal connect 4' do
    subject(:game_board_d_falling_win) { described_class.new }

    before do
      game_board_d_falling_win.board = [
        ['Y', nil, nil, nil, nil, nil, nil],
        ['Y', 'Y', nil, nil, nil, nil, nil],
        ['Y', 'R', 'Y', nil, nil, nil, nil],
        ['R', 'Y', 'R', 'Y', nil, nil, nil],
        ['R', 'Y', 'R', 'Y', nil, nil, nil],
        ['R', 'Y', 'R', 'Y', nil, nil, nil]
      ]
    end

    it 'returns "R" as the winner' do
      winner = game_board_d_falling_win.winner
      expect(winner).to eql('Y')
    end
  end

  context 'When the board is full and no player has won' do
    subject(:game_board_full_tie) { described_class.new }

    before do
      game_board_full_tie.board = [
        ['Y', 'R', 'R', 'Y', 'R', 'R', 'R'],
        ['Y', 'Y', 'R', 'R', 'R', 'Y', 'Y'],
        ['Y', 'R', 'Y', 'Y', 'Y', 'R', 'R'],
        ['R', 'Y', 'R', 'R', 'R', 'Y', 'R'],
        ['R', 'Y', 'R', 'Y', 'Y', 'R', 'Y'],
        ['R', 'Y', 'R', 'Y', 'R', 'Y', 'R']
      ]
    end

    it 'returns false' do
      winner = game_board_full_tie.winner
      expect(winner).to be false
    end
  end
end
