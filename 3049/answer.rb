def change_direct(direct, cordinate, map)
  next_direct = {
    [-1, 0] => [0, -1],
    [0, -1] => [1, 0],
    [1, 0]  => [0, 1],
    [0, 1]  => [-1, 0], 
  }
  ndy, ndx = next_direct[direct]
  return map[cordinate[0] + ndy][cordinate[1] + ndx].nil? ? [ndy, ndx] : direct
end

N = 1000
L = Math.sqrt(N).ceil/2*2+5
n = gets.to_i
map = Array.new(L){Array.new(L)}
ans = Set.new
cordinate = [L/2, L/2]
map[cordinate[0]][cordinate[1]] = 1
direct = [-1, 0]

until ans.size == 4
  next_val = map[cordinate[0]][cordinate[1]] + 1
  cordinate = [cordinate[0] + direct[0], cordinate[1] + direct[1]]
  map[cordinate[0]][cordinate[1]] = next_val
  [[-1, 0], [0, -1], [1, 0], [0, 1]].each{|dy, dx|
    v = map[cordinate[0] + dy][cordinate[1] + dx]
    next if v.nil?
    ans.add(v) if next_val == n
    ans.add(next_val) if v == n
  }
  direct = change_direct(direct, cordinate, map)
end

puts ans.to_a.sort*?,