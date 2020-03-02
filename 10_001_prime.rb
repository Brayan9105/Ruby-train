# By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.
# What is the 10 001st prime number?

# 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 
# 103, 107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199, 
# 211, 223, 227, 229, 233, 239, 241, 251, 257, 263, 269, 271, 277, 281, 283, 293, 307, 311, 313, 317, 
# 331, 337, 347, 349, 353, 359, 367, 373, 379, 383, 389, 397, 401, 409, 419, 421, 431, 433, 439, 443, 
# 449, 457, 461, 463, 467, 479, 487, 491, 499, 503, 509, 521, 523, 541, 547, 557, 563, 569, 571, 577, 
# 587, 593, 599, 601, 607, 613, 617, 619, 631, 641, 643, 647, 653, 659, 661, 673, 677, 683, 691, 701, 
# 709, 719, 727, 733, 739, 743, 751, 757, 761, 769, 773, 787, 797, 809, 811, 821, 823, 827, 829, 839, 
# 853, 857, 859, 863, 877, 881, 883, 887, 907, 911, 919, 929, 937, 941, 947, 953, 967, 971, 977, 983, 991, 997

# 6 => 13
# 10001 => 104743
class Prime
  def initialize
    @cache = [2]
  end

  def find_n_prime(index)
    return "cache : #{@cache[index - 1]}" if @cache[index - 1]

    posible_prime = @cache.last + 1
    while @cache.size < index
      @cache << posible_prime if prime?(posible_prime)

      posible_prime += 1
    end
 
    @cache[index - 1]
  end

  def prime?(number)
    (2..(Math.sqrt(number) + 1)).each do |divisor|
      return false if (number % divisor).zero?
    end

    true
  end
end
prime = Prime.new

# p prime.find_n_prime(10001)

p prime.find_n_prime(1)
p prime.find_n_prime(2)
p prime.find_n_prime(3)
p prime.find_n_prime(4)
p prime.find_n_prime(5)
p prime.find_n_prime(6)
p prime.find_n_prime(10001)
