clc
clear all
%% get data
bound = 'https://chlthredds.erdc.dren.mil/thredds/dodsC/frf/oceanography/waves/8m-array/8m-array.ncml';

%% save data bound
%Get time from it.
tt = ncread(bound,'time');
time = tt/(24*3600) + datenum(1970,1,1);
datestr(time(3))

%ncdisp(bound)
%get wave height
waveHs_8 = ncread(bound, 'waveHs');
%get wave frequency
waveF_8 = ncread(bound, 'waveFrequency');
%get wave depth
depth_8 = ncread(bound, 'depth');

bounddata = [waveHs_8(1) waveF_8(1)  depth_8(1)]