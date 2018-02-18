n,k=gets.split.map &:to_i
p (0...k).map{|i|t=((n-i+1.0)/k).ceil;t*(2*i+t*k-k)/i.gcd(k)/2}.inject :+
