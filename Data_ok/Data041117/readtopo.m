clc
clear all

%% Import data for wave height
T = importdata('topo041117.txt');
sz = size(T)

xcoor = [50:12:950]';
ycoor = [-100:24:1100]';
topo = reshape(T(:,3), [76, 51]);

% %need topo for fixed y = 956
% yid = find(T(:, 5) == 956);

%data saved as [longitude, latitude, xcoor, topo_value]