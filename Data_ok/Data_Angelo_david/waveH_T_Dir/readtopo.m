clc
clear all

%% Import data for wave height
T = importdata('topo0428.txt');
sz = size(T)

%need topo for fixed y = 956
yid = find(T(:, 5) == 956);

%data saved as [longitude, latitude, xcoor, topo_value]
topo = T(yid, [1, 2, 4, 3]);
save('topo0428_global','topo');