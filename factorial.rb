
#require 'minitest/autorun'

# Cómo ingeniero debo crear un método qué reciba un número cualquiera y devuelva el Factorial de ese número.
# http://es.onlinemschool.com/math/formula/factorial_table/
# 1! = 1, 2! = 2, 3! = 6, 4! = 24, 5! = 120, 6! = 720
class Factorial
  def initialize
    @cache = []
  end

  def calculate_factorial(number)
    return @cache[number] if @cache[number]

    if number <= 1
      @cache[number] = number
      return number
    end

    @cache[number] = number * calculate_factorial(number - 1)
  end
end

my_factorial = Factorial.new
p my_factorial.calculate_factorial(5)
p my_factorial.calculate_factorial(1)
p my_factorial.calculate_factorial(2)
p my_factorial.calculate_factorial(3)
p my_factorial.calculate_factorial(4)
p my_factorial.calculate_factorial(5)
p my_factorial.calculate_factorial(6)

  