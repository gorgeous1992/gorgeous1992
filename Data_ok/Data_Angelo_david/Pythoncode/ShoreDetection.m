function Slope = ShoreDetection(topo, tau)
%topo = importdata('topograpy_y956_042816_1118.mat');

xs = linspace(50, 950, 76);
nSample = 20;
%tau = -.08;
topo = topo - tau;
%Find min index 
[~, zeroIndex] = min(abs(topo));
if topo(zeroIndex) <= 0
  lIndex = zeroIndex -1;
  rIndex = zeroIndex;
else
      lIndex = zeroIndex;
      rIndex = zeroIndex + 1;
end

%Generalize to check that farthest left index is non-negative
%in other words if lIndex - shift <1 then solve lIndex -shift +c = 1
%then rShiftedIndex = rIndex + shift + c
xInt = xs(lIndex-1 : rIndex+1)
topInt = topo(lIndex-1 : rIndex+1);
%interp is a polynomial structure
interp = pchip(xInt,topInt);
xsInt = linspace(xInt(1), xInt(end),nSample);
A = ones(nSample,2);
A(:,1)= xsInt;
b = ppval(interp, xsInt);
%make b as an column vector
b = b';

%Do the slope

slope = (topo(rIndex)-topo(lIndex))/(xs(rIndex)-xs(lIndex));
fprintf("data slope = %f\n",slope);
linSolve = (A'*A)\(A'*b);
Slope = linSolve(1);

figure
subplot(1,2,1)
plot(xsInt,b, 'r')
hold on
plot(xInt,topInt, 'b')
hold on
plot(xsInt,linSolve(1)*xsInt + linSolve(2),'g')
hold off
legend('Interpolation function', 'data', 'Least square fit')
xlabel('x')
ylabel('y')
title('Interpolation & Least square')

xs2 = linspace(xs(1),xs(rIndex+5),10);

subplot(1,2,2)
%Plotting line from least squares
plot(xs2,linSolve(1)*xs2 + linSolve(2))
hold on
plot(xs,topo)
hold on
%plotting points that encapsulate zero bathymetry
scatter(xs(lIndex),topo(lIndex),'*b')
hold on
scatter(xs(rIndex),topo(rIndex),'*r')
hold off
xlabel('x')
ylabel('y')
title('Shore slope detection')




















