require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  let!(:game) { Game.create!(word: 'hang') }
  let(:valid_params) { {lives: 10} }
  let(:invalid_params) { {lives: -1} }

  describe 'GET #index' do
    it 'gets all the games' do
      get :index

      expect(assigns(:games)).to eq [game]
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #show' do
    it 'gets a game' do
      get :show, {id: game.to_param}

      expect(assigns(:game)).to eq game
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #new' do
    it 'makes a new game' do
      get :new, {}

      expect(assigns(:game)).to be_a_new(Game)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new game' do
        expect {
          post :create, {game: valid_params}
        }.to change { Game.count }.by 1
      end

      it 'assigns @game' do
        post :create, {game: valid_params}
        expect(assigns(:game)).to be_a(Game)
        expect(assigns(:game)).to be_persisted
      end

      it 'redirects to the newly created game' do
        post :create, {game: valid_params}
        expect(response).to redirect_to(Game.last)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved game as @game' do
        post :create, {game: invalid_params}
        expect(assigns(:game)).to be_a_new(Game)
      end

      it 're-renders the new template' do
        post :create, {game: invalid_params}
        expect(response).to render_template('new')
      end
    end
  end

end
