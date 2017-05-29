n = gets.to_i
D = 10 ** n
PI = 314_159_265_358 / (10 ** (11 - n))
p (1..Float::INFINITY).each{|i|
  break i if (PI * i / D + 1) * D / i == PI
}