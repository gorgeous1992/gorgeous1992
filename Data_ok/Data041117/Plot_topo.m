clc 
clear all
%% Plot topo 2-D graph
%Load topo data
topo = importdata('topo04112017.txt')
%topo values
T = topo(:, 3);
x_topo = [50:12:950]';
y_topo = [-100:24:1100]';

figure
subplot(1,2,1)
[X, Y] = meshgrid(x_topo, y_topo);
surf(X, Y, Topo')
xlabel('Crossshore distance(m)')
ylabel('Alongshore distance(m)')
zlabel('Elevation')
title('Elevation')
%Height row is Depth on [x, y].
%Coordinate x is 50:12:950,
%Coordinate y is -100:24:1100

%load topo data for y=950
T1 = load('topo401117.mat');
Topo = (T1(:, 4));
Topo_y1 = T1(:,3);

figure
%Plot the depth_y1, one piece
plot(x_topo, Topo_y1)
xlabel('Crossshore distance(m)')
ylabel('Elevation')
title('Elevation (fixed y = y1)')











