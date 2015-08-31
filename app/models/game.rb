class Game < ActiveRecord::Base
  has_many :tried_game_letters

  validates :word, presence: true
  validates :lives, numericality: {greater_than_or_equal_to: 0}
  validates :lives, numericality: {greater_than: 0}, on: :create

  def lost?
    lives <= 0
  end

  def won?
    # Tried letters include our word?
    (tried_game_letters.pluck(:letter) & word.chars) == word.chars
  end

  def finished?
    won? || lost?
  end
end
