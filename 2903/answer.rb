require 'prime'

D = 1_000_003

def calc_pow_with_mod(n, m, div)
  prd = 1
  pow = n
  while m > 0
    prd = (prd * pow) % div if m.odd?
    pow = (pow * pow) % div
    m /= 2
  end
  prd
end

n = gets.to_i

p Prime.each(n).reduce(Hash.new(0)){|divNum, prime|
  m = n
  while m > 0
    divNum[prime] += m /= prime
  end
  divNum
}.reduce(1){|prd, (d, e)|
  prd * (calc_pow_with_mod(d, n * e + 1, D * (d - 1)) - 1) / (d - 1) % D
}