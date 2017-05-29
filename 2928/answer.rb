# Question:
#   Codeiq No.2928
# Reference:
#   https://oeis.org/A000254
#   https://oeis.org/A094310
i=s=0;n=gets.to_i;until s>n;i+=1;s+=1.0/i;end;p i