class PickRandomWord
  def call
    File.readlines('words.txt').sample.chomp
  end
end
