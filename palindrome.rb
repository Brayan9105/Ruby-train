

# Crear un método qué reciba una palabra y retorne si es palíndromo o no.
class Palindrome
  def initialize
    @cache = {}
  end

  def validate_word(str)
    downcase_str = str.downcase
    if @cache.key?(downcase_str)
      p "Palabra en la cache: #{downcase_str}"
      return @cache[downcase_str]
    end

    if downcase_str.reverse == downcase_str
      @cache[downcase_str] = true
    else
      @cache[downcase_str] = false
    end
  end
end

@my_palindrome = Palindrome.new

p @my_palindrome.validate_word('Mom')
p @my_palindrome.validate_word('Noon')
p @my_palindrome.validate_word('Pokemon')

p @my_palindrome.validate_word('Mom')
p @my_palindrome.validate_word('Noon')
p @my_palindrome.validate_word('Pokemon')
