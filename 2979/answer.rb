def combination(n, k)
  k = n - k if k * 2 > n
  return 1 if k == 0
  ((n - k + 1)..n).reduce(&:*)/(1..k).reduce(&:*)
end

def calc_pattern(m, n)
  (0..(k = n - m)/(n - 2)).reduce(0) { |s, i| s + [1, -1][i % 2] * combination(m, i) * combination(m + k - 1 - (n - 2) * i, m - 1) }
end

# rps = rock, paper, scissors
def calc_rps_pattern n
   3 + (n == 0 ? 0 : calc_pattern(3, n + 2))
end

m, n = gets.split.map(&:to_i)

p (n-2).times.inject(Array.new(m - 2, 3) + [calc_rps_pattern(m-2)]){|a, _|
  (m-1).times.map{|i|
    calc_rps_pattern(i) * a[i] + a[i+1...m-1].reduce(0, :+)*3
  }
}.reduce(:+)*3