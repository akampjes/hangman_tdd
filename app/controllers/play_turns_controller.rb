class PlayTurnsController < ApplicationController
  def create
    game = Game.find(params[:game_id])
    @tried_game_letter = PlayTurn.new(game: game).call(params[:play_turns][:letter])
    @game = GamePresenter.new(game)

    respond_to do |format|
      if @tried_game_letter.valid?
        format.html {redirect_to game_path(@game) }
      else
        format.html { render 'games/show' }
      end
    end
  end
end
