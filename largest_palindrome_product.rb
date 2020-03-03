# A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.
# Find the largest palindrome made from the product of two 3-digit numbers.

# Some documentation
class LargestPalindrome
  def palindrome?(number)
    number == number.to_s.reverse.to_i
  end

  def find_largest
      palindrome = []
      array = 111.upto(999)
      array.each do |x|
          array.each do |y|
              multiply = x * y
              palindrome << multiply if palindrome?(multiply)
          end 
      end
      palindrome.max
  end
end

largest = LargestPalindrome.new
p largest.find_largest
