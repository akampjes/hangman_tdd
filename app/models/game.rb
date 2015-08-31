class Game < ActiveRecord::Base
  has_many :tried_game_letters

  validates :word, presence: true
  validates :lives, numericality: {greater_than_or_equal_to: 0}
  validates :lives, numericality: {greater_than: 0}, on: :create

  def self.new_with_word(options = {})
    options[:word] = GetRandomWord.new.call
    new(options)
  end

  def lost?
    lives <= 0
  end

  def won?
    letters_to_guess.none?
  end

  def finished?
    won? || lost?
  end

  # TODO - unnescesary(?) parens
  def remove_life!
    update(lives: (lives - 1))
  end

  private

  def letters_to_guess
    tried_game_letters.pluck(:letter) - word.chars
  end
end
