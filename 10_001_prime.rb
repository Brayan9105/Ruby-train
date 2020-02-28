# frozen_string_literal: true

#https://projecteuler.net/problem=7
# By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.
# What is the 10 001st prime number?

# https://www.smartickmethod.com/blog/math/operations-and-algebraic-thinking/divisibility/prime-numbers-sieve-eratosthenes/
# 2 is the only even, (number number % 2).zero? is not prime
# 3 is the only number divisible by 3
# 5 is only number divisible by 5
# 7 is only number divisible by 7
# stop if the square root of the factor is greater that the number
class Prime
  def initialize
    @@prime_array = []
    @@last_prime_found = 1 #start 1 number less than the first prime that is 2
    @@divisors_array = [2, 3, 5, 7]
  end

  def found_n_prime(number_to_find)
    return @@prime_array[number_to_find - 1] if @@prime_array[number_to_find - 1]

    loop do
      @@last_prime_found += 1 #start to search from the last prime found
      @@prime_array << @@last_prime_found if prime?(@@last_prime_found)

      break if @@prime_array.size == number_to_find
    end

    @@prime_array.last
  end

  def prime?(number)
    @@divisors_array.each do |divisor|
      return false if (number % divisor).zero? && number != divisor
    end

    # first attend to validate if the number was a prime:

    # return false if (number % 2).zero? && number != 2
    # return false if (number % 3).zero? && number != 3
    # return false if (number % 5).zero? && number != 5
    # return false if (number % 7).zero? && number != 7

    true
  end
end

prime1 = Prime.new
p prime1.found_n_prime(1)
p prime1.found_n_prime(2)
p prime1.found_n_prime(3)
p prime1.found_n_prime(4)
p prime1.found_n_prime(5)
p prime1.found_n_prime(6)
p prime1.found_n_prime(6)
p prime1.found_n_prime(10_001)

# first solution to the problem
=begin

def prime10001(number_of_prime)
  prime_array = [] 
  return prime_array[number_of_prime - 1] if prime_array[number_of_prime - 1]

  number = 1
  loop do
    break if prime_array.size == number_of_prime
    
    number += 1
    next if (number % 2).zero? && number != 2
    next if (number % 3).zero? && number != 3
    next if (number % 5).zero? && number != 5
    next if (number % 7).zero? && number != 7
    prime_array << number
  end

  prime_array.last
end

puts prime10001(1)
puts prime10001(2)
puts prime10001(3)
puts prime10001(4)
puts prime10001(5)
puts prime10001(6)
puts prime10001(10_001)

=end