digit, numbers = gets.split
digit = digit.to_i
numbers = numbers.chars
numbers_size_half = numbers.size / 2

if numbers.include?(?0)
  if numbers.size.odd?
    puts (numbers[numbers_size_half] * digit).to_i
  else
    first = numbers[numbers_size_half-1] + numbers[-1] * (digit - 1)
    second = numbers[numbers_size_half] + ?0 * (digit - 1)
    puts [first, second].map(&:to_i)*?,
  end
else
  if numbers.size.odd?
    if numbers.size == 1
      if digit.odd?
        puts (numbers[0] * (digit/2+1)).to_i
      else
        first = numbers[0] * (digit/2)
        second = numbers[0] + first
        puts [first, second].map(&:to_i)*?,
      end
    else
      seq = numbers[numbers_size_half-1] + numbers[-1]
      if digit.odd?
        puts seq * ((digit-1)/2) + numbers[numbers_size_half]
      else
        tmp_seq = seq * ((digit-2)/2)
        puts [tmp_seq + seq, tmp_seq + numbers[numbers_size_half] + numbers[0]].map(&:to_i)*?,
      end
    end
  else
    first = numbers[numbers_size_half-1] * digit
    second = numbers[numbers_size_half-1] * (digit - 1) + numbers[numbers_size_half]
    puts [first, second].map(&:to_i)*?,
  end
end