require "prime"

def solve(input)
  n, l, u = input.split.map(&:to_i)
  primes = Prime.each(u).select{|q|l<=q}
  
  (f = ->r, i{
    return 1 if r == 0
    return 0 if r < 0 || i < 0
    f[r - primes[i], i - 1] + f[r, i - 1]
  })[n, primes.size - 1]
end

p solve(gets)