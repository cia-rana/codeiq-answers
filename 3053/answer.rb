# by http://matwbn.icm.edu.pl/ksiazki/mon/mon42/mon4204.pdf
p 2*(1..R=Math.sqrt(N=gets.to_i+1).to_i).inject(0){|s,i|s+N/i}-R*R-2*N+1

# golfed
# p (1..N=gets.to_i+1).inject{|s,i|s+N/i}-N
# p (1..N=gets.to_i).inject(0){|s,i|s+(N+1)/i}-2*N
# p (1..N=gets.to_i+1).inject(0){|s,i|s+N/i}-2*N+1
# p 2*(1..R=Math.sqrt(N=gets.to_i+1).to_i).inject{|s,i|s+N/i}-R*R-1