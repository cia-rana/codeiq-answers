def to_right_child x, y
  [y - x, y]
end
def to_left_child x, y
  [x, x + y]
end
def from_right_child x, y
  [y - x, y]
end
def from_left_child x, y
  [x, y - x]
end
def decide_right x, y
  a, b = x, y
  n = loop.with_index do |_, i|
    return [?-] if a * 2 == b
    c, d = from_left_child(a, b)
    if c > d
      a, b = from_right_child(a, b)
    elsif c * 2 < d
      a, b = to_right_child(c, d)
      break i
    else
      a, b = c, d
    end
  end
  [a, a * n + b]
end
def decide_left x, y
  a, b = x, y
  n = loop.with_index do |_, i|
    return [?-] if a * 2 == b
    c, d = from_left_child(a, b)
    if c > d
      a, b = to_left_child *from_right_child(a, b)
      break i
    else
      a, b = c, d
    end
  end
  (1..n).inject([a, b]){ |(c, d), _| c * 2 > d ? to_left_child(c, d) : to_right_child(c, d) }
end

x, y = gets.scan(/\d+/).map(&:to_i)
puts decide_left(x, y)*?/ + ?, + decide_right(x, y)*?/
