require "prime"

def solve(array)
  return 1 if array.empty?
  
  sum = 0
  
  rec = ->(i, prd1 = 1, prd2 = 1){
    if i == array.size
      sum += prd1 * prd2
    else
      e = array[i][1]
      0.upto(e) { |t| rec[i + 1, prd1 * (e - t + 1), prd2 * (t + 1)] }
    end
  }
  
  if array[0][0] == 2
    rec[1]
    sum *= array[0][1] + 1
  else
    rec[0]
  end
  
  sum
end

p solve(Prime.prime_division(gets.to_i))