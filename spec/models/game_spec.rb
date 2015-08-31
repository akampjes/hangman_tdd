require 'rails_helper'

RSpec.describe Game, type: :model do
  let(:word) { 'potato' }
  let(:game) { Game.new(word: 'hang') }

  context 'new' do
    it 'can be created with a word' do
      game = Game.new(word: word)

      expect(game.word).to eq word
    end

    it 'is invalid if no word is provided' do
      expect(subject).to be_invalid
    end

    it 'defaults to 8 lives' do
      expect(subject.lives).to eq 8
    end

    it 'may only have positive lives' do
      game.lives = -1
      expect(game).to be_invalid
    end

    it 'may not be created with less than 1 life' do
      game = Game.new(word: 'hang', lives: 0)
      expect(game).to be_invalid
    end
  end

  describe '##new_with_word' do
    let(:game) { Game.new_with_word }
    it 'creates with a word already' do
      expect(game.word).to be_present
    end

    it 'uses a different word each time' do
      game2 = Game.new_with_word

      expect(game.word).to_not eq game2.word
    end

    it 'has a word without a new line' do
      expect(game.word).to eq game.word.chomp
    end

    it 'uses GetRandomWord to get a random word' do
      stubbed_instance = double(call: 'celery')  
      allow(GetRandomWord).to receive(:new).and_return(stubbed_instance)

      expect(game.word).to eq 'celery'
    end
  end

  describe '#tried_game_letters' do
    it 'has some tried_game_letters' do
      tried_game_letter = TriedGameLetter.create!(game: game, letter: 'a')
      tried_game_letter2 = TriedGameLetter.create!(game: game, letter: 'b')

      expect(game.tried_game_letters).to eq [tried_game_letter, tried_game_letter2]
    end
  end

  context 'playing a new game' do
    it 'may have varible lives' do
      game = Game.new_with_word(lives: 10)

      expect(game.lives).to eq 10
    end
  end

  describe "#finished?" do
    it 'starts unfinished' do
      expect(game.finished?).to eq false
    end

    it 'is finished when won' do
      TriedGameLetter.create!(game: game, letter: 'h')
      TriedGameLetter.create!(game: game, letter: 'a')
      TriedGameLetter.create!(game: game, letter: 'n')
      TriedGameLetter.create!(game: game, letter: 'g')

      expect(game.finished?).to be true
    end

    it 'is finished when lost' do
      game.lives = 0

      expect(game.finished?).to be true 
    end
  end

  describe "#won?" do
    it 'starts not won' do
      expect(game.won?).to be false
    end

    it 'may be won' do
      TriedGameLetter.create!(game: game, letter: 'h')
      TriedGameLetter.create!(game: game, letter: 'a')
      TriedGameLetter.create!(game: game, letter: 'n')
      TriedGameLetter.create!(game: game, letter: 'g')

      expect(game.won?).to be true
    end
  end

  describe "#lost?" do
    it 'starts not lost' do
      expect(game.lost?).to be false
    end

    it 'lost when no more lives' do
      game.lives = 0

      expect(game.lost?).to be true
    end
  end

  describe "#remove_life!" do
    it 'removes a life' do
      expect { game.remove_life! }.to change { game.lives }.by -1
    end
  end
end
