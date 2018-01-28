require 'prime'
puts (s=gets.to_r).denominator.prime_division.all?{|e,_|10%e<1}?"%g"%s.to_f: s
