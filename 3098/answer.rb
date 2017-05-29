# ベクトルを作る
vecs = gets.split.map{|e|e.split ?,}.map{|d, x, y, n|
  x, y, n = [x, y, n].map(&:to_i)
  d == ?V ? [x, y, x, y + n - 1] : [x, y, x + n - 1, y]
}

# 平行でかつ重なるベクトルを統合する
vecs = vecs.select.with_index{|vec, i|
  vec if vecs[i+1..-1].each_with_index{|ov, j|
    next unless (ov[1]-ov[3])*(vec[0]-vec[2]) == (vec[1]-vec[3])*(ov[0]-ov[2])
    next unless ([ov[0], ov[2], vec[0], vec[2]].uniq.size == 1) \
      && ((vec[0]..vec[2]).include?(ov[0]) || (vec[0]..vec[2]).include?(ov[2]) || (ov[0]..ov[2]).include?(vec[0]) || (ov[0]..ov[2]).include?(vec[2])) \
    || ([ov[1], ov[3], vec[1], vec[3]].uniq.size == 1) \
      && ((vec[1]..vec[3]).include?(ov[1]) || (vec[1]..vec[3]).include?(ov[3]) || (ov[1]..ov[3]).include?(vec[1]) || (ov[1]..ov[3]).include?(vec[3]))
    
    vecs[i+j+1] = [[ov[0],vec[0]].min, [ov[1],vec[1]].min, [ov[2],vec[2]].max, [ov[3],vec[3]].max]
    break
  }
}

# ベクトルの長さを足し合わせる
# 重なる場合は合計から1引く
p vecs.map.with_index{|vec, i|
  vecs[i+1..-1].inject(vec[2] - vec[0] + vec[3] - vec[1] + 1){|n, ov|
    t0 = (ov[0] - ov[2])*(vec[1] - ov[1]) + (ov[1] - ov[3])*(ov[0] - vec[0])
    t1 = (ov[0] - ov[2])*(vec[3] - ov[1]) + (ov[1] - ov[3])*(ov[0] - vec[2])
    t2 = (vec[0] - vec[2])*(ov[1] - vec[1]) + (vec[1] - vec[3])*(vec[0] - ov[0])
    t3 = (vec[0] - vec[2])*(ov[3] - vec[1]) + (vec[1] - vec[3])*(vec[0] - ov[2])
    t0 * t1 <= 0 && t2 * t3 <= 0 ? n - 1 : n
  }
}.inject(:+)
