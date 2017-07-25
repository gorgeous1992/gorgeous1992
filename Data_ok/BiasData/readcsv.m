clc
clear all

 data = importdata('201704tide.csv')
 
 timestamps = string(data.textdata(:, 1))
 id = [find(timestamps == "2017-04-11 12:00"), ...
     find(timestamps == "2017-04-14 12:00")];
 
 forecasttime = timestamps(id(1):id(2))
 
 datawanted = data.data(id(1):id(2), 1)
 
 %save('filename', 'variable name')
