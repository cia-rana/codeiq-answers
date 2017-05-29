map = gets.scan(/\h\h/).map{|e|("%08b"%e.to_i(16)).scan(/\d/)}
a = 4.times.map{|i|
  map = map.map(&:reverse).transpose
  s = 0
  8.times{|y|
    7.times{|x|
      s += 1 if map[y][x]==?1 && map[y][x+1]==?0
    }
  }
  s
}
puts [a[2], a[0], a[1], a[3]]*?,