%% Import data for wave height
T = importdata('topo1116.txt');
list = dir('*.txt');
%filesnames is an string array, 1*12
filenames = string({list.name});
sz = size(T);
%save topography data for 12 months in year 2016
topodata = zeros(sz(1), sz(2), 12);
size(topodata(:, :, 1))
S = importdata(filenames(1));
topodata(:, :, 1) = importdata(filenames(1))
for i = 1 : 12
     topodata(:, :, i) = importdata(filenames(i));
end


