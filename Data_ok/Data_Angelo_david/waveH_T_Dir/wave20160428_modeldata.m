clc
clear all
%% get data
%boundary data: 8m_array, x = 900m
Bd_data = 'https://chlthredds.erdc.dren.mil/thredds/dodsC/frf/oceanography/waves/8m-array/2016/FRF-ocean_waves_8m-array_201604.nc';
ncdisp(Bd_data)
%Inside data
awac_6 = 'https://chlthredds.erdc.dren.mil/thredds/dodsC/frf/oceanography/waves/awac-6m/2016/FRF-ocean_waves_awac-6m_201604.nc';
%awac_45 = 'https://chlthredds.erdc.dren.mil/thredds/dodsC/frf/oceanography/waves/awac-4.5m/2017/FRF-ocean_waves_awac-4.5m_201703.nc';
adop_35 = 'https://chlthredds.erdc.dren.mil/thredds/dodsC/frf/oceanography/waves/adop-3.5m_tjh/2016/FRF-ocean_waves_adop-3.5m_201604.nc';
xp150 = 'https://chlthredds.erdc.dren.mil/thredds/dodsC/frf/oceanography/waves/xp150m_tjh/2016/FRF-ocean_waves_xp150m_201604.nc';
xp125 = 'https://chlthredds.erdc.dren.mil/thredds/dodsC/frf/oceanography/waves/xp125m_tjh/2016/FRF-ocean_waves_xp125m_201604.nc';
xp200 = 'https://chlthredds.erdc.dren.mil/thredds/dodsC/frf/oceanography/waves/xp200m_tjh/2016/FRF-ocean_waves_xp200m_201604.nc';

var = 'https://chlthredds.erdc.dren.mil/thredds/dodsC/frf/projects/bathyduck/data/cbathy/Bathyduck-ocean_bathy_argus_201604.nc';
%% Get wavenum from cBathy data
ncdisp(var)
tt = ncread(var,'time');
time = tt/(24*3600) + datenum(1970,1,1);
%pick tm
tm = datenum(2016,04,28);
id = find(floor(time) == tm);
%Pick 04/28/2016 at 11am
timeneed_id = id(12);
wavenum = ncread(var, 'k', [1,1,1,min(id)], [inf , inf, inf, length(id)]);
temp = 1/4*(wavenum(1,:,:,12) + wavenum(2,:,:,12) + ...
    wavenum(3,:,:,12) + wavenum(4,:,:,12))
wavenum = squeeze(temp);
xm = ncread(var, 'xm');
ym = ncread(var, 'ym');
yjd = find(ym == 950);
wavenum_1d = (wavenum(:, yjd));
wavenum_data = [xm, wavenum_1d]
save('wavenum20160428_11am', 'wavenum_data');

%% save data 8m_array ncdisp(var)
tt = ncread(Bd_data,'time');
time = tt/(24*3600) + datenum(1970,1,1);
%pick tm
tm = datenum(2016,04,28);
id = find(floor(time) == tm);
%Pick 04/28/2016 at 11am
timeneed_id = id(12);
%datestr(timeneed);

%get wave height
waveHs = ncread(Bd_data, 'waveHs');
%get wave Timeperiod
waveTp = ncread(Bd_data, 'waveTp');
%get wave depth
depth = ncread(Bd_data, 'depth');

%time 04/28/2016 11:00:00
boundary = [waveHs(timeneed_id), waveTp(timeneed_id), depth(timeneed_id)];

%% save data  awac_6
%Get time from it.
tt = ncread(awac_6,'time');
time = tt/(24*3600) + datenum(1970,1,1);
%pick tm
tm = datenum(2016,04,28);
id = find(floor(time) == tm);
%Pick 04/28/2016 at 11am
timeneed_id = id(12);
%get wave height
waveHs = ncread(awac_6, 'waveHs');
%get waveTp
waveTp = ncread(awac_6, 'waveTp');
%get wave depth
depth = ncread(awac_6, 'depth');

%time 04/28/2016 11:00:00
wave_awac6 = [waveHs(timeneed_id), waveTp(timeneed_id), depth(timeneed_id)];

%% save data  adop_35
%Get time from it.
tt = ncread(adop_35,'time');
time = tt/(24*3600) + datenum(1970,1,1);
%pick tm
tm = 3;
datestr(time(tm));
%get wave height
waveHs = ncread(adop_35, 'waveHs');
%get waveTp
waveTp = ncread(adop_35, 'waveTp');
%get wave depth
depth = ncread(adop_35, 'depth');

%time 04/28/2016 11:00:00
wave_adop35 = [waveHs(timeneed_id), waveTp(timeneed_id), depth(timeneed_id)];

%% save data  xp150
%Get time from it.
tt = ncread(xp150,'time');
time = tt/(24*3600) + datenum(1970,1,1);
%pick tm
tm = datenum(2016,04,28);
id =find(floor(time) == tm);
%Pick 04/28/2016 at 11am
timeneed_id = id(12);
%get wave height

%ncdisp(xp150)
waveHs = ncread(xp150, 'waveHs');
%get waveTm: mean spectral period
waveTm = ncread(xp150, 'waveTm');
%get wave depth
depth = ncread(xp150, 'depthP');




%time 04/28/2016 11:00:00
wave_xp150 = [waveHs(timeneed_id), waveTm(timeneed_id), depth(timeneed_id)];

%% save data  xp125
%Get time from it.
tt = ncread(xp125,'time');
time = tt/(24*3600) + datenum(1970,1,1);
%pick timeneed_id
tm = datenum(2016,04,28);
id = find(floor(time) == tm);
%Pick 04/28/2016 at 11am
timeneed_id = id(12);
%get wave height
waveHs = ncread(xp125, 'waveHs');
%get waveTm: mean spectral period
waveTm = ncread(xp125, 'waveTm');
%get wave depth
%ATTENTION: For xp sensor, depth is a constant
depth = ncread(xp125, 'depthP');

%time 04/28/2016 11:00:00
wave_xp125 = [waveHs(timeneed_id), waveTm(timeneed_id), depth(timeneed_id)];

%% save data  xp200
%Get time from it.
tt = ncread(xp200,'time');
time = tt/(24*3600) + datenum(1970,1,1);
%pick tm
tm = datenum(2016,04,28);
id = find(floor(time) == tm);
%Pick 04/28/2016 at 11am
timeneed = id(12);
%get wave height
waveHs = ncread(xp200, 'waveHs');
%get waveTm: mean spectral period
waveTm = ncread(xp200, 'waveTm');
%get wave depth
%ATTENTION: For xp sensor, depth is a constant
depth = ncread(xp200, 'depthP');



%time 04/28/2016 11:00:00
wave_xp200 = [waveHs(timeneed_id), waveTp(timeneed_id), depth(timeneed_id)];
%% combined data as one matrix
%wavedata is a matrix with data at awac_8m, 6m, 5m each row
%[waveHs waveTp depth]
%Time is at 04/28/2016 11:00:00
wavedata = [boundary; wave_awac6; wave_adop35;...
      wave_xp200; wave_xp150; wave_xp125];
save('wavedata20160428_11am', 'wavedata')