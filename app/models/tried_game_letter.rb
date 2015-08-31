class TriedGameLetter < ActiveRecord::Base
  belongs_to :game

  validates :game, presence: true
  validates :letter, length: { is: 1 }
  validates :letter, format: { with: /[[:alpha:]]/, message: 'Must be an alphabetical letter'}
  validates :letter, uniqueness: { scope: :game }

  def letter=(letter) 
    super(letter.try(:downcase))
  end
end
