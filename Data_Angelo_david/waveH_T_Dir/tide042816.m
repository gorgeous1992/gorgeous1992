clc
clear all
%Import tide data
M = importdata('tide042816.csv');
temp = M.data;
tidedata = [[0:1:23]',temp(:, 1)];

save('tide042816', 'tidedata');


