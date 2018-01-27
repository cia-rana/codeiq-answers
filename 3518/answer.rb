require 'prime'
puts (s=gets.to_r).denominator.prime_division.all?{|e,_|e==2||e==5}?"%g"%s.to_f: s
