clc 
clear all
%% Plot topo 2-D graph
%Load topo data
topo = importdata('topo04112017.txt');
%topo values
x_topo = [50:12:950]';
y_topo = [-100:24:1100]';
topo_2d = reshape(topo(:, 3),[length(x_topo), length(y_topo)]);

figure
subplot(1,2,1)
[X, Y] = meshgrid(x_topo, y_topo);
surf(X, Y, topo_2d')
xlabel('Crossshore distance(m)')
ylabel('Alongshore distance(m)')
zlabel('Elevation')
title('Elevation')
%Height row is Depth on [x, y].
%Coordinate x is 50:12:950,
%Coordinate y is -100:24:1100

%load topo data for y=950
T1 = load('topo041117_global.mat')
Topo_y1 = T1.topo(:, 4);

%Plot the depth_y1, one piece
subplot(1,2,2)
plot(x_topo, Topo_y1)
xlabel('Crossshore distance(m)')
ylabel('Elevation')
title('Elevation (fixed y = 950)')











