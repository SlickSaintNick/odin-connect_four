# frozen_string_literal: true

# Counter characters 🔴  R 🟡  Y

require_relative '../lib/game_board'

describe GameBoard do
  it 'initializes with a board array' do
    game_board = GameBoard.new
    expect(game_board.board).to be_an_instance_of(Array)
  end

  it 'initializes with given height and width' do
    game_board = GameBoard.new(1, 2)
    expect(game_board.board).to eql([[nil, nil]])

    game_board = GameBoard.new(2, 1)
    expect(game_board.board).to eql([[nil], [nil]])
  end

  it 'defaults to height 6, width 7' do
    game_board = GameBoard.new
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

  it 'adds a "R" in position [6][0] '
end
