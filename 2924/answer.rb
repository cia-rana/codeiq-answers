class Enumerator::Lazy
  def filter_map
    Lazy.new(self) do |yielder, *values|
      result = yield *values
      yielder << result if result
    end
  end
end

def add_var(v1, v2)
  int1, fra1 = v1.split(?.)
  int2, fra2 = v2.split(?.)
  fra1, fra2 = [fra1, fra2].sort_by(&:size).map { |fra| fra.chars.map(&:to_i) }
  fra3 = [*Array.new(fra1.size + 1, 0), *fra2[fra1.size..-1]]
  fra1.size.downto(1) { |i| fra3[i-1], fra3[i] = (fra1[i-1] + fra2[i-1] + fra3[i]).divmod(11 - i) }
  ("%s.%s" % [int1.to_i + int2.to_i + fra3.shift, fra3.join]).to_r
end

def calc_formula formula
  var = add_var(*formula.split(?+))
  var.denominator == 1 ? var.numerator : var.to_f
end

def list_nonmatching_ids
  File.foreach('data.txt').lazy.filter_map { |line|
    id, formula, candidate = line.split("\t")
    id unless candidate.to_r == calc_formula(formula)
  }.force.join(?,)
end

puts ARGV[0] == "-d" ? list_nonmatching_ids : calc_formula(gets)