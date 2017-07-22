clc
clear all
%% get data
%boundary data: 8m_array, x = 900m
Bd_data = 'https://chlthredds.erdc.dren.mil/thredds/dodsC/frf/oceanography/waves/8m-array/2017/FRF-ocean_waves_8m-array_201703.nc';
%Inside data
awac_6 = 'https://chlthredds.erdc.dren.mil/thredds/dodsC/frf/oceanography/waves/awac-6m/2017/FRF-ocean_waves_awac-6m_201703.nc';
awac_45 = 'https://chlthredds.erdc.dren.mil/thredds/dodsC/frf/oceanography/waves/awac-4.5m/2017/FRF-ocean_waves_awac-4.5m_201703.nc';
adop_35 = 'https://chlthredds.erdc.dren.mil/thredds/dodsC/frf/oceanography/waves/adop-3.5m/2017/FRF-ocean_waves_adop-3.5m_201703.nc';
xp150 = 'https://chlthredds.erdc.dren.mil/thredds/dodsC/frf/oceanography/waves/xp150m/2017/FRF-ocean_waves_xp150m_201703.nc';
xp125 = 'https://chlthredds.erdc.dren.mil/thredds/dodsC/frf/oceanography/waves/xp125m/2017/FRF-ocean_waves_xp125m_201703.nc';


%% save data 8m_array
tt = ncread(Bd_data,'time');
time = tt/(24*3600) + datenum(1970,1,1);
%pick tm
tm = 3;
datestr(time(tm));
%get wave height
waveHs = ncread(Bd_data, 'waveHs');
%get wave frequency
waveF = ncread(Bd_data, 'waveFrequency');
%get wave depth
depth = ncread(Bd_data, 'depth');
%time 01-Mar-2017 02:00:00
boundary = [waveHs(tm), waveF(tm), depth(tm)];

%% save data  adop_35
%Get time from it.
tt = ncread(adop_35,'time');
time = tt/(24*3600) + datenum(1970,1,1);
%pick tm
tm = 3;
datestr(time(tm));
%get wave height
waveHs = ncread(adop_35, 'waveHs');
%get wave frequency
waveF = ncread(adop_35, 'waveFrequency');
%get wave depth
depth = ncread(adop_35, 'depth');

%time 01-Mar-2017 02:00:00
wave_adop35 = [waveHs(tm), waveF(tm), depth(tm)];

%% save data  awac_6
%Get time from it.
tt = ncread(awac_6,'time');
time = tt/(24*3600) + datenum(1970,1,1);
%pick tm
tm = 3;
datestr(time(tm));
%get wave height
waveHs = ncread(awac_6, 'waveHs');
%get wave frequency
waveF = ncread(awac_6, 'waveFrequency');
%get wave depth
depth = ncread(awac_6, 'depth');

%time 01-Mar-2017 02:00:00
wave_awac6 = [waveHs(tm), waveF(tm), depth(tm)];


%% save data  awac_45
%Get time from it.
tt = ncread(awac_45,'time');
time = tt/(24*3600) + datenum(1970,1,1);
%pick tm
tm = 3;
datestr(time(tm));
%get wave height
waveHs = ncread(awac_45, 'waveHs');
%get wave frequency
waveF = ncread(awac_45, 'waveFrequency');
%get wave depth
depth = ncread(awac_45, 'depth');

%time 01-Mar-2017 02:00:00
wave_awac45 = [waveHs(tm), waveF(tm), depth(tm)];
%% save data  xp150
%Get time from it.
tt = ncread(xp150,'time');
time = tt/(24*3600) + datenum(1970,1,1);
%pick tm
tm = 3;
datestr(time(tm));
%get wave height
waveHs = ncread(xp150, 'waveHs');
%get wave frequency
waveF = ncread(xp150, 'waveFrequency');
%get wave depth
depth = ncread(xp150, 'depth');

%time 01-Mar-2017 02:00:00
wave_xp150 = [waveHs(tm), waveF(tm), depth];

%% save data  xp125
%Get time from it.
tt = ncread(xp125,'time');
time = tt/(24*3600) + datenum(1970,1,1);
%pick tm
tm = 3;
datestr(time(tm));
%get wave height
waveHs = ncread(xp125, 'waveHs');
%get wave frequency
waveF = ncread(xp125, 'waveFrequency');
%get wave depth
%ATTENTION: For xp sensor, depth is a constant
depth = ncread(xp125, 'depth');

%time 01-Mar-2017 02:00:00
wave_xp125 = [waveHs(tm), waveF(tm), depth];

%% combined data as one matrix
%wavedata is a matrix with data at awac_8m, 6m, 5m each row
%[waveHs waveF depth]
%Time is at 03/01/2017 02:00:00
wavedata = [boundary; wave_awac6; wave_awac45; wave_adop35;...
      wave_xp150; wave_xp125];
save('wavedata20170301_2am', 'wavedata')