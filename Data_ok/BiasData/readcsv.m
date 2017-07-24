clc
clear all

tide = importdata('201704tide.csv');
data = tide.data(:, 1);

timedate = string(tide.textdata(:, 1));

id = find(timedate == '2017-04-08 23:00');

datawanted = tide.data(1:id, 1)