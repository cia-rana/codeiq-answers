import numpy as np
import sys

# kernel size
SIZE = 5

# input, convert each character of an inputed string into a binary digit(if that is G, then 1; otherwize 0)
# and calculate a cumulative sum sequentially for each axis.
# cm: Cumulative sum Map
cm = np.array([[int(c == "G") for c in line.rstrip()] for line in sys.stdin]).cumsum(0).cumsum(1)

# calculate the number of G at each area.
# ea: Each Area
height, width = cm.shape
ea = cm[:height-SIZE, :width-SIZE] + cm[SIZE:height+SIZE, SIZE:width+SIZE] \
         - cm[:height-SIZE, SIZE:width+SIZE] - cm[SIZE:height+SIZE, :width-SIZE]

# argmax of ea.
# mp: Max Point
mp = np.unravel_index(ea.argmax(), ea.shape)

# output.
print('{"x":%d,"y":%d,"g":%d}' % (mp[1] + 1, mp[0] + 1, ea[mp]))