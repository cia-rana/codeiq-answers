# O(log(m))版

def log2_floor(n)
  n < 2 ? 0 : ("%b"%n).size-1
end

def solve(input)
  m, n = input.split.map(&:to_i)
  
  c=1
  until 0 == n-=1
    b = 1 << (log2_floor(m)-1)
    if n <= l=[m-b, b*2-1].min
      m=l; c=2*c
    else
      n-=l; m-=l+1; c=2*c+1
    end
  end
  c
end

p solve(gets)
