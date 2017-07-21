clc
clear all
%This is the file to read cbathy data
% 07/22/2017 data for cbathy

%% Import data for cbathy
%var is the name of data, download data from link address
var = 'https://chlthredds.erdc.dren.mil/thredds/dodsC/frf/projects/bathyduck/data/cbathy/Bathyduck-ocean_bathy_argus_201607.nc';
%Display the information data contains
%CAUTION: the 1st index is waveid and it has four types of waves.
ncdisp(var)

%tt is the data with time since 01/01/1970 (in seconds)
tt = ncread(var, 'time');

%Put 'tt' in date-form for MATLAB, denote as 'time'
time = tt/(24*3600) + datenum(1970,1,1);

%Pick 07/22/2016 as the date we are interested in
temptime = datenum(2016, 7, 22);

%pause
%find the index of 'temptime' in 'time', save as ii
ii = find(floor(time) == temptime);
%time_col is in minutes for 07/22/16
timeday = time(ii)
time_col = (timeday - timeday(1))*24*60
%Date version
datestr(time(ii));
%pull out needed info from 'var'
%k is the wave number with coordinates on 07/22/17
wavenum = ncread(var, 'k', [1,1,1, min(ii)], [inf , inf, inf, length(ii)]);
%fB is the frequency of the wave with coordinates on 07/22/17
wavefreq = ncread(var, 'fB', [1,1,1, min(ii)], [inf, inf, inf, length(ii)]);

%% Import data for wave height
T = importdata('FRF_20160726_1121_FRF_NAVD88_LARC_GPS_UTC_v20170320_grid_latlon.txt');
class(T);

x_coor = ncread(var, 'xm');
y_coor = ncread(var, 'ym');