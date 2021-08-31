require_relative '../lib/game'
require_relative '../lib/cage'
require_relative '../lib/player'

describe Cage do
  let(:cage) { described_class.new }
  describe '#drop_token' do
    before do
      cage.instance_variable_set(:@cage, [
                                   ['', '', '', '', '', '', ''],
                                   ['', '', '', '', '', '', ''],
                                   ['', '', '', '', '', '', ''],
                                   ['', '', '', '', '', '', ''],
                                   ['', '', '', '', '', 'X', ''],
                                   ['', '', '', '', '', '', '']
                                 ])
    end
    it 'returns position in the cage' do
      grid = cage.instance_variable_get(:@cage)
      grid_position = grid[grid.size - 2][5]
      expect(grid_position).to eq('X')
      cage.drop_token(6, 'X')
    end
  end

  describe '#valid_choice?' do
    let(:cage) { described_class.new }

    context 'when input is 3' do
      it 'returns true' do
        input = '3'
        expect(cage.valid_choice?(input)).to be(true)
      end
    end

    context 'when input is 10' do
      it 'returns false' do
        input = '10'
        expect(cage.valid_choice?(input)).not_to be(true)
      end
    end
  end

  describe '#cage_full?' do
    let(:cage) { described_class.new }

    context 'when cage is full' do
      before do
        cage.instance_variable_set(:@cage, [
                                     %w[A A A A A A A],
                                     %w[A A A A A A A],
                                     %w[A A A A A A A],
                                     %w[A A A A A A A],
                                     %w[A A A A A A A],
                                     %w[X O X O X O X]
                                   ])
      end
      it 'returns true' do
        expect(cage).to be_cage_full
      end
    end

    context 'when cage is not full' do
      before do
        cage.instance_variable_set(:@cage, [
                                     ['', '', '', '', '', '', ''],
                                     ['', '', '', '', '', '', ''],
                                     ['', '', '', '', '', '', ''],
                                     ['', '', '', '', '', '', ''],
                                     ['', '', '', '', '', '', ''],
                                     %w[X O X O X O X]
                                   ])
      end
      it 'returns false' do
        expect(cage).not_to be_cage_full
      end
    end
  end

  describe '#winner?' do
    let(:cage) { described_class.new }
    context 'when four in a row is found' do
      before do
        cage.instance_variable_set(:@cage, [
                                     ['', '', '', '', '', '', ''],
                                     ['', '', '', '', '', '', ''],
                                     ['', '', '', '', '', '', ''],
                                     ['', '', '', '', '', '', ''],
                                     ['', '', '', '', '', '', ''],
                                     ['', '', '', 'X', 'X', 'X', 'X']
                                   ])
      end
      it 'returns true' do
        expect(cage).to be_winner
      end
    end

    context 'when four in a column is found' do
      before do
        cage.instance_variable_set(:@cage, [
                                     ['X', '', '', '', '', '', ''],
                                     ['X', '', '', '', '', '', ''],
                                     ['X', '', '', '', '', '', ''],
                                     ['X', '', '', '', '', '', ''],
                                     ['', '', '', '', '', '', ''],
                                     ['', '', '', '', '', '', '']
                                   ])
        allow(cage).to receive(:four_in_a_row?).and_return(false)
      end
      it 'returns true' do
        expect(cage).to be_winner
      end
    end

    context 'when four in a diagonal from right is found' do
      before do
        cage.instance_variable_set(:@cage, [
                                     ['', '', '', '', '', '', 'X'],
                                     ['', '', '', '', '', 'X', ''],
                                     ['', '', '', '', 'X', '', ''],
                                     ['', '', '', 'X', '', '', ''],
                                     ['', '', '', '', '', '', ''],
                                     ['', '', '', '', '', '', '']
                                   ])
        allow(cage).to receive(:four_in_a_row?).and_return(false)
        allow(cage).to receive(:four_in_a_column?).and_return(false)
      end
      it 'returns true' do
        expect(cage).to be_winner
      end
    end

    context 'when four in a diagonal from left is found' do
      before do
        cage.instance_variable_set(:@cage, [
                                     ['X', '', '', '', '', '', ''],
                                     ['', 'X', '', '', '', '', ''],
                                     ['', '', 'X', '', '', '', ''],
                                     ['', '', '', 'X', '', '', ''],
                                     ['', '', '', '', '', '', ''],
                                     ['', '', '', '', '', '', '']
                                   ])
        allow(cage).to receive(:four_in_a_row?).and_return(false)
        allow(cage).to receive(:four_in_a_column?).and_return(false)
      end
      it 'returns true' do
        expect(cage).to be_winner
      end
    end
  end
end

describe Game do
  describe '#initialize' do
    let(:game) { described_class.new }
    cage = game.cage.cage
    player_one = game.player_one
    player_two = game.player_two
    it 'creates an empty cage' do
      expect(cage).to be_a(Array)
    end

    it 'creates an instance of Player class called player_one' do
      expect(player_one).to be_an_instance_of(Player)
    end

    it 'creates an instance of Player class called player_two' do
      expect(player_two).to be_an_instance_of(Player)
    end

    it 'sets player_one as the current player' do
      expect(game.current_player).to eq(player_one)
    end
  end

  describe '#switch_current_player' do
    let(:game) { described_class.new }
    it 'changes the current player from 1 to 2' do
      expect(game.switch_current_player).to eq(game.player_two)
    end

    it 'changes the current player back to player_one' do
      expect(game.switch_current_player).to eq(game.player_one)
    end
  end
end

describe Player do
  context 'creating a new player' do
    player_one = Player.new('Player 1', 'X')

    it "returns 'Player 1' as the number of player_one"
    expect(player_one.num).to eq('Player 1')
  end

  it "returns 'X' as the token of player_one" do
    expect(player_one.token).to eq('X')
  end
end
