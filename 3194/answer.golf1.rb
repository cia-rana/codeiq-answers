gets
gets
l=m=1.0/i=0
while l
m=[l,m].min
i,l=[*1..3].permutation.map{|q|
(j=" #{$_.chop} ".index(/ #{q*"( | .*? )"} /,i))?[j+1,$&.split.size]:[1e9]}.min
end
p m
