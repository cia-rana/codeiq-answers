require "prime"

D = 1000003

p Prime.each(n = gets.to_i).inject(1) {|prd, q|
  sum, m = 0, n
  while m > 0
    sum += m /= q
  end
  
  sum -= 1
  a, b = 1, q
  while sum > 0
    a = a * b % D if sum.odd?
    b = b * b % D
    sum /= 2
  end
  
  # φ(p^s * q^t) = p^{s - 1} * (p - 1) * q^{t - 1} * (q - 1) (Let p, q be prime numbers with gcd(p, q) = 1)
  (prd * a * (q - 1)) % D
}
