line = gets.split(' ').map{|e|e.split('/')}

circle_inner = -> cx, cy, cr, sx, sy {
  cr*cr <=> (cx-sx)*(cx-sx) + (cy-sy)*(cy-sy)
}.curry

rectangle_inner = -> cx, cy, cr, s1x, s1y, s2x, s2y {
  defsx, defsy = s1x - s2x, s1y - s2y
  a, b, c = if defsx == 0
      [1, 0, -s1x]
    elsif defsy == 0
      [0, 1, -s1y]
    else
      [defsy, -defsx, defsx * s2y - defsy * s2x]
    end
  distance = (a*a + b*b) * cr * cr <=> (a * cx + b * cy + c) * (a * cx + b * cy + c)
  if distance == -1
    -1
  else
    inner_produt1 = -defsx*(cx-s1x) - defsy*(cy-s1y)
    inner_produt2 = defsx*(cx-s2x) + defsy*(cy-s2y)
    if inner_produt1 == 0 || inner_produt2 == 0
      0
    elsif inner_produt1 < 0 || inner_produt2 < 0
      -1
    else
      distance
    end
  end
}

# 円に線分が衝突してるかどうか ⇔ 線分を円で囲ったカプセルに円の中心が入っているかどうか
capsule_inner = -> cx, cy, cr, s1x, s1y, s2x, s2y {
  a = circle_inner[s1x, s1y, cr, cx, cy]
  b = circle_inner[s2x, s2y, cr, cx, cy]
  c = rectangle_inner[cx, cy, cr, s1x, s1y, s2x, s2y]
  if (a == 0 || b == 0) && c != 1 || a != 1 && b != 1 && c == 0
    0
  elsif a + b + c == -3
    -1
  else
    1
  end
}

line.each { |e|
  c = Array.new(3), s = Array.new(4)
  e[0].match(/\((\d+),(\d+)\)(\d+)/) { |md|
    _, *c = md.to_a.map(&:to_i)
  }
  e[1].match(/\((\d+),(\d+)\)\((\d+),(\d+)\)/) { |md|
    _, *s = md.to_a.map(&:to_i)
  }
  circle_inner_curried = circle_inner[*c]
  circle_inner1 = circle_inner_curried[s[0], s[1]]
  circle_inner2 = circle_inner_curried[s[2], s[3]]
  
  if circle_inner1 > 0 && circle_inner2 > 0
    print 'A'
  elsif circle_inner1*circle_inner2 == 0
    if circle_inner1 + circle_inner2 == 1
      print 'B'
    elsif circle_inner1 + circle_inner2 == 0
      print 'C'
    else
      if capsule_inner[*c, *s] == 1
        print 'D'
      else
        print 'G'
      end
    end
  elsif circle_inner1 + circle_inner2 == -2
    print 'IHE'[capsule_inner[*c, *s]+1]
  else
    print 'F'
  end
}