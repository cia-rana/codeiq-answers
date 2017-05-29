h=$<.map{|e|e.split(?,).rotate}.to_h
s=Hash.new 0
h.map{|_,v|s[v]+=100}
puts s.sort.map{|k,v|"#{k}:#{v/h.size}%"}
