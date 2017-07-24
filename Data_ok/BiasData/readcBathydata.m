clc
clear all

var = 'https://chlthredds.erdc.dren.mil/thredds/dodsC/frf/projects/bathyduck/data/cbathy/Bathyduck-ocean_bathy_argus_201704.nc';
%% Get wavenum from cBathy data
%ncdisp(var)

% dateperiod = [datenum(2017, 04, 11, 12, 00, 00), datenum(2017, 04, 11, 12, 00, 00)];
% tt = ncread(var,'time');
% time = tt/(24*3600) + datenum(1970,1,1);
% tm = dateperiod;

dateperiod = datenum(2017, 04, 11, 11, 59, 00);
tt = ncread(var,'time');
time = tt/(24*3600) + datenum(1970,1,1);
tm = dateperiod;

%get all needed time
%id = find(time >= tm(1) & time <= tm(2)+1);
id = find(time == tm);
datestr(time(id));

wavedepth = ncread(var, 'depthKF', [1,1,min(id)], [inf, inf, length(id)]);
xm = ncread(var, 'xm');
ym = ncread(var, 'ym');
yjd = find(ym == 950);

cBathy_depth = [xm, wavedepth(:, yjd, :)];

%wavedepth_data = [xm, wavedepth_1d];
