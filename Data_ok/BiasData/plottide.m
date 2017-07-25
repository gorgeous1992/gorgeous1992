
data = importdata('201704tide.csv')
tidedata = data.data(:, 1)

tidetime = string(data.textdata(:, 1))

id = [find(tidetime == "2017-04-11 00:00"), find(tidetime == "2017-04-12 00:00")]

plot(tidedata(id(1):id(2)))
set(gca, 'xticklabel', tidetime(id(1):id(2)))
ylabel('tide')
title('Hourly Tide data')