require 'rails_helper'

RSpec.describe TriedGameLetter, type: :model do
  let(:game) { Game.new_with_word }

  context 'belongs to a game' do
    it 'is invalid if there is no game' do
      expect(subject).to be_invalid
    end

    it 'belongs to a game' do
      tried_game_letter = TriedGameLetter.new(game: game)

      expect(tried_game_letter.game).to eq game
    end
  end

  describe '#letter' do
    let(:tried_game_letter) { TriedGameLetter.new(game: game) }

    it 'is invalid if more than one char long' do
      tried_game_letter.letter = 'aa'
      
      expect(tried_game_letter).to be_invalid
    end

    it 'must be alphabetical' do
      tried_game_letter.letter = '5'

      expect(tried_game_letter).to be_invalid
    end

    it 'valid as a single alphabetical char' do
      tried_game_letter.letter = 'a'
      
      expect(tried_game_letter).to be_valid
    end

    it 'is invalid without a letter' do
      expect(tried_game_letter).to be_invalid
    end

    it 'downcases letter' do
      tried_game_letter.letter = 'A'

      expect(tried_game_letter.letter).to eq 'a'
    end
  end

  context 'multiple letters on game' do
    it 'may not add the same letter multiple times on the same game' do
      TriedGameLetter.create!(game: game, letter: 'a')
      dup_letter = TriedGameLetter.create(game: game, letter: 'a')
      
      expect(dup_letter).to be_invalid
    end
  end
end
