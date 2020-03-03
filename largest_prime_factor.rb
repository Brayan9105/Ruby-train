# The prime factors of 13195 are 5, 7, 13 and 29.
# What is the largest prime factor of the number 600851475143 ?
require 'prime'

def largest(number)
  Prime.each(number).select { |n| number % n == 0 }.last
end

p largest(13195)
# p largest(600851475143) Cant achive this value