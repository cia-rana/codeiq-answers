def combination(n, k)
  k = n - k if k * 2 > n
  return 1 if k == 0
  ((n - k + 1)..n).reduce(:*)/(1..k).reduce(:*)
end

def calc_pattern(m, n, max_num)
  (0..(k = n - m)/max_num).reduce(0) { |s, i| s + [1, -1][i % 2] * combination(m, i) * combination(m + k - 1 - max_num * i, m - 1) }
end

m, n = gets.split.map(&:to_i)
p ((1.0*m/n).ceil..m).inject(0){|sum, r|
  sum + calc_pattern(r, m, n)
}
