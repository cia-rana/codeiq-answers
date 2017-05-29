# https://oeis.org/A213652
# https://arxiv.org/pdf/math/0505425.pdf

# r_1+r_2+...+r_m = n を満たす非負整数の組(r_1, r_2, ..., r_m)（ただし、1<=r_i<=MAX_NUM, 1<=i<=m）の組合わせの個数は
# (x+x^2+...+x^MAX_NUM)^m の x^n の係数と等しい。
# また、積式を x^m(1+x+...+x^(MAX_NUM-1))^m と整理し x^m を除けば
# (1+x+...+x^(MAX_NUM-1))^m の x^(n-m) の係数とも等しいことが分かる。
# 係数の計算は上記リンクを参照のこと。

MAX_NUM = 5

def combination(n, k)
  k = n - k if k * 2 > n
  return 1 if k == 0
  ((n - k + 1)..n).reduce(&:*)/(1..k).reduce(&:*)
end

def calc_pattern(m, n)
  (0..(k = n - m)/MAX_NUM).reduce(0) { |s, i| s + [1, -1][i % 2] * combination(m, i) * combination(m + k - 1 - MAX_NUM * i, m - 1) }
end

puts calc_pattern(*gets.split.map(&:to_i))