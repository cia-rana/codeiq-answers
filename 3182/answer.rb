require "prime"
f=gets.to_f
p (1..(1/f-f/3).to_i).map{|i|(i*i+1).prime_division(Prime::EratosthenesGenerator.new).map{|_,e|e+1}.reduce(:*)/2}.inject :+
