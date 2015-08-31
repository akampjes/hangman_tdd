require 'rails_helper'

RSpec.feature "playing a game", :type => :feature do
  let(:word) { 'hang' }
  let(:incorrect_word) { 'bcd' }
  let!(:game) { Game.create!(word: word, lives: 3) }


  describe 'playing through a game' do
    scenario 'wins a game' do
      visit game_path(game)

      word.chars.reduce('') do |progress, letter|
        expect(page).to have_content progress.ljust(4, '_')

        fill_in 'Letter', with: letter
        click_on 'Guess'

        expect(page).to have_selector 'li', text: letter
        progress + letter
      end

      expect(page).to have_content 'won'
    end

    scenario 'loses a game' do
      visit game_path(game)

      incorrect_word.chars.each do |letter|
        expect(page).to have_content '____'

        fill_in 'Letter', with: letter
        click_on 'Guess'

        expect(page).to have_selector 'li', text: letter
      end

      expect(page).to have_content 'lost'
    end
  end

  describe 'incorrect input' do
    scenario 'enter an invalid letter' do
      visit game_path(game)

      fill_in 'Letter', with: '5'
      click_on 'Guess'

      expect(page).to have_selector '#error_explanation'
    end
  end
end
