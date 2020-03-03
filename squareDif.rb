# The sum of the squares of the first ten natural numbers is,
# 12+22+...+102=385
# The square of the sum of the first ten natural numbers is,
# (1+2+...+10)2=552=3025
# Hence the difference between the sum of the squares of the first ten natural numbers and the square of the sum is 3025−385=2640.
# Find the difference between the sum of the squares of the first one hundred natural numbers and the square of the sum.
class Square
  def initialize
    @cache = [0]
    @square = [0]
    @natural = [0]
  end

  def calculate_sum(limit)
    return "En cache: #{@cache[limit]}" if @cache[limit]

    start = @cache.size == 0 ? 1 : @cache.size
    (start..limit).each do |index|
      @square[index] = @square[index - 1] + index**2
      @natural[index] = @natural[index - 1] + index
      @cache[index] = @natural[index]**2 - @square[index]
      break if @index == limit
    end

    @cache[limit]
  end
end

@my_square_dif = Square.new
p @my_square_dif.calculate_sum(9)
p @my_square_dif.calculate_sum(10)
p @my_square_dif.calculate_sum(9)
p @my_square_dif.calculate_sum(10)
p @my_square_dif.calculate_sum(12)

