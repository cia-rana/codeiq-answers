def answer(a, b, c, x, y)
  s = a <=> 0
  a, b, c = [a, b, c].map{|e|s*e}
  x2 = 1 + x1 = x
  y2 = s + y1 = y * s
  y1, y2 = y2, y1 if s < 0
  is_common, is_contact = [-1, 0].map{|e|2*a*x1 < -b && -b < 2*a*x2 && (a*c-b*b <=> a*y2) == e}
  f1, f2 = [x1, x2].map{|e|(a*e+b)*e+c}
  
  if f1 < y1 && f2 < y1
    " UL"[s]
  elsif f1 <= y1 && f2 <= y1
    " ul"[s]
  elsif (f1 > y2 && f2 == y2 || f1 == y2 && f2 > y2) && !is_common || is_contact
    " lu"[s]
  elsif f1 > y2 && f2 > y2 && !is_common
    " LU"[s]
  else
    ?S
  end
end

puts answer(*gets.split.map(&:to_i))
