# If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. 
# The sum of these multiples is 23.
# Find the sum of all the multiples of 3 or 5 below 1000.

# 1, 2, 3, 4, 5, 6,  7,  8,  9,  10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22
# 0, 0, 3, 3, 8, 14, 14, 14, 23, 33, 33, 45

class Multiple
  def initialize
    @cache = []
  end

  def calcule_multiple(number)
    if number >= 3 && number <= @cache.size - 1
      p "Numero en el cache"
      return @cache[number - 1] if @cache[number - 1]

      find_in_cache(number)
    elsif number >= 3
      p "calculando"
      calculate_sum(number)
    else
      0
    end
  end

  def find_in_cache(number)
    current_posicion = (number - 1)
        loop do
            return @cache[current_posicion] if @cache[current_posicion]

            current_posicion -= 1
        end
  end

  def calculate_sum(number)
    sum = @cache.last || 0
    (@cache.size..number -1).each do |i|
      next unless (i % 3).zero? || (i % 5).zero?

      sum += i
      @cache[i] = sum
    end

    sum
  end
end

@my_multiples = Multiple.new

p @my_multiples.calcule_multiple(100)

p @my_multiples.calcule_multiple(4)
p @my_multiples.calcule_multiple(5)
p @my_multiples.calcule_multiple(6)
p @my_multiples.calcule_multiple(7)
p @my_multiples.calcule_multiple(10)


# p @my_multiples.calcule_multiple(3)
# p @my_multiples.calcule_multiple(4)
# p @my_multiples.calcule_multiple(5)
# p @my_multiples.calcule_multiple(6)
# p @my_multiples.calcule_multiple(7)