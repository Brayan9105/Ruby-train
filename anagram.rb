require 'minitest/autorun'

class Anagram
  attr_reader :anagrams, :ananagrams

  def initialize
    @words = []
    @anagrams = []
    @ananagrams = []

    File.foreach("words.txt") do |line|
    @words << line.chomp
    end
  end

  def find_anagrams()
    @words.each do |word_a|
      @words.each do |word_b|
        next if word_a == word_b
        @anagrams << word_a if anagram?(word_a, word_b)
        @ananagrams << word_a unless anagram?(word_a, word_b) || @ananagrams.include?(word_a)
      end
    end
  end

  def anagram?(word_a, word_b)
    word_a.split('').sort.join('') == word_b.split('').sort.join('')
  end

  def validate_string(string)
    anagrams = []
    @words.each do |word_a|
      next if word_a == string
      anagrams << word_a if anagram?(word_a, string)
    end

    anagrams
  end
end

obj = Anagram.new

obj.find_anagrams()
p obj.anagrams
p obj.ananagrams

p obj.validate_string('code')
p obj.validate_string('babey')
p obj.validate_string('labe')

# class AnagramTest < Minitest::Test
#   def setup
#   end

#   def test_anagrams
#     obj = Anagram.new
#     assert_equal ["abel", "able"], obj.anagrams()
#   end

#   def test_ananagrams
#     obj = Anagram.new
#     assert_equal ["aaron", "abacus", "abandon", "abandoned", "abandoning", "abandonment", "abandons", "abate", "abatement", "abba", "abbas", "abbey", "abbot", "abbott", "abbreviation", "abbreviations", "abdomen", "abdominal", "abduct", "abducted", "abduction", "abel", "aberdeen", "aberration", "abide", "abiding", "abigail", "abilities", "ability", "able", "abner", "abnormalities", "abnormally", "aboard", "abode", "abolish", "abolishing", "abolition", "abolitionist", "abolitionists", "abominable", "abomination", "aboriginal", "abort", "abortion", "abortionists", "abortions", "abound", "abounds", "about", "above", "abraham", "abrasions", "abreast", "abridge"], obj.ananagrams()
#   end

#   def test_validate_string
#     obj = Anagram.new
#     assert_equal [], obj.validate_string('code')
#     assert_equal ["abbey"], obj.validate_string('babey')
#     assert_equal ["abel", "able"], obj.validate_string('labe')
#   end
# end