require 'rails_helper'

RSpec.describe PlayTurnsController, type: :controller do
  let!(:game) { Game.create!(word: 'hang', lives: 4) }

  let(:valid_params) { {game_id: game.id, play_turns: {letter: 'a'}}}
  let(:invalid_params) { {game_id: game.id, play_turns: {letter: '5'}}}

  describe 'POST #create' do
    context 'with valid params' do
      it 'Plays a letter' do
        expect {
          post :create, valid_params
        }.to change { game.tried_game_letters.count }.by 1
      end
    end

    context 'with invalid params' do
      it 'Plays an invalid letter' do
        expect {
          post :create, invalid_params
        }.to change { game.tried_game_letters.count }.by 0
      end

      it 'renders the games/show template' do
        post :create, invalid_params
        expect(response).to render_template('games/show')
      end
    end
  end
end
