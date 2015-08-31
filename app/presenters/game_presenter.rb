class GamePresenter < SimpleDelegator
  def self.wrap(collection)
    collection.map do |obj|
      new(obj)
    end
  end

  def word_progress
    if tried_game_letters.present?
      tried_letters = tried_game_letters.map(&:letter).join
      word.gsub(/[^#{tried_letters}]/, '_')
    else
      '_' * word.length
    end
  end
end
