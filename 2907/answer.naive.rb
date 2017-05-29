digit, numbers = gets.split
digit = digit.to_i
numbers = numbers.chars
nm = [numbers]

(digit-1).times { |d|
  nm[d+1] = nm[d].map { |m|
    numbers.map { |n|
      m + n
    }
  }.flatten
}

nm = nm.flatten.map(&:to_i).sort.uniq
p nm.size
puts nm.size.odd? ? nm[nm.size/2] : nm[nm.size/2-1,2]*?,