def calculate_fare(regular_fares, passengers)
  adult_num = passengers.count('A')
  child_num = passengers.count('C')
  infant_num = passengers.count('I')
  
  regular_fares.inject(0) do |sum, regular_fare|
    regular_fare_for_child = ((regular_fare/10+1)/2)*10
    sum + adult_num * regular_fare + (child_num + [0, infant_num-adult_num*2].max) * regular_fare_for_child
  end
end

def parse(arg)
  regular_fares, passengers = arg.strip.split(':')
  regular_fares = regular_fares.split(',').map(&:to_i)
  passengers = passengers.split(',')
  [regular_fares, passengers]
end

regular_fares, passengers = parse(gets)
puts calculate_fare(regular_fares, passengers)