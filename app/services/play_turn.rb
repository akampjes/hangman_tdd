class PlayTurn
  def initialize(game:)
    @game = game
  end

  def call(letter)
    tried_game_letter = TriedGameLetter.create(game: @game, letter: letter)

    if tried_game_letter.valid?
      unless @game.word.include?(letter)
        @game.remove_life!
      end
    end

    tried_game_letter
  end
end
