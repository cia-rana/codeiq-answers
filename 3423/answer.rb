r=0..n=gets.to_i-1;puts n%2>0?"invalid":r.map{|i|r.map{|j|n<1||(n/2-2*i/(n+1)*j)*(i-2*(n-i)/n*j)*(2*(n-i)/(n+1)*n-i-j)==0??y:?.}*""}
