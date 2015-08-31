require 'rails_helper'

describe GetRandomWord do
  it 'returns a random word from the dictionary' do
    # Yay srand'ing so we won't get a 1/20_000 test failure
    srand(1)
    word = GetRandomWord.new.call
    word2 = GetRandomWord.new.call

    expect(word).to_not eq word2
  end
end
