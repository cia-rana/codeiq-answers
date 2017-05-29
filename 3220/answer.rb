require "date"
y,m,w=gets.split(?,).map(&:to_i)
b=Date.new(y,m,-1)
f="%02d"
puts [b.year,f%b.month,f%(b.day-(b.wday-w)%7)]*""
