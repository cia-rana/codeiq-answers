require "matrix"

class Matrix
  # This monkey-patching is for Ruby 2.1.
  # by https://github.com/ruby/ruby/blob/ruby_2_4/lib/matrix.rb#L337
  def Matrix.hstack(x, *matrices)
    raise TypeError, "Expected a Matrix, got a #{x.class}" unless x.is_a?(Matrix)
    result = x.send(:rows).map(&:dup)
    total_column_count = x.column_count
    matrices.each do |m|
      raise TypeError, "Expected a Matrix, got a #{m.class}" unless m.is_a?(Matrix)
      if m.row_count != x.row_count
        raise "The given matrices must have #{x.row_count} rows, but one has #{m.row_count}"
      end
      result.each_with_index do |row, i|
        row.concat m.send(:rows)[i]
      end
      total_column_count += m.column_count
    end
    new result, total_column_count
  end
  
  # This monkey-patching is for Ruby 2.1.
  # by https://github.com/ruby/ruby/blob/ruby_2_4/lib/matrix.rb#L316
  def Matrix.vstack(x, *matrices)
    raise TypeError, "Expected a Matrix, got a #{x.class}" unless x.is_a?(Matrix)
    result = x.send(:rows).map(&:dup)
    matrices.each do |m|
      raise TypeError, "Expected a Matrix, got a #{m.class}" unless m.is_a?(Matrix)
      if m.column_count != x.column_count
        raise "The given matrices must have #{x.column_count} columns, but one has #{m.column_count}"
      end
      result.concat(m.send(:rows))
    end
    new result, x.column_count
  end
  
  def flipud
    Matrix[*self.to_a.reverse]
  end
  
  def fliplr
    Matrix[*self.to_a.map(&:reverse)]
  end
end

def convertSeqToMV(seq)
  seq.select{|e|e<1}.map{|e|e<0??m:?v}*""
end

def convertMatToMV(m)
  if m.column_size == 1
    mv = convertSeqToMV(m.column(0).to_a)
    mv + mv.reverse
  elsif m.row_size == 1
    mv = convertSeqToMV(m.row(0).to_a)
    mv + mv.reverse
  else
    convertSeqToMV(
        m.row(0).to_a \
      + m.column(-1).to_a \
      + m.row(-1).to_a.reverse \
      + m.column(0).to_a.reverse
    )
  end
end

# -1: 折り目の山部分, 0: 折り目の谷部分, 1: 折り目のない面
# f(x) = ~xとすると、f(-1) = 0, f(0) = -1, f(f(x)) = x より
m = gets.reverse.chars.inject(nil){|mat, c|
  if mat.nil?
    case c
    when ?L, ?R
      Matrix[[1, 0, 1]]
    when ?T, ?B
      Matrix[[1, 0, 1]].t
    end
  else
    case c
    when ?L
      Matrix.hstack(
        mat.fliplr.map{|e|e>0?e:~e},
        Matrix.build(mat.row_size, 1){0},
        mat
      )
    when ?R
      Matrix.hstack(
        mat,
        Matrix.build(mat.row_size, 1){0},
        mat.fliplr.map{|e|e>0?e:~e}
      )
    when ?T
      Matrix.vstack(
        mat.flipud.map{|e|e>0?e:~e},
        Matrix.build(1, mat.column_size){0},
        mat
      )
    when ?B
      Matrix.vstack(
        mat,
        Matrix.build(1, mat.column_size){0},
        mat.flipud.map{|e|e>0?e:~e}
      )
    end
  end
}

puts convertMatToMV(m)
