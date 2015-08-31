class PlayTurn
  def initialize(game:)
    @game = game
  end

  def call(letter)
    tried_game_letter = TriedGameLetter.new(game: @game, letter: letter)

    validate_game_not_finished(tried_game_letter)

    if tried_game_letter.valid? && @game.word.exclude?(letter)
      remove_life
    end

    tried_game_letter
  end

  private

  def validate_game_not_finished(tried_game_letter)
    if @game.finished?
      tried_game_letter.errors.add(:game, 'is already finished')
    else
      tried_game_letter.save
    end
  end
  def remove_life
    @game.transaction do
      @game.update(lives: @game.lives - 1)
    end
  end
end
