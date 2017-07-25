clc
clear all

 data = importdata('201701tide.csv')
 
 timestamps = string(data.textdata(:, 1))
 id = [find(timestamps == "2017-01-01 12:00"), ...
     find(timestamps == "2017-01-31 20:00")];
 
 forecasttime = timestamps(id(1):id(2))
 
 datawanted = data.data(id(1):id(2), 1)
 
 %save('filename', 'variable name')
