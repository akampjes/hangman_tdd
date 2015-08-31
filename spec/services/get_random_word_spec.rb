require 'rails_helper'

describe GetRandomWord do
  it 'returns a random word from the dictionary' do
    word = GetRandomWord.new.call
    word2 = GetRandomWord.new.call

    expect(word).to_not eq word2
  end
end
