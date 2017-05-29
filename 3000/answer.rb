def solve
  projection_view = $<.map{|e|eval e}

  (1..2).each{|i|
    2.times{|j|
      3.times{|k|
        return 0 if projection_view[i][j][k] == 1 && projection_view[i][j + 1][k] == 0
      }
    }
  }

  blocks = Array.new(3){Array.new(3){Array.new(3, 1)}}
  
  3.times{|i|
    projection_view[1][i].reverse!
    3.times{|j|
      3.times{|k|
    	 blocks[k][i][j] &= projection_view[0][i][j]
    	 blocks[i][j][k] &= projection_view[1][i][j]
    	 blocks[i][k][j] &= projection_view[2][i][j]
      }
    }
  }
  
  block_candidates = []
  apply_block_x = 0
  apply_block_y = 0
  2.times{|i|
    3.times{|j|
    	3.times{|k|
    	  if blocks[i][j][k] == 1
    	  	block_candidates << [i, j, k]
    	  	apply_block_x |= 1 << (i*3 + j)
    	  	apply_block_y |= 1 << (i*3 + k)
    	  end
    	}
    }
  }
  
  g = ->{
    sum = 0
    masks = [6.times.map{|i| ((1 << 6)-1) ^ (1 << i) }, 9.times.map{|i| ((1 << 9)-1) ^ (1 << i) }]
    
    f = ->(apply_block_x, apply_block_y, n, check_list){
      if n < 0
        sum += 1 if apply_block_x == 0 && apply_block_y == 0
    	  return
      end
      
      f[apply_block_x, apply_block_y, n - 1, check_list]
      c = block_candidates[n]
      if c[0] == 1
        check_list |= (1 << (c[1] * 3 + c[2]))
      elsif c[0] == 0 && (check_list & (1 << (c[1] * 3 + c[2]))) == 0
        return
      end
      f[apply_block_x & (masks[0][c[0]*3 + c[1]]), apply_block_y & (masks[0][c[0]*3 + c[2]]), n - 1, check_list]
    }
    
    f[apply_block_x, apply_block_y, block_candidates.size - 1, 0]
    sum
  }
  
  g[]
end

p solve()