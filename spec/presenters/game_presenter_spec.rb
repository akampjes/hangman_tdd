require 'rails_helper'

RSpec.describe GamePresenter do
  let(:game) { Game.new(word: 'hang', lives: 4) }
  let(:game_presenter) { GamePresenter.new(game) }

  describe '#word_progress' do
    it 'starts as just underscores' do
      expect(game_presenter.word_progress).to eq '____'
    end

    it 'fills in blanks as letters are tired' do
      TriedGameLetter.create!(game: game, letter: 'a')

      expect(game_presenter.word_progress).to eq '_a__'
    end
  end
end
