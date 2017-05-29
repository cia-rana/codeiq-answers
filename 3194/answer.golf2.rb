n=gets.to_i
gets
p [*0...n].combination(2).map{|i,j|(%w(1 2 3)-$_.split[i..j]).size<1? j-i+1:n}.min
