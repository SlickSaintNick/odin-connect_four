# frozen_string_literal: true

require_relative '../lib/connect_four'

describe ConnectFour do
  subject(:game) { described_class.new('NAME', 'NAME') }

  describe '#display_players' do
    it 'returns a string showing the players' do
      return_string = game.display_players
      expected_string = <<~HEREDOC
        >> Red <<
           NAME

           Yellow
           NAME

      HEREDOC
      expect(return_string).to eql(expected_string)
    end
  end

  describe '#display_title' do
    it 'returns a string with the title' do
      return_string = game.display_title
      expected_string = <<~HEREDOC
        🔴 CONNECT 4 🟡

      HEREDOC
      expect(return_string).to eql(expected_string)
    end
  end

  describe '#display' do
    context 'when first initialized' do
      it 'returns a string with the title, players and board' do
        return_string = game.display
        expected_string = <<~HEREDOC
          🔴 CONNECT 4 🟡

          >> Red <<
             NAME

             Yellow
             NAME

          . 1  2  3  4  5  6  7.
          |⚫|⚫|⚫|⚫|⚫|⚫|⚫|
          |⚫|⚫|⚫|⚫|⚫|⚫|⚫|
          |⚫|⚫|⚫|⚫|⚫|⚫|⚫|
          |⚫|⚫|⚫|⚫|⚫|⚫|⚫|
          |⚫|⚫|⚫|⚫|⚫|⚫|⚫|
          |⚫|⚫|⚫|⚫|⚫|⚫|⚫|
          '===================='
        HEREDOC
        expect(return_string).to eql(expected_string)
      end
    end
  end

  describe '#game_loop' do
    let(:double_player1) { double('Player1') }

    before do
      allow(game).to receive(:loop).and_yield
      allow(double_player1).to receive(:take_turn).and_return(1)
    end

    context "when it is player 1's turn" do
      it 'sends a message to player 1 to take their turn' do
        $stdout = StringIO.new

        expect(double_player1).to receive(:take_turn).once
        game.game_loop(double_player1)
      end
    end
  end

  describe '#next turn' do
    context "when it is player 1's turn" do
      it 'swaps current player to player 2' do
        $stdout = StringIO.new
        initial_player = game.instance_variable_get(:@current_player)

        game.next_turn

        expect(game.instance_variable_get(:@current_player)).to eq(game.instance_variable_get(:@player2))
        expect(game.instance_variable_get(:@current_player)).not_to eq(initial_player)
      end
    end
  end
end
