require 'rails_helper'

RSpec.describe TriedGameLetter, type: :model do
  let(:game) { Game.new_with_word }

  context 'belongs to a game' do
    it 'is invalid if there is no game' do
      expect(subject).to be_invalid
    end

    it 'belongs to a game' do
      tried_game_letter = game.tried_game_letters.new

      expect(tried_game_letter.game).to eq game
    end
  end

  describe '#letter' do
    subject { game.tried_game_letters.new }

    it 'valid as a single alphabetical char' do
      subject.letter = 'a'

      expect(subject).to be_valid
    end

    it 'downcases letter' do
      subject.letter = 'A'

      expect(subject.letter).to eq 'a'
    end

    describe 'invalid cases' do
      INVALID_INPUT = ['aa', nil, '5']
      INVALID_INPUT.each do |input|
        it "is invalid when passed #{input}" do
          subject.letter = input

          expect(subject).to be_invalid
        end
      end
    end
  end

  context 'multiple letters on game' do
    it 'may not add the same letter multiple times on the same game' do
      TriedGameLetter.create!(game: game, letter: 'a')
      dup_letter = TriedGameLetter.new(game: game, letter: 'a')

      expect(dup_letter).to be_invalid
    end
  end

  context 'try to add letters to finished game' do
    it 'is not valid' do
      allow(game).to receive(:finished?).and_return(true)
      tried_game_letter = game.tried_game_letters.new(letter: 'a')

      expect(tried_game_letter).to be_invalid
    end
  end
end
