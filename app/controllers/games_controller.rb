class GamesController < ApplicationController

  before_filter :set_game, only: [:show]

  def index
    @games = GamePresenter.wrap(Game.all)
  end

  def show
    @tried_game_letter = TriedGameLetter.new
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params.merge({word: PickRandomWord.new.call}))

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  private

  def set_game
    @game = GamePresenter.new(Game.find(params[:id]))
  end

  def game_params
    params.require(:game).permit(:lives)
  end
end
