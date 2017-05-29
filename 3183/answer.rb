i=0;s=?Y+?x*80;gets.chop.bytes{|c|s[i+=[-1,0,1,9,-9][c%5]]=?Y};puts s.scan /.{9}/
