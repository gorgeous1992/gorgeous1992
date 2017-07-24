clc 
clear all
%% Plot wave Height
%Load Height data
topo = importdata('topo04112017.txt')
load('topo041117.mat', 'T')
size(T)
%Height row is Depth on [x, y].
%Coordinate x is 50:12:950,
%Coordinate y is -100:24:1100
Topo = reshape(T(:, 4), [76, 51]);
Topo_y1 = T([1:76], 3);
x_topo = [50:12:950]';
y_topo = [-100:24:1100]';

[X, Y] = meshgrid(x_topo, y_topo);

figure
surf(X, Y, Topo')
xlabel('Crossshore distance(m)')
ylabel('Alongshore distance(m)')
zlabel('Elevation')
title('Elevation')

figure
%Plot the depth_y1, one piece
plot(x_topo, Topo_y1)
xlabel('Crossshore distance(m)')
ylabel('Elevation')
title('Elevation (fixed y = y1)')











