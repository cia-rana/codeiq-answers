goalNums = 1..3

n = gets.to_i
seq = gets.split.map(&:to_i)

goalNumIndices = {}
goalIntervalNums = []
goalIntervalIndicesMin = []
seq.each_with_index{|num, i|
  if goalNums.include?(num)
    goalNumIndices[num] = (goalNumIndices[num] || []) << i
    unless goalIntervalNums.include?(num)
      goalIntervalNums << num 
      goalIntervalIndicesMin << i
    end
  end
}

intervalDistance = ->(min, max){max - min + 1}
goalNumItervalMin = intervalDistance[*goalIntervalIndicesMin.minmax]
loop do
  intervalIndexMin = goalIntervalIndicesMin.shift
  intervalNum = goalIntervalNums.shift
  
  goalNumIndices[intervalNum].shift
  index = goalNumIndices[intervalNum][0]
  break if index.nil?
  
  goalIntervalNums.insert(goalIntervalIndicesMin.push(index).sort!.index(index), intervalNum)
  goalNumItervalMin = [goalNumItervalMin, intervalDistance[*goalIntervalIndicesMin.minmax]].min
end

p goalNumItervalMin
