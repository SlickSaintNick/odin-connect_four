# frozen_string_literal: true

require_relative '../lib/player'
# require_relative '../lib/game_board'

describe Player do
  subject(:player) { described_class.new('R') }

  describe '#test_input' do
    it 'returns true for valid inputs and false for invalid inputs' do
      expect(player.test_input('1')).to be true
      expect(player.test_input('3')).to be true
      expect(player.test_input('12')).to be false
      expect(player.test_input('0')).to be false
      expect(player.test_input('cat')).to be false
    end
  end

  describe "#take_turn" do
    it 'returns correct value for a specific scenario' do
      $stdout = StringIO.new
      allow(player).to receive(:ask_user_input).and_return('1', '2', '3', 'cat', 'dog', '9', '6')

      valid_moves = [1, 3, 6]

      expect(player.take_turn(valid_moves)).to eq(1)
      expect(player.take_turn(valid_moves)).to be(3)
    end
  end
end