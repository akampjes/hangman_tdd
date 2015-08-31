require 'rails_helper'

RSpec.feature 'creating a new game', type: :feature do
  scenario 'create a new game' do
    visit games_path

    expect(page).to have_content 'games'

    click_on 'Create game'
    fill_in 'Lives', with: '10'
    click_on 'Create'

    expect(page).to have_content '10 lives remaining'
  end

  scenario 'try new game with invaild input' do
    visit games_path

    expect(page).to have_content 'games'

    click_on 'Create game'
    fill_in 'Lives', with: '0'
    click_on 'Create'

    expect(page).to have_selector '#error_explanation'
  end
end
