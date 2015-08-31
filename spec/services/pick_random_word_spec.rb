require 'rails_helper'

describe PickRandomWord do
  it 'returns a random word from the dictionary' do
    # Yay srand'ing so we won't get a 1/20_000 test failure
    srand(1)
    word = PickRandomWord.new.call
    word2 = PickRandomWord.new.call

    expect(word).to_not eq word2
  end
end
