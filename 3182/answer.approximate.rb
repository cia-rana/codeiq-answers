# 1/tan(x) = cot(x) ~ 1/x-x/3
# とすると
# [0.464, 0.786, 0.787, 0.788, 0.789, 0.790, 0.791]
# がうまくいかない

require "prime"
f=gets.to_f
p (1..(1/f-f/3).to_i).inject(0){|s,i|s+=(i*i+1).prime_division.inject(1){|d,e|d*=e[1]+1}/2}
