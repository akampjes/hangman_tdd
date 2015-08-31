class TriedGameLetter < ActiveRecord::Base
  belongs_to :game

  validates :game, presence: true
  validates :letter, length: { is: 1 }
  validates :letter, format: { with: /[[:alpha:]]/, message: 'Must be an alphabetical letter'}
  validates :letter, uniqueness: { scope: :game }
  validate :validate_game_not_finished

  def letter=(input) 
    super(input.try(:downcase))
  end

  private

  def validate_game_not_finished
    errors.add(:game, 'is already finished') if !game.nil? && game.finished?
  end
end
