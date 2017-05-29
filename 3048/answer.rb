tetorominos = [
  [[[0, 0], [0, 1], [0, 2], [0, 3]], ?I], [[[0, 0], [1, 0], [2, 0], [3, 0]], ?I],
  
  [[[0, 0], [0, 1], [0, 2], [1, 2]], ?L], [[[0, 0], [0, 1], [0, 2], [-1, 2]], ?L],
  [[[0, 0], [1, 0], [2, 0], [2, 1]], ?L], [[[0, 0], [1, 0], [2, 0], [2, -1]], ?L],
  [[[0, 0], [1, 0], [1, 1], [1, 2]], ?L], [[[0, 0], [-1, 0], [-1, 1], [-1, 2]], ?L],
  [[[0, 0], [0, -1], [1, -1], [2, -1]], ?L], [[[0, 0], [0, 1], [1, 1], [2, 1]], ?L],
  
  [[[0, 0], [0, 1], [1, 0], [1, 1]], ?O],
  
  [[[0, 0], [0, 1], [-1, 1], [-1, 2]], ?S], [[[0, 0], [0, 1], [1, 1], [1, 2]], ?S],
  [[[0, 0], [1, 0], [1, 1], [2, 1]], ?S], [[[0, 0], [1, 0], [1, -1], [2, -1]], ?S],
  
  [[[0, 0], [0, 1], [-1, 1], [0, 2]], ?T], [[[0, 0], [0, 1], [1, 1], [0, 2]], ?T],
  [[[0, 0], [1, 0], [1, 1], [2, 0]], ?T], [[[0, 0], [1, 0], [1, -1], [2, 0]], ?T],
]

inputs = gets.scan(/\d+/).map(&:to_i)
result = []
inputs.map{|input|
  p_x = input / 10
  p_y = input % 10
  tetorominos.each_with_index{|(t1, shape1), i|
    inputs_clone = inputs.clone
    next unless t1.all?{|t1_x, t1_y|x,y=p_x+t1_x,p_y+t1_y; (0<=x&&x<=9&&0<=y&&y<=9)&&inputs_clone.delete(x*10+y)}
    inputs_clone.each{|input_clone|
      pc_x = input_clone / 10
      pc_y = input_clone % 10
      tetorominos[i..-1].each{|t2, shape2|
        if t2.all?{|t2_x, t2_y|x,y=pc_x+t2_x,pc_y+t2_y; (0<=x&&x<=9&&0<=y&&y<=9)&&inputs_clone.index(x*10+y)}
          result << (shape1 + shape2)
          break
        end
      }
    }
  }
}
puts result.empty? ? ?- : result.uniq.sort * ?,