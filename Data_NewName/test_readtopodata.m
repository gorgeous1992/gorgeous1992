%% Import data for wave height
T = importdata('topo1116.txt');
list = dir('*.txt');
%filesnames is an string array, 1*12
filenames = string({list.name});
sz = size(T);
%save topography data for 12 months in year 2016
S1 = importdata(filenames(1));
S2 = importdata(filenames(2));
S3 = importdata(filenames(3));
S4 = importdata(filenames(4));
S5 = importdata(filenames(5));
S6 = importdata(filenames(6));
S7 = importdata(filenames(7));
S8 = importdata(filenames(8));
S9 = importdata(filenames(9));
S10 = importdata(filenames(10));
S11 = importdata(filenames(11));
S12 = importdata(filenames(12));

Depth = reshape(T(:, 3), [76, 51]);
Depth_y1 = [S1([1:76], 3), S2([1:76], 3), S3([1:76], 3), S4([1:76], 3), ...
    S5([1:76], 3), S6([1:76], 3),S7([1:76], 3),S8([1:76], 3),...
    S9([1:76], 3),S10([1:76], 3),S11([1:76], 3),S12([1:76], 3)];
x_depth = [50:12:950]';
y_depth = [-100:24:1100]';


dlmwrite('Topography2016.csv', [Depth_y1])




