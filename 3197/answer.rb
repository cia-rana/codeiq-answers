# O(n)版

def solve(input)
  m, n = input.split.map(&:to_i)
  
  (f=->i=1{
    return if i > m
    return i if (n-=1).zero?
    f[2*i] || f[2*i+1]
  })[]
end

p solve(gets)
