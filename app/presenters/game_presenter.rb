class GamePresenter < SimpleDelegator
  def self.wrap(collection)
    collection.map do |obj|
      new obj
    end
  end

  def word_progress
    unless tried_game_letters.blank?
      tried_letters = tried_game_letters.map(&:letter).join
      word.gsub(/[^#{tried_letters}]/, '_')
    else
      '_' * word.length
    end
  end
end
