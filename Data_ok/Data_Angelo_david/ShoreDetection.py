from numpy import *
import matplotlib.pyplot as plt
import scipy.io as sio
from scipy.interpolate import pchip


# data = sio.loadmat('Topography.mat')
topo = sio.loadmat('topograpy_y956_042816_1118')['topo_y956']
xs = linspace(50,950,76)
nSample=20
tau = -.08
topo -= tau
#Find min index
zeroIndex = argmin(abs(topo))
if(topo[zeroIndex]<=0):
  lIndex = zeroIndex -1
  rIndex = zeroIndex
else:
  lIndex = zeroIndex
  rIndex = zeroIndex + 1
#Generalize to check that farthest left index is non-negative
#in other words if lIndex - shift <0 then solve lIndex -shift +c = 0
#then rShiftedIndex = rIndex + shift + c
xInt = xs[lIndex-1:rIndex+2]
topInt = topo[lIndex-1:rIndex+2]
interp = pchip(xInt,topInt)
xsInt = linspace(xInt[0],xInt[-1],nSample)
A = ones((nSample,2))
A[:,0]= xsInt
b = interp(xsInt)
#kdahskdjfh
slope = (topo[rIndex]-topo[lIndex])/(xs[rIndex]-xs[lIndex])
print("data slope",slope)
linSolve = linalg.solve(dot(transpose(A),A),dot(transpose(A),b))
print('Slope',linSolve[0])
plt.plot(xsInt,interp(xsInt))
plt.plot(xInt,topInt)
plt.plot(xsInt,linSolve[0]*xsInt + linSolve[1])

xs2 = linspace(xs[0],xs[rIndex+5],10)
plt.figure()
#Plotting line from least squares
plt.plot(xs2,linSolve[0]*xs2 + linSolve[1])
plt.plot(xs,topo)
#plotting points that encapsulate zero bathymetry
plt.scatter(xs[lIndex],topo[lIndex],marker='*',c='b')
plt.scatter(xs[rIndex],topo[rIndex],marker='*',c='r')
plt.show()