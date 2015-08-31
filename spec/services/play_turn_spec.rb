require 'rails_helper'

RSpec.describe PlayTurn do
  let(:game) { Game.new(word: 'hang', lives: 4) }
  subject { PlayTurn.new(game: game) }

  it 'requires a game' do
    expect { PlayTurn.new }.to raise_error ArgumentError
  end

  context 'creates a new tried_game_letter' do
    it 'has a new letter' do
      subject.call('a')

      expect(game.tried_game_letters).not_to be_empty
    end

    it 'decreases lives if letter is not in hangman word' do
      expect { subject.call('b') }.to change { game.lives }.by -1
    end

    it 'does not change lives if letter is in hangman word' do
      expect { subject.call('a') }.to change { game.lives }.by 0
    end
  end

  context 'play a whole game' do
    it 'wins the game' do
      subject.call('h')
      subject.call('a')
      subject.call('n')
      subject.call('g')

      expect(game.won?).to be true
    end

    it 'loses the game' do
      subject.call('b')
      subject.call('c')
      subject.call('d')
      subject.call('e')

      expect(game.lost?).to be true
    end

    it 'stops further play when game is finished' do
      subject.call('b')
      subject.call('c')
      subject.call('d')
      subject.call('e')

      expect { subject.call('h') }.to change { TriedGameLetter.count }.by 0
    end
  end
end
