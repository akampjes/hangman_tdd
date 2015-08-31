# This should really be renamed Guess
class TriedGameLetter < ActiveRecord::Base
  belongs_to :game

  validates :game, presence: true
  validates :letter, length: { is: 1 }
  validates :letter, format: { with: /[[:alpha:]]/, message: 'Must be an alphabetical letter'}
  validates :letter, uniqueness: { scope: :game }

  # PS likes to use before_validation here
  def letter=(input) 
    super(input.try(:downcase))
  end
end
