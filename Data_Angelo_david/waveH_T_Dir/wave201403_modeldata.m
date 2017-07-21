clc
clear all
%% get data
awac_8 = 'https://chlthredds.erdc.dren.mil/thredds/dodsC/frf/oceanography/waves/awac-8m/2014/FRF-ocean_waves_awac-8m_201403.nc';
awac_6 = 'https://chlthredds.erdc.dren.mil/thredds/dodsC/frf/oceanography/waves/awac-6m/2014/FRF-ocean_waves_awac-6m_201403.nc';
awac_5 = 'https://chlthredds.erdc.dren.mil/thredds/dodsC/frf/oceanography/waves/awac-5m/2014/FRF-ocean_waves_awac-5m_201403.nc';

%% save data awac_8
%Get time from it.
tt = ncread(awac_8,'time');
time = tt/(24*3600) + datenum(1970,1,1);
datestr(time(3))

%ncdisp(awac_8)
%get wave height
waveHs_8 = ncread(awac_8, 'waveHs');
%get wave frequency
waveF_8 = ncread(awac_8, 'waveFrequency');
%get wave depth
depth_8 = ncread(awac_8, 'depth');

%% save data  awac_6
%Get time from it.
tt = ncread(awac_6,'time');
time = tt/(24*3600) + datenum(1970,1,1);
datestr(time(3))
%get wave height
waveHs_6 = ncread(awac_6, 'waveHs');
%get wave frequency
waveF_6 = ncread(awac_6, 'waveFrequency');
%get wave depth
depth_6 = ncread(awac_6, 'depth');

%% save data  awac_5
%Get time from it.
tt = ncread(awac_5,'time');
time = tt/(24*3600) + datenum(1970,1,1);
datestr(time(1))
%get wave height
waveHs_5 = ncread(awac_5, 'waveHs');
%get wave frequency
waveF_5 = ncread(awac_5, 'waveFrequency');
%get wave depth
depth_5 = ncread(awac_5, 'depth');


%% combined data as one matrix
%wavedata is a matrix with data at awac_8m, 6m, 5m each row
%[waveHs waveF depth]
%Time is at 03/01/2014 02:00:00
wavedata = zeros(3, 3);
wavedata(1,:) = [waveHs_8(1) waveF_8(1)  depth_8(1)];
wavedata(2,:) = [waveHs_6(1) waveF_6(1)  depth_6(1)];
wavedata(3,:) = [waveHs_5(1) waveF_5(1)  depth_5(1)];
save('wavedata20140301_2am', 'wavedata')