AREA_SIZE = 5

class Array
  def cumsum
    sum = 0
    self.map{|e| sum += e }
  end
end

area_map = $<.map{|line|
  line.chomp.chars.map{|c|c==?w?0:1}
}
height = area_map.size
width = area_map[0].size

cumulative_sum = area_map.transpose.map(&:cumsum).transpose.map(&:cumsum)

max_g = 0
max_point = [0, 0] # (x, y)
(height-AREA_SIZE).times{|i|
  (width-AREA_SIZE).times{|j|
    area_g = cumulative_sum[i+AREA_SIZE][j+AREA_SIZE] - cumulative_sum[i+AREA_SIZE][j] - cumulative_sum[i][j+AREA_SIZE] + cumulative_sum[i][j]
    if max_g < area_g
      max_g = area_g
      max_point = [j, i]
    end
  }
}
puts '{"x":%d,"y":%d,"g":%d}' % (max_point.map(&:succ) + [max_g])