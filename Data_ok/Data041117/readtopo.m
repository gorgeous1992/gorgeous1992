clc
clear all

%% Import data for wave height
T = importdata('topo010517.txt');
sz = size(T);

%need topo for fixed y = 956
yid = find(T(:, 5) == 956);

%data saved as [longitude, latitude, xcoor, topo_value]
topo = T(yid, [1, 2, 4, 3]);