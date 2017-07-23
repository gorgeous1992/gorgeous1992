clc
clear all

%% Import data for wave height
T = importdata('topo0527.txt');
sz = size(T)

%need topo for fixed y = 956
yid = find(T(:, 5) == 956);

%data saved as [xcoor, topo_value]
topo = T(yid, [4, 3]);
save('topo052716','topo');