require 'prime'
s=gets.to_r
puts (if s.denominator == 1
  s.to_i
elsif s.denominator.prime_division.all?{|e,_|e==2||e==5}
  s.to_f
else
  s
end)
