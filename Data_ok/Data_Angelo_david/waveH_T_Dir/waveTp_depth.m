clc
clear all
%This is the file to read cbathy data
% 04/28/2016 data for cbathy

%% Import data for cbathy
%var is the name of data, download data from link address
var = 'https://chlthredds.erdc.dren.mil/thredds/dodsC/frf/projects/bathyduck/data/cbathy/Bathyduck-ocean_bathy_argus_201604.nc';
%Display the information data contains
%CAUTION: the 1st index is waveid and it has four types of waves.
ncdisp(var)

%tt is the data with time since 01/01/1970 (in seconds)
tt = ncread(var, 'time');

%Put 'tt' in date-form for MATLAB, denote as 'time'
time = tt/(24*3600) + datenum(1970,1,1);

%Pick 04/28/2016 as the date we are interested in
temptime = datenum(2016, 04, 28);

%pause
%find the index of 'temptime' in 'time', save as ii
ii = find(floor(time) == temptime);
%time_col is in minutes for 07/22/16
timeday = time(ii);
time_col = (timeday - timeday(1))*24*60;
%Date version
datestr(time(ii));
%pull out needed info from 'var'
%k is the wave number with coordinates on the date
wavenum = ncread(var, 'k', [1,1,1, min(ii)], [inf , inf, inf, length(ii)]);
%fB is the frequency of the wave with coordinates on the date
wavefreq = ncread(var, 'fB', [1,1,1, min(ii)], [inf, inf, inf, length(ii)]);

x_coor = ncread(var, 'xm');
y_coor = ncread(var, 'ym');
%% Import data for wave height
T = importdata('topo0428.txt');
class(T);
%Find the fixed y=956, which is the closest to y = 950
topo_y956 = T(find(T(:, 5) == 956), 3);
%Take the depth 
%The time is 04/28/2016 11:18:00

save('topograpy_y956_042816_1118', 'topo_y956');


