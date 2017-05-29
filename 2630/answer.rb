r,c=gets.chars.map.with_index{|n,i|n.ord-96+i*32}
a=Array.new(r+1){Array.new(c,0)}
r.times{|i|a[i][0],a[i][1]=1,i+1;2.upto(c-1){|j|a[i][j]=a[i-1][j]+a[i][j-2]+a[i][j-1]}}
p a[r-1][c-1]