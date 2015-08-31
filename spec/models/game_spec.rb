require 'rails_helper'

RSpec.describe Game, type: :model do
  let(:word) { 'hang' }
  let(:game) { Game.create!(word: word) }

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
      subject.lives = -1
      expect(subject).to be_invalid
    end

    it 'may not be created with less than 1 life' do
      game = Game.new(word: word, lives: 0)
      expect(game).to be_invalid
    end
  end

  describe '#tried_game_letters' do
    it 'has some tried_game_letters' do
      tried_game_letter = game.tried_game_letters.create!(letter: 'a')
      tried_game_letter2 = game.tried_game_letters.create!(game: game, letter: 'b')

      expect(game.tried_game_letters).to eq [tried_game_letter, tried_game_letter2]
    end
  end

  context 'playing a new game' do
    it 'may have varible lives' do
      game = Game.new(lives: 10, word: word)

      expect(game.lives).to eq 10
    end
  end

  describe "#finished?" do
    it 'starts unfinished' do
      expect(game.finished?).to eq false
    end

    it 'is finished when won' do
      word.chars.each { |c| game.tried_game_letters.create(letter: c) }

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
      word.chars.each { |c| game.tried_game_letters.create(letter: c) }

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
end
