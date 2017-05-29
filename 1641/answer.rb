# 完全順列, 攪乱順列, derangement
p gets.to_i.times.inject([0,1]){|(a,b),i|[b,i*(a+b)]}[1]