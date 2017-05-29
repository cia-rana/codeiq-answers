require "matrix"
D = 10 ** 6

def solve(n)
  b = Matrix[[2, 3], [1, 2]]
  a = Matrix[[1, 0], [0, 1]]
  m = n - 1
  while m > 0
    a = (a*b).map{|e|e%D} if m.odd?
    b = (b*b).map{|e|e%D}
    m /= 2
  end
  (a[0,0]*4 + a[0,1]*2 - 1) % D
end

p solve(gets.to_i)